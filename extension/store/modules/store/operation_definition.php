<?php 

$OperationList = array();
$OperationList['confirmorder'] = array( 'name' => 'confirmorder',
                                        'default_call_method' => 
                                            array( 'include_file' => 'kernel/shop/ezshopoperationcollection.php',
                                                    'class' => 'eZShopOperationCollection' ),
                                        'parameter_type' => 'standard',
                                        'parameters' => array( 
                                            array( 'name' => 'order_id',
                                                    'type' => 'integer',
                                                    'required' => true ) ),
                                        'keys' => array( 'order_id' ),
                                        'body' => array( /*array( 'type' => 'trigger',
                                                                'name' => 'pre_confirmorder',
                                                                'keys' => array( 'order_id' ) ),*/
                                                            array( 'type' => 'method',
                                                                'name' => 'handle-user-country',
                                                                'frequency' => 'once',
                                                                'method' => 'handleUserCountry' ),
                                                            array( 'type' => 'method',
                                                                'name' => 'handle-shipping',
                                                                'frequency' => 'once',
                                                                'method' => 'handleShipping' ),
                                                            array( 'type' => 'method',
                                                                'name' => 'fetch-order',
                                                                'frequency' => 'once',
                                                                'method' => 'fetchOrder' ) )
                                          );

?>