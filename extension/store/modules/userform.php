<?php

$user = eZUser::currentUser();

$firstName = '';
$lastName = '';
$email = '';
if ($user->isRegistered()) {
	$userObject = $user->attribute('contentobject');
	$userMap = $userObject->dataMap();
	$firstName = $userMap['first_name']->content();
	$lastName = $userMap['last_name']->content();
	$email = $user->attribute('email');
}

// Initialize variables
$street1 = $street2 = $zip = $place = $state = $country = $comment = $payment = $phone = '';

// Check if user has an earlier order, copy order info from that one
$orderList = eZOrder::activeByUserID($user->attribute('contentobject_id'));
if (count($orderList) > 0 and $user->isRegistered()) {
	$accountInfo = $orderList[0]->accountInformation();
	$street1 = $accountInfo['street1'];
	$street2 = $accountInfo['street2'];
	$zip = $accountInfo['zip'];
	$place = $accountInfo['place'];
	$state = $accountInfo['state'];
	$country = $accountInfo['country'];
}

$tpl->setVariable("input_error", false);
if ( $http->hasPostVariable( "CheckoutButton" ) or ( $doCheckout === true ) ){

    $inputIsValid = true;
    
    $firstName = $http->postVariable("FirstName");
    $lastName = $http->postVariable("LastName");
    $email = $http->postVariable("EMail");
    $state = $http->postVariable("State");
    $street1 = $http->postVariable("Street1");
//    $street2 = $http->postVariable("Street2");
    $zip = $http->postVariable("Zip");
    $place = $http->postVariable("Place");
    $phone = $http->postVariable("phone");
    $comment = $http->postVariable("Comment");
    $compliance = $http->postVariable("Compliance");
    $shipping = $http->postVariable("shipping");
    $payment = $http->postVariable("payment");

    if(empty($compliance)){
        $inputIsValid = false;
    }

    if (trim($firstName) == "")
        $inputIsValid = false;
    if (trim($phone) == "")
        $inputIsValid = false;

    if ($inputIsValid == true) {
    	// Check for validation
    	$basket = eZBasket::currentBasket();
    
    	$db = eZDB::instance();
    	$db->begin();
    	$order = $basket->createOrder();
    
    	$doc = new DOMDocument('1.0', 'utf-8');
    
    	$root = $doc->createElement("shop_account");
    	$doc->appendChild($root);
    
    	$firstNameNode = $doc->createElement("first-name", $firstName);
    	$root->appendChild($firstNameNode);
    
    	$lastNameNode = $doc->createElement("last-name", $lastName);
    	$root->appendChild($lastNameNode);
    
    	$emailNode = $doc->createElement("email", $email);
    	$root->appendChild($emailNode);
    
    	$street1Node = $doc->createElement("street1", $street1);
    	$root->appendChild($street1Node);
    
    	$street2Node = $doc->createElement("street2", $street2);
    	$root->appendChild($street2Node);
    
    	$zipNode = $doc->createElement("zip", $zip);
    	$root->appendChild($zipNode);
    
    	$placeNode = $doc->createElement("place", $place);
    	$root->appendChild($placeNode);
    
    	$stateNode = $doc->createElement("state", $state);
    	$root->appendChild($stateNode);
    
    	$countryNode = $doc->createElement("country", $country);
    	$root->appendChild($countryNode);
    
    	$commentNode = $doc->createElement("comment", $comment);
    	$root->appendChild($commentNode);
    	
    	$commentNode = $doc->createElement("shipping", $shipping);
    	$root->appendChild($commentNode);
    	
    	$commentNode = $doc->createElement("payment", $payment);
    	$root->appendChild($commentNode);
    	
    	$commentNode = $doc->createElement("phone", $phone);
    	$root->appendChild($commentNode);
    
    	$xmlString = $doc->saveXML();
    
    	$order->setAttribute('data_text_1', $xmlString);
    	$order->setAttribute('account_identifier', "ez");
    
    	$order->setAttribute('ignore_vat', 0);
    
    	$order->store();
    	$db->commit();
    	eZShopFunctions::setPreferredUserCountry($country);
    	$http->setSessionVariable('MyTemporaryOrderID', $order->attribute('id'));
    
    	unset($_SESSION["input_error"]);
    	
    	//$module->redirectTo('/shop/confirmorder/');
    	//return;
    } else {
    	$tpl->setVariable("input_error", true);
    	$http->setSessionVariable('input_error', true);
    }
}

$tpl->setVariable("first_name", $firstName);
$tpl->setVariable("last_name", $lastName);
$tpl->setVariable("email", $email);
$tpl->setVariable("phone", $phone);
$tpl->setVariable("street1", $street1);
$tpl->setVariable("street2", $street2);
$tpl->setVariable("zip", $zip);
$tpl->setVariable("place", $place);
$tpl->setVariable("state", $state);
// $tpl->setVariable("country", $country);
$tpl->setVariable("comment", $comment);
$tpl->setVariable("payment", $payment);
