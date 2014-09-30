<?php

define('EZ_PAYMILL_BASE', 'paymill');
define('EZ_PAYMILL_STATE_CANCEL', 2);
define('EZ_PAYMILL_STATE_VALID', 5);

class eZPaymillGateway extends eZPaymentGateway {
  const GATEWAY_NAME = "ezpaymill";

  /*!
   Constructor.
   */
  function eZPaymillPaymentGateway() {
    $this->logger = eZPaymentLogger::CreateForAdd("var/log/eZPaymillGateway.log");
    $this->logger->writeTimedString('eZPaymillGateway::eZPaymillGateway');
  }

  function execute($process, $event) {
    $this->logger->writeTimedString("execute");
    $this->logger->writeTimedString("event_state:" . $process->attribute('event_state'));

    $processParameters = $process->attribute('parameter_list');
    $processID = $process->attribute('id');

    // get order id
    $orderID = $processParameters['order_id'];
    // get order
    $order = eZOrder::fetch($orderID);
    $accountInfo = $order->accountInformation();

    $user_id = $accountInfo['user_id'];
    $orderTotalIncVAT = $order->totalIncVAT();

    $http = eZHTTPTool::instance();
    $this->fetchInput($http, EZ_PAYMILL_BASE, $event, $process);

    if ($process->attribute('event_state') == EZ_PAYMILL_STATE_CANCEL) {
      return eZWorkflowType::STATUS_WORKFLOW_CANCELLED;
    }

    if ($process->attribute('event_state') != EZ_PAYMILL_STATE_VALID) {
      $orderLogArray = eZOrderLog::fetchByEmail($accountInfo['email']);

      $process->Template = array();
      $process->Template['templateName'] = 'design:ezpaymill/payment-form.tpl';
      $process->Template['templateVars'] = array('process' => $process, 'event' => $event, 'base' => EZ_PAYMILL_BASE, 'order_total_inc_vat' => $orderTotalIncVAT, 'order' => $order, 'order_id' => $orderID, 'order_log_array' => $orderLogArray);
      return eZWorkflowType::STATUS_FETCH_TEMPLATE_REPEAT;
    }

    return eZWorkflowType::STATUS_ACCEPTED;
  }

  function fetchInput($http, $base, $event, $process) {
    if ($http->hasPostVariable('order_id') and $http->postVariable('order_id')) {
      // get order id
      $orderID = $http->postVariable('order_id');
      // get order
      $order = eZOrder::fetch($orderID);
      $accountInfo = $order->accountInformation();

      if ($http->hasPostVariable('paymillToken') and $http->postVariable('paymillToken')) {
        $paymillToken = $http->postVariable('paymillToken');

        if ($http->hasPostVariable('amount') and $http->postVariable('amount')) {
          $amount = $http->postVariable('amount');
          $ini = eZINI::instance('ezpaymill.ini');

          $paymillPrivateApiKey = ( $ini->variable('PaymillSettings', 'IsTestOrLive') === 'TEST' ) ? $ini->variable('PaymillSettings', 'PAYMILL_PRIVATE_TEST_KEY') : $ini->variable('PaymillSettings', 'PAYMILL_PRIVATE_LIVE_KEY');
          $paymillApiEndpoint = 'https://api.paymill.de/v2/';

          // setup client params
          $clientParams = array('email' => $accountInfo['email'], 'description' => $accountInfo['last_name'] . ', ' . $accountInfo['first_name']);
          // setup credit card params
          $creditcardParams = array('token' => $paymillToken);
          // setup transaction params
          $transactionParams = array('amount' => $amount, 'currency' => 'EUR', 'token' => $creditcardToken, 'description' => $orderID . ': ' . $accountInfo['last_name'] . ', ' . $accountInfo['first_name']);

          // Access objects for the Paymill API
          $clientsObject = new Services_Paymill_Clients($paymillPrivateApiKey, $paymillApiEndpoint);

          $creditcardsObject = new Services_Paymill_Payments($paymillPrivateApiKey, $paymillApiEndpoint);

          $transactionsObject = new Services_Paymill_Transactions($paymillPrivateApiKey, $paymillApiEndpoint);

          try {
            // create client
            $client = $clientsObject->create($clientParams);

            // create card
            $creditcardParams['client'] = $client['id'];
            $creditcard = $creditcardsObject->create($creditcardParams);

            // create transaction
            $transactionParams['payment'] = $creditcard['id'];
            $transactionParams['client'] = $client['id'];
            $transaction = $transactionsObject->create($transactionParams);

            if (is_array($transaction) && array_key_exists('status', $transaction)) {
              if ($transaction['status'] == "closed") {
                $time = time();

                $orderlog = new eZOrderLog( 
                                           array(
                                            'order_id' => $orderID, 
                                            'paymenttype'=> 'ezpaymill', 
                                            'order_number' => '', 
                                            'created' => $time, 
                                            'amount' => $amount, 
                                            'currency' => 'EUR', 
                                            'email' => $accountInfo['email'], 
                                            'transaction_id' => $transaction['id'], 
                                            'payment_id' => $transaction['payment']['id'], 
                                            'client_id' => $transaction['client']['id'], 
                                            'response' => serialize($transaction)
                                          )
                                        );
                $db = eZDB::instance();
                $db->begin();
                $orderlog->store();
                $db->commit();

                $process->setAttribute('event_state', EZ_PAYMILL_STATE_VALID);

              } elseif ($transaction['status'] == "open") {
                throw new Exception("Zahlung fehlgeschlagen.");
              } else {
                throw new Exception("Zahlung fehlgeschlagen.");
              }
            } else {
              throw new Exception("Zahlung fehlgeschlagen.");
            }
          } catch (Exception $ex) {
            echo "exception";
          }
        }
      }
    }

    
  }

}

eZPaymentGatewayType::registerGateway(eZPaymillGateway::GATEWAY_NAME, "eZPaymillGateway", "Kreditkarte");

?>