<?php
/**
 * Created by Nomad
 * Date: 7/1/19
 * Time: 1:37 PM
 */

namespace SM\Core\Api\Data\RefundWithoutReceiptTransaction;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class RefundedItem extends ApiDataAbstract
{
    public function getItemId()
    {
        return $this->getData('item_id');
    }

    public function getTransactionId()
    {
        return $this->getData('transaction_id');
    }

    public function getShiftAdjustmentId()
    {
        return $this->getData('shift_adjustment_id');
    }

    public function getProductId()
    {
        return $this->getData('product_id');
    }

    public function getProductQty()
    {
        return $this->getData('product_qty');
    }

    public function getProductType()
    {
        return $this->getData('product_type');
    }

    public function getProductOptions()
    {
        return $this->getData('product_options');
    }

    public function getProductSku()
    {
        return $this->getData('product_sku');
    }

    public function getProductName()
    {
        return $this->getData('product_name');
    }

    public function getProductPrice()
    {
        return $this->getData('product_price');
    }

    public function getBaseProductPrice()
    {
        return $this->getData('base_product_price');
    }

    public function getCustomSalesNote()
    {
        return $this->getData('custom_sales_note');
    }

    public function getRowTotal()
    {
        return $this->getData('row_total');
    }

    public function getBaseRowTotal()
    {
        return $this->getData('base_row_total');
    }

    public function getSubTotal()
    {
        return $this->getData('sub_total');
    }

    public function getBaseSubTotal()
    {
        return $this->getData('base_sub_total');
    }
}
