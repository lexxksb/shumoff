<?php

$Module = array( "name" => "Lexx store" );

$ViewList = array();

$ViewList["basket"] = array(
    "functions" => array( 'buy' ),
    "script" => "basket.php",
    "default_navigation_part" => 'ezmynavigationpart',
    'unordered_params' => array( 'error' => 'Error' ),
    "params" => array(  ) );

$ViewList['updatebasket'] = array(
    'functions' => array( 'buy' ),
    'script' => 'updatebasket.php',
    'default_navigation_part' => 'ezshopnavigationpart',
    'params' => array(  ) );

$ViewList["confirmorder"] = array(
    "functions" => array( 'buy' ),
    "script" => "confirmorder.php",
    "default_navigation_part" => 'ezshopnavigationpart',
    "params" => array(  ) );

$ViewList["action"] = array(
    "functions" => array( 'buy' ),
    "script" => "action.php",
    "default_navigation_part" => 'ezshopnavigationpart',
    "params" => array(  ) );

$FunctionList = array();
$FunctionList['buy'] = array( );
