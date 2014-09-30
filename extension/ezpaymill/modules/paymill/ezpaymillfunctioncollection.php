<?php

class eZPaymillFunctionCollection {



  static function fetchByOrderId( $order_id, $as_object = true ) {
    $db = eZDB::instance();
    
    $result = eZOrderLog::fetchByOrderId( $order_id, $as_object );

    return array( 'result' => $result );   
  } 


}

?>
