<?php
class StoreShippingHandler
{
    function getShippingInfo( $productCollectionID )
    {
        list($name, $cost) = $this->_fetch();
        return array(
            'description'     => $name,
            'cost'            => $cost,
            'vat_value'       => 0,
            'is_vat_inc'      => 0,
            'management_link' => '' // dummy
        );
    }
    function purgeShippingInfo( $productCollectionID )
    {
        // nothing to purge
    }
    function updateShippingInfo( $productCollectionID )
    {
        list($name, $cost) = $this->_fetch();
        return array(
            'description' => $name,
            'cost'        => $cost
        );
    }
    
    function _fetch(){
        $data = storeParseConfig::shipping();
        if(isset($_COOKIE["shipping"]) && $select = $_COOKIE["shipping"])
            $def = $select;
        else
            $def = $data["default"];
        return array($data["types"][$def]["name"], $data["types"][$def]["cost"]);
    }
    
}