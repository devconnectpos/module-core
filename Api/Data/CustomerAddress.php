<?php
/**
 * Created by mr.vjcspy@gmail.com - khoild@smartosc.com.
 * Date: 07/01/2017
 * Time: 16:57
 */

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class CustomerAddress extends ApiDataAbstract
{

    public function getId()
    {
        return $this->getData('entity_id');
    }

    public function getParentId()
    {
        return $this->getData('parent_id');
    }

    public function getIsActive()
    {
        return $this->getData('is_active');
    }

    public function getCity()
    {
        return $this->getData('city');
    }

    public function getCountryId()
    {
        return $this->getData('country_id');
    }

    public function getFirstName()
    {
        return (
            $this->getData('first_name') === null ?
            $this->getData('firstname') :
            $this->getData('first_name')
        );
    }

    public function getLastName()
    {
        return (
            $this->getData('last_name') === null ?
            $this->getData('lastname') :
            $this->getData('last_name')
        );
    }

    public function getMiddleName()
    {
        return (
            $this->getData('middle_name') === null ?
            $this->getData('middlename') :
            $this->getData('middle_name')
        );
    }

    public function getPostcode()
    {
        return $this->getData('postcode');
    }

    public function getRegion()
    {
        return $this->getData('region');
    }

    public function getRegionId()
    {
        return $this->getData('region_id');
    }

    public function getStreet()
    {
        return $this->getData('street');
    }

    public function getTelephone()
    {
        return $this->getData('telephone');
    }

    public function getCompany()
    {
        return $this->getData('company');
    }
}
