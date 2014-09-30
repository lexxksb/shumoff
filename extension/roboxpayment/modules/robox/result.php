<?php

$http = eZHTTPTool::instance();
$module = $Params['Module'];
$ini = eZINI::instance('robox.ini');

$OutSum = $http->postVariable("OutSum");
$InvId = $http->postVariable("InvId");
$SignatureValue = $http->postVariable("SignatureValue");

$my_crc = strtoupper(md5($OutSum . ":" . $InvId . ":" . $ini->variable('PaySettings', 'pass2')));

if (strtoupper($my_crc) != strtoupper($SignatureValue)) {
    echo "bad sign\n";
} else {
    echo "OK$InvId\n";
}

eZExecution::cleanExit();

?>