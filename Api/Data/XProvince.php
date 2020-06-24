<?php

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class XProvince extends ApiDataAbstract
{

    /**
     * @return array|mixed|null
     */
    public function getId()
    {
        return $this->getData('id');
    }

    /**
     * @return array|mixed|null
     */
    public function getName()
    {
        return $this->getData('name');
    }

    /**
     * @return array|mixed|null
     */
    public function getValue()
    {
        return $this->getData('value');
    }

    /**
     * @return array|mixed|null
     */
    public function getDistricts()
    {
        return $this->getData('districts');
    }

}
