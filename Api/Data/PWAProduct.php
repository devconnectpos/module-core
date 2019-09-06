<?php

namespace SM\Core\Api\Data;


class PWAProduct extends \SM\Core\Api\Data\Contract\ApiDataAbstract {

    public function getId() {
        return $this->getData('entity_id');
    }

    public function getName() {
        return $this->getData('name');
    }

    public function getSku() {

        return $this->getData('sku');
    }

    public function getPrice() {

        return $this->getData('price');
    }

    public function getSpecialPrice() {

        return $this->getData('special_price');
    }

    public function getSpecialFromDate() {

        return $this->getData('special_from_date');
    }

    public function getSpecialToDate() {

        return $this->getData('special_to_date');
    }

    public function getTypeId() {

        return $this->getData('type_id');
    }

    public function getCustomAttributes() {

        return $this->getData('custom_attributes');
    }

    public function getOriginImage() {

        return $this->getData('origin_image');
    }

    public function getMediaGallery() {

        return $this->getData('media_gallery');
    }

    public function getStockItems() {

        return $this->getData('stock_items');
    }

    public function getDescription(){
        return $this->getData('description');
    }

    public function getCustomizableOptions() {
        return $this->getData('customizable_options');
    }

    public function getXOptions() {
        return $this->getData('x_options');
    }

    public function getRelatedProductIds() {
        return $this->getData('related_product_ids');
    }

    public function getCheckRelatedProduct() {
        return $this->getData('check_related_product');
    }

    public function getVisibility() {
        return $this->getData('visibility');
    }
}