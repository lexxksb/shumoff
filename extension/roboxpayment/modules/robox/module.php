<?php

$Module = array("name" => "ROBOX");

$ViewList = array();
$ViewList["result"] = array(
        "functions" => array( 'buy' ), 
        "script" => "result.php");

$ViewList["success"] = array(
    "functions" => array( 'buy' ),
    "script" => "success.php");

$ViewList["fail"] = array(
    "functions" => array( 'buy' ),
    "script" => "fail.php");

$FunctionList = array();
$FunctionList['buy'] = array( );

