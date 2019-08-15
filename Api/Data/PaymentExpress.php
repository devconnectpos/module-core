<?php
/**
 * Created by Hung Nguyen - hungnh@smartosc.com
 * Date: 2019-07-15
 * Time: 16:03
 */

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

/**
 * Class PaymentExpress
 *
 * @package SM\Core\Api\Data
 */
class PaymentExpress extends ApiDataAbstract
{

    /**
     * @return string
     */
    public function getId()
    {
        return $this->getData('id');
    }

    /**
     * @return string
     */
    public function getHitUsername()
    {
        return $this->getData('hit_username');
    }

    /**
     * @return string
     */
    public function getHitKey()
    {
        return $this->getData('hit_key');
    }

    /**
     * @return string
     */
    public function getDeviceId()
    {
        return $this->getData('device_id');
    }

    /**
     * @return string
     */
    public function getStationId()
    {
        return $this->getData('station_id');
    }

    /**
     * @return string
     */
    public function getDl1()
    {
        return $this->getData('dl1');
    }

    /**
     * @return string
     */
    public function getDl2()
    {
        return $this->getData('dl2');
    }

    /**
     * @return string
     */
    public function getTxnref()
    {
        return $this->getData('txnref');
    }

    /**
     * @return string
     */
    public function getMessage()
    {
        return $this->getData('message');
    }

    /**
     * @return string
     */
    public function getCreatedAt()
    {
        return $this->getData('created_at');
    }

    /**
     * @return string
     */
    public function getUpdatedAt()
    {
        return $this->getData('updated_at');
    }
}

