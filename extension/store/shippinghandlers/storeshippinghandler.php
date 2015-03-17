<?php
class StoreShippingHandler{

    public $totalPrice = 0;
    public $collectionId = 0;

    function getShippingInfo( $productCollectionID ){

        $this->collectionId = $productCollectionID;

        list($name, $cost) = $this->_fetch();

        return array(
            'description'     => $name,
            'cost'            => $this->shipCost($cost),
            'vat_value'       => 0,
            'is_vat_inc'      => 0,
            'management_link' => '' // dummy
        );
    }
    function purgeShippingInfo( $productCollectionID ){
        // nothing to purge
    }
    function updateShippingInfo( $productCollectionID ){

        $this->collectionId = $productCollectionID;

        list($name, $cost) = $this->_fetch();
        return array(
            'description' => $name,
            'cost'        => $this->shipCost($cost)
        );
    }

    private function getTotalCost(){
        if(empty($this->totalPrice)){
            return $this->totalPrice = $this->calcTotalPrice($this->collectionId);
        }else{
            return $this->totalPrice;
        }
    }

    private function shipCost($cost = 0){
        $ini            = eZINI::instance( 'store.ini' );
        $freeShipSumm   = (int)$ini->variable( "General", "freeShipSumm" );
        return $this->getTotalCost() < $freeShipSumm ? $cost : 0;
    }

    private function _fetch(){
        $data = storeParseConfig::shipping();
        $selectShipping = !empty($_COOKIE["shipping"]) ? $_COOKIE["shipping"] : $data["default"];
        return array($data["types"][$selectShipping]["name"], $data["types"][$selectShipping]["cost"]);
    }

    private function calcTotalPrice($productCollectionID){
        if(empty($productCollectionID)) return null;
        $pCollection = (new eZProductCollection($productCollectionID))->itemList(false);
        $count = 0;
        foreach($pCollection as $pc){
            $count += $pc["price"] * $pc["item_count"];
        }
        return $count;
    }

}