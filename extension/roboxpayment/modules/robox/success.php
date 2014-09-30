<?php

$http = eZHTTPTool::instance();
$module = $Params['Module'];
$ini = eZINI::instance('robox.ini');
$Result = array();
$tpl = eZTemplate::factory();

$OutSum = $http->postVariable("OutSum");
$InvId = $orderID =  $http->postVariable("InvId");
$SignatureValue = $http->postVariable("SignatureValue");

$my_crc = strtoupper(md5($OutSum . ":" . $InvId . ":" . $ini->variable('PaySettings', 'pass1')));

if (strtoupper($my_crc) != strtoupper($SignatureValue)) {
    $http->removeSessionVariable("CheckoutAttempt");
    //$tpl->setVariable ("ErrorCode", "bad sign");
    //$tpl->setVariable ("OrderID", $orderID);
    $Result['content'] = $tpl->fetch("design:roboxpayment/cancelcheckout.tpl");
    $Result['path'] = array(array('url' => false, 'text' => ezpI18n::tr('kernel/shop', 'Checkout')));
    return;
} else {

    $order = eZOrder::fetch($orderID);
    if ($order->attribute('is_temporary') == 1) {
        $email = $order->accountEmail();
        $order->setAttribute('email', $email);
        $order->store();

        $http->setSessionVariable("UserOrderID", $order->attribute('id'));

        $operationResult = eZOperationHandler::execute('shop', 'checkout',
                array('order_id' => $order->attribute('id')));
        switch ($operationResult['status']) {
            case eZModuleOperationInfo::STATUS_HALTED:
            case eZModuleOperationInfo::STATUS_REPEAT: {
                    if (isset($operationResult['redirect_url'])) {
                        $module->redirectTo($operationResult['redirect_url']);
                        return;
                    } else if (isset($operationResult['result'])) {
                        $result = $operationResult['result'];
                        $resultContent = false;
                        if (is_array($result)) {
                            if (isset($result['content'])) {
                                $resultContent = $result['content'];
                            }
                            if (isset($result['path'])) {
                                $Result['path'] = $result['path'];
                            }
                        } else
                            $resultContent = $result;
                        $Result['content'] = $resultContent;
                        return;
                    }
                }
                break;
            case eZModuleOperationInfo::STATUS_CANCELLED: {
                    $Result = array();

                    $tpl->setVariable('operation_result', $operationResult);

                    $Result['content'] = $tpl->fetch("design:roboxpayment/cancelcheckout.tpl");
                    $Result['path'] = array(
                            array('url' => false, 'text' => ezpI18n::tr('kernel/shop', 'Checkout')));

                    return;
                }
        }
    }else{
        $http->removeSessionVariable( "CheckoutAttempt" );
    }

    $module->redirectTo( '/shop/orderview/' . $orderID );
    return;
    
    echo "OK$InvId\n";
}

eZExecution::cleanExit();

?>