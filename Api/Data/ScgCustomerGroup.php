<?php
declare(strict_types=1);

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

/**
 * Class ScgCustomerGroup
 * @package SM\Core\Api\Data
 */
class ScgCustomerGroup extends ApiDataAbstract
{
    public function getId()
    {
        return $this->getData('scg_customer_group_id');
    }

    public function getLabel()
    {
        return $this->getData('scg_customer_group_label');
    }
}
