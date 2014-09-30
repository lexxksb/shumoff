<?php
/*
 * 
 * CREATE TABLE IF NOT EXISTS `ezorder_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0',
  `paymenttype` VARCHAR( 100 ) NOT NULL,
  `created` int(11) NOT NULL,
  `amount` float NOT NULL,
  `currency` varchar(10) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `response` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8
 * 
 * */
  
class eZOrderLog extends eZPersistentObject
{
	function eZOrderLog($row)
	{
		$this->eZPersistentObject ( $row );
	}
	
	static function definition()
	{
		return array ("fields" => array (
			"id" => array ('name' => 'ID', 'datatype' => 'integer', 'default' => 0, 'required' => true ),
			"order_id" => array ('name' => "OrderId", 'datatype' => 'integer', 'default' => 0, 'required' => true ),
      "paymenttype" => array ('name' => "Paymenttype", 'datatype' => 'string', 'default' => '', 'required' => true ),
      "created" => array ('name' => "Created", 'datatype' => 'integer', 'default' => 0, 'required' => true ),
			"amount" => array ('name' => "Amount", 'datatype' => 'float', 'default' => 0, 'required' => true ),
			"currency" => array ('name' => "Currency", 'datatype' => 'text', 'default' => '', 'required' => true ),
			"email" => array ('name' => "EMail", 'datatype' => 'text', 'default' => '', 'required' => true ),
			"transaction_id" => array ('name' => "TransactionID", 'datatype' => 'text', 'default' => '', 'required' => true ),
			"payment_id" => array ('name' => "PaymentID", 'datatype' => 'text', 'default' => '', 'required' => true ),
			"client_id" => array ('name' => "ClientID", 'datatype' => 'text', 'default' => '', 'required' => true ),
			"response" => array ('name' => "Response", 'datatype' => 'text', 'default' => '', 'required' => true )
		),
		"keys" => array( "id" ),
		"increment_key" => "id",
		"class_name" => "eZOrderLog",
		"name" => "ezorder_log" );
	}
	
	static function fetch( $id, $asObject = true )
    {
        return eZPersistentObject::fetchObject( eZOrderLog::definition(),
                                                null,
                                                array( "id" => $id ),
                                                $asObject );
    }
    
	static function fetchByOrderId( $orderID, $asObject = true )
    {
        return eZPersistentObject::fetchObject( eZOrderLog::definition(),
                                                null,
                                                array( "order_id" => $orderID ),
                                                $asObject );
    }
    
	static function fetchByEmail( $email, $asObject = true )
    {
        return eZPersistentObject::fetchObjectList( eZOrderLog::definition(),
                                                    null,
                                                    array( "email" => $email ), 
                                                    array( "created" => "desc" ), null,
                                                    $asObject );
    }
    
    static function fetchCount( $orderID )
    {
        $db = eZDB::instance();

        $orderID = (int)$orderID;
        $countArray = $db->arrayQuery(  "SELECT count( * ) AS count FROM ezorder_log WHERE order_id = $orderID" );
        return $countArray[0]['count'];
    }

    }


?>