<?php

$http = eZHTTPTool::instance();
$module = $Params['Module'];

if ($http->hasPostVariable("ContentObjectID")) {
    $objectID = $http->postVariable("ContentObjectID");

    // Check which action to perform
    if ($http->hasPostVariable("ActionAddToBasket")) {
        $shopModule = eZModule::exists("shop");
        $result = $shopModule->run("basket", array());
        if (isset($result['content']) && $result['content']) {
            return $result;
        } else {
            $module->setExitStatus($shopModule->exitStatus());
            $module->setRedirectURI($shopModule->redirectURI());
        }
    } else if ($http->hasPostVariable("ActionAddToWishList")) {
        if (!eZUser::isCurrentUserRegistered())
            return $module->handleError(eZError::KERNEL_ACCESS_DENIED, 'kernel');

        $shopModule = eZModule::exists("shop");
        $result = $shopModule->run("wishlist", array());
        $module->setExitStatus($shopModule->exitStatus());
        $module->setRedirectURI($shopModule->redirectURI());
    }
}