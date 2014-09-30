<?php

class storeParseConfig{
	
    public static function shipping(){
        $ini = eZINI::instance( 'store.ini' );
        $types = $ini->variable( "Shipping", "type" );
        foreach ($types as &$type){
            $ntype[$type] = array(
                "code" => $type,
                "name" => $ini->variable( $type."info", "name" ),
                "description" => $ini->variable( $type."info", "description" ),
                "cost" => $ini->variable( $type."info", "cost" )
            ); 
        }
        $data["types"] = $ntype;
        $data["default"] = $ini->variable( "Shipping", "default" );
        return $data;
    }
    
    public static function payment(){
        $ini = eZINI::instance( 'store.ini' );
        $types = $ini->variable( "Payment", "type" );
        foreach ($types as &$type){
            $ntype[$type] = array(
                "code" => $type,
                "name" => $ini->variable( $type."info", "name" ),
                "description" => $ini->variable( $type."info", "description" ),
                "cost" => $ini->variable( $type."info", "cost" )
            );
        }
        $data["types"] = $ntype;
        $data["default"] = $ini->variable( "Payment", "default" );
        return $data;
    }
    
}
