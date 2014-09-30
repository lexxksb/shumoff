<?php
/**
 * @copyright Copyright (C) 2008 land in sicht AG All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 */

class lisShippingCostsType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = 'lisshippingcosts';

    function lisShippingCostsType()
    {
        $this->eZWorkflowEventType( lisShippingCostsType::WORKFLOW_TYPE_STRING, /*ezi18n( 'kernel/workflow/event',*/ "lis shipping costs" /*)*/);
        $this->setTriggerTypes( array( 'shop' => array( 'confirmorder' => array ( 'before' ))));
    }

    function execute( $process, $event )
    {
        $ini = eZINI::instance( 'lisshippingcosts.ini' );

        $cost = $ini->variable( "lisShippingCosts", "costs" );
        $description = $ini->variable( "lisShippingCosts", "description" );
        $minPrice = $ini->variable( "lisShippingCosts", "minPrice" );
        
        $parameters = $process->attribute( 'parameter_list' );

        if ( isset( $parameters['order_id'] ) )
        {
            $orderID = $parameters['order_id'];

            $order = eZOrder::fetch( $orderID );
            $orderPrice = $order->totalIncVAT();
            $orderItems = $order->attribute( 'order_items' );
            
            //eZDebug::writeNotice( $orderPrice, "orderprice $orderPrice" );
            
            $addShipping = true;
            foreach ( $orderItems as $orderItem )
            {
                if ( $orderItem->attribute( 'type' ) == 'lisshippingcosts' )
                {
                    $addShipping = false;
                    if ( (int)$orderPrice > (int)$minPrice )
                    {
                        $orderItem->remove();
                    }
                    break;
                }                
            }
            
            if ($addShipping && (int)$orderPrice > (int)$minPrice)
            {
                //eZDebug::writeNotice( "shippingcosts", "adding shipping" );
                $productCollection = $order->attribute( 'productcollection' );
                $orderCurrency = $productCollection->attribute( 'currency_code' );

                //include_once( 'kernel/shop/classes/ezshopfunctions.php' );
                $cost = eZShopFunctions::convertAdditionalPrice( $orderCurrency, $cost );

                $orderItem = new eZOrderItem( array( 'order_id' => $orderID,
                                                     'description' => $description,
                                                     'price' => $cost,
                                                     'type' => 'lisshippingcosts' )
                                              );
                $orderItem->store();
            }
        }
        return eZWorkflowType::STATUS_ACCEPTED;
    }
}
eZWorkflowEventType::registerEventType( lisShippingCostsType::WORKFLOW_TYPE_STRING, "lisShippingCostsType" );
?>