<?php
/**
 * Created by PhpStorm.
 * User: xuantung
 * Date: 10/6/18
 * Time: 2:48 PM
 */

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class PWAKeyword extends ApiDataAbstract
{
    public function getId() {
        return $this->getData('keyword_id');
    }

    public function getText() {
        return $this->getData('text');
    }
}