<?php
/**
 * @copyright Copyright (C) 1999-2013 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version //autogentag//
 * @package kernel
 */

$http = eZHTTPTool::instance();
$module = $Params['Module'];
$ini = eZINI::instance('store.ini');
// $tpl = eZTemplate::factory();
// $tpl->setVariable("module_name", 'shop');

$orderID = $http->sessionVariable('MyTemporaryOrderID');

$order = eZOrder::fetch($orderID);
if (!is_object($order))
    return $Module->handleError(eZError::KERNEL_NOT_AVAILABLE, 'kernel');

$paymentName = '';
$needRedirect = false;
$xmlString = $order->attribute('data_text_1');
if ($xmlString != null) {
    $dom            = new DOMDocument('1.0', 'utf-8');
    $success        = $dom->loadXML($xmlString);
    $node           = $dom->getElementsByTagName('payment')->item(0);
    $paymentName    = $node->textContent;
    $needRedirect   = (bool) $ini->variable($paymentName . 'info', 'redirect');
}

// if ( $order instanceof eZOrder )
// {
//     if ( $http->hasPostVariable( "ConfirmOrderButton" ) )
//     {
//         $order->detachProductCollection();
//         $ini = eZINI::instance();
//         if ( $ini->variable( 'ShopSettings', 'ClearBasketOnCheckout' ) == 'enabled' )
//         {
//             $basket = eZBasket::currentBasket();
//             $basket->remove();
//         }
//         $module->redirectTo( '/shop/checkout/' );
//         return;
//     }

//     if ( $http->hasPostVariable( "CancelButton" ) )
//     {
//         $order->purge( /*$removeCollection = */ false );
//         $module->redirectTo( '/shop/basket/' );
//         return;
//     }

//     $tpl->setVariable( "order", $order );
// }

$basket = eZBasket::currentBasket();
$basket->updatePrices();

if($needRedirect){
    $handle = new eZShopOperationCollection();
    $handle->handleShipping($order->attribute('id'));
    $operationResult = eZOperationHandler::execute('shop', 'confirmorder', array('order_id' => $order->attribute('id')));
}else{
    $operationResult = eZOperationHandler::execute('store', 'confirmorder', array('order_id' => $order->attribute('id')));
}
// const ERROR_NO_CLASS = 5;
// const ERROR_NO_CLASS_METHOD = 6;
// const ERROR_CLASS_INSTANTIATE_FAILED = 7;
// const ERROR_MISSING_PARAMETER = 8;

// const STATUS_CONTINUE = 1;
// const STATUS_CANCELLED = 2;
// const STATUS_HALTED = 3;
// const STATUS_REPEAT = 4;
// const STATUS_QUEUED = 5;

//var_dump($operationResult); die;

switch ($operationResult['status']) {
    case eZModuleOperationInfo::STATUS_CONTINUE: {
            if ( $operationResult != null &&
                 !isset( $operationResult['result'] ) &&
                 ( !isset( $operationResult['redirect_url'] ) || $operationResult['redirect_url'] == null ) )
            {
                $order = eZOrder::fetch($order->attribute('id'));
                if ($order instanceof eZOrder) {
                    $order->detachProductCollection();
                    $ini = eZINI::instance();
                    if ($ini->variable('ShopSettings', 'ClearBasketOnCheckout') == 'enabled') {
                        $basket = eZBasket::currentBasket();
                        $basket->remove();
                    }
                    $module->redirectTo('/shop/checkout/');
                    return;
                }
                /*$tpl->setVariable( "order", $order );
                $Result = array();
                $Result['content'] = $tpl->fetch( "design:shop/confirmorder.tpl" );
                $Result['path'] = array( array( 'url' => false,
                                                'text' => ezpI18n::tr( 'kernel/shop', 'Confirm order' ) ) );*/
            }
        }
        break;

    case eZModuleOperationInfo::STATUS_HALTED:
    case eZModuleOperationInfo::STATUS_REPEAT: {
            
        if (  isset( $operationResult['redirect_url'] ) && $needRedirect ){
            
            $module->redirectTo( $operationResult['redirect_url'] );
            return;
            
        }else if ( isset( $operationResult['result'] ) ){
            
            $order = eZOrder::fetch($order->attribute('id'));
            if ($order instanceof eZOrder) {
                $order->detachProductCollection();
                $ini = eZINI::instance();
                if ($ini->variable('ShopSettings', 'ClearBasketOnCheckout') == 'enabled') {
                    $basket = eZBasket::currentBasket();
                    $basket->remove();
                }
                $module->redirectTo('/shop/checkout/');
                return;
            }
        }
//             if (isset($operationResult['redirect_url']) && $needRedirect) {
                
//                 //$handle = new eZShopOperationCollection();
//                 //$handle->handleShipping($order->attribute('id'));
                
//                 $module->redirectTo($operationResult['redirect_url']);
//                 return;
//             } else if (isset($operationResult['result'])) {
//                 $order = eZOrder::fetch($order->attribute('id'));
//                 if ($order instanceof eZOrder) {

//                     //$handle = new eZShopOperationCollection();
//                     //$handle->handleShipping($order->attribute('id'));

//                     $order->detachProductCollection();
//                     $ini = eZINI::instance();
//                     if ($ini->variable('ShopSettings', 'ClearBasketOnCheckout') == 'enabled') {
//                         $basket = eZBasket::currentBasket();
//                         $basket->remove();
//                     }
//                     $module->redirectTo('/shop/checkout/');
//                     return;
//                 }
//                 //                 $result = $operationResult['result'];
//                 //                 $resultContent = false;
//                 //                 if (is_array($result)) {
//                 //                     if (isset($result['content'])) {
//                 //                         $resultContent = $result['content'];
//                 //                     }
//                 //                     if (isset($result['path'])) {
//                 //                         $Result['path'] = $result['path'];
//                 //                     }
//                 //                 } else {
//                 //                     $resultContent = $result;
//                 //                 }
//                 //                 $Result['content'] = $resultContent;
//             }
        }
        break;
    case eZModuleOperationInfo::STATUS_CANCELLED: {
            $Result = array();
            if (isset($operationResult['result']['content']))
                $Result['content'] = $operationResult['result']['content'];
            else
                $Result['content'] = ezpI18n::tr('kernel/shop',
                        "The confirm order operation was canceled. Try to checkout again.");

            $Result['path'] = array(array('url' => false, 'text' => ezpI18n::tr('kernel/shop', 'Confirm order')));
        }

}

/*
$Result = array();
$Result['content'] = $tpl->fetch( "design:shop/confirmorder.tpl" );
$Result['path'] = array( array( 'url' => false,
                                'text' => ezpI18n::tr( 'kernel/shop', 'Confirm order' ) ) );
 */
?>
