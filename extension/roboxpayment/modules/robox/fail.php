<?php 

$http = eZHTTPTool::instance();
$module = $Params['Module'];
$ini = eZINI::instance('robox.ini');
$Result = array();
$tpl = eZTemplate::factory();

$OutSum = $http->postVariable("OutSum");
$InvId = $orderID =  $http->postVariable("InvId");

$order = eZOrder::fetch($orderID);
$order->purge();

$Result['content'] = $tpl->fetch("design:roboxpayment/fail.tpl");
$Result['path'] = array(array('url' => false, 'text' => ezpI18n::tr('kernel/shop', 'Checkout')));
return;

?>