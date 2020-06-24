<?php

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class CustomerOccupation extends ApiDataAbstract
{

    /**
     * @return array|mixed|null
     */
    public function getId()
    {
        return $this->getData('customer_occupation_id');
    }

    /**
     * @return array|mixed|null
     */
    public function getLabel()
    {
        return $this->getData('customer_occupation_label');
    }

}
