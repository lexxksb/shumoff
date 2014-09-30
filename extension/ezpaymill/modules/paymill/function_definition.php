<?php


/*! \file function_definition.php
*/

$FunctionList = array();

$FunctionList['paymenttype'] = array( 'name' => 'paymenttype',
                                 'operation_types' => array( 'read' ),
                                 'call_method' => array( 'class' => 'eZPaymillFunctionCollection',
                                                         'method' => 'fetchByOrderId' ),
                                 'parameter_type' => 'standard',
                                 'parameters' => array( array( 'name' => 'order_id',
                                                               'type' => 'integer',
                                                               'required' => true ),
                                                        array( 'name' => 'as_object',
                                                               'type' => 'integer',
                                                               'required' => false )
                            ) );
?>