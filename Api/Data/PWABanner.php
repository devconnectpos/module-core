<?php
/**
 * Created by PhpStorm.
 * User: xuantung
 * Date: 10/6/18
 * Time: 2:50 PM
 */

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class PWABanner extends ApiDataAbstract
{
    public function getId() {
        return $this->getData('banner_id');
    }

    public function getBannerUrl() {
        return $this->getData('banner_url');
    }

    public function getIsActive() {
        return $this->getData('is_active');
    }
}