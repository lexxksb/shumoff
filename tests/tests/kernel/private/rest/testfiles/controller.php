<?php
/**
 * File containing the ezpRestTestController class.
 *
 * @copyright Copyright (C) 1999-2013 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version //autogentag//
 * @package tests
 */

/**
 * @property-read cacheLocation
 * @property-read cacheId
 * @property-read cacheTTL
 */
class ezpRestTestController extends ezpRestMvcController
{
    public function doTest()
    {
        $ret = new ezpRestMvcResult();
        $ret->variables['testVar'] = 'test';
        if( isset( $this->dummyVar ) )
        {
            $ret['dummy'] = $this->dummyVar;
        }

        return $ret;
    }

    /**
     * Helper method to access some private/protected methods
     * @see lib/ezc/MvcTools/src/interfaces/ezcMvcController::__get()
     */
    public function __get( $name )
    {
        $ret = null;
        switch( $name )
        {
            case 'cacheLocation':
                $ret = $this->getCacheLocation();
            break;

            case 'cacheId':
                $refObj = new ReflectionObject( $this );
                $refMethod = $refObj->getMethod( 'generateCacheId' );
                $refMethod->setAccessible( true );
                $ret = $refMethod->invoke( $this );
            break;

            case 'cacheTTL':
                $ret = $this->getActionTTL();
            break;

            default:
                $ret = parent::__get( $name );
        }

        return $ret;
    }

    public function setRestINI( eZINI $restINI )
    {
        $this->restINI = $restINI;
    }
}
?>
