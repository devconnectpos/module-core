<?php
/**
 * Created by mr.vjcspy@gmail.com - khoild@smartosc.com.
 * Date: 24/10/2016
 * Time: 15:48
 */

namespace SM\Core\Api\Data;

class XCustomer extends \SM\Core\Api\Data\Contract\ApiDataAbstract
{
    protected $customer;

    public function __construct(
        array $data = []
    ) {
        parent::__construct($data);
    }

    public function getId()
    {
        return $this->getData('entity_id');
    }

    public function getCustomerGroupId()
    {
        return $this->getData('group_id');
    }

    public function getDefaultBilling()
    {
        return $this->getData('default_billing');
    }

    public function getDefaultShipping()
    {
        return $this->getData('default_shipping');
    }

    public function getEmail()
    {
        return $this->getData('email');
    }

    public function getFirstName()
    {
        return $this->getData('firstname');
    }

    public function getLastName()
    {
        return $this->getData('lastname');
    }

    public function getGender()
    {
        return $this->getData('gender');
    }

    public function getStoreId()
    {
        return $this->getData('store_id');
    }

    public function getWebsiteId()
    {
        return $this->getData('website_id');
    }

    public function getAddress()
    {
        return $this->getData('address');
    }

    public function getTelephone()
    {
        return $this->getData('retail_telephone');
    }

    public function getAvatar()
    {
        return $this->getData('retail_avatar');
    }

    public function getVeriface()
    {
        if (!is_string($this->getData('retail_veriface'))) {
            return [];
        }
        return json_decode((string)$this->getData('retail_veriface'), true);
    }
    public function getSubscription()
    {
        return $this->getData('subscription');
    }

    public function getGuestId()
    {
        return $this->getData('retail_guest_id');
    }

    public function getRewardPoint()
    {
        return $this->getData('reward_point');
    }

    public function getRetailTelephone2()
    {
        return $this->getData('retail_telephone_2');
    }

    public function getRetailNote()
    {
        return $this->getData('retail_note');
    }
}
