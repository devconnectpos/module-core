<?php
/**
 * Created by mr.vjcspy@gmail.com - khoild@smartosc.com.
 * Date: 07/01/2017
 * Time: 16:20
 */

namespace SM\Core\Api\Data\XOrder;


class XOrderItem extends \SM\Core\Api\Data\Contract\ApiDataAbstract
{
    public function getName()
    {
        return $this->getData('name');
    }

    public function getId()
    {
        return $this->getData('product_id');
    }

    public function getItemId()
    {
        return $this->getData('item_id');
    }

    public function getTypeId()
    {
        return $this->getData('product_type');
    }

    public function getSku()
    {
        return $this->getData('sku');
    }

    public function getQtyOrdered()
    {
        if ((!$this->getData('qty_ordered') || floatval($this->getData('qty_ordered')) === 0) && floatval($this->getData('qty')) !== 0) {
            return floatval($this->getData('qty'));
        }

        return floatval($this->getData('qty_ordered'));
    }

    public function getQty()
    {
        return floatval($this->getData('qty'));
    }

    public function getQtyRefunded()
    {
        return floatval($this->getData('qty_refunded'));
    }

    public function getRowTotal()
    {
        return $this->getData('row_total');
    }

    public function getQtyShipped()
    {
        return floatval($this->getData('qty_shipped'));
    }

    public function getRowTotalInclTax()
    {
        return $this->getData('row_total_incl_tax');
    }

    public function getProductOptions()
    {
        $option = [];
        $productOptions = $this->getData('product_options');
        if (isset($productOptions['options'])) {
            $option = array_merge($option, ['options' => $productOptions['options']]);
        }
        if (isset($productOptions['attributes_info'])) {
            $option = array_merge($option, ['attributes_info' => $productOptions['attributes_info']]);
        }
        if (isset($productOptions['bundle_selection_attributes'])) {
            $option = array_merge($option, $this->unserialize($productOptions['bundle_selection_attributes']));
            if ($this->getData('price') && $this->getData('price') != 0) {
                $option['price'] = $this->getData('price');
            }
        }

        // integrate gift card or another extension
        if (!isset($option['options']) && isset($productOptions['aw_gc_amount'])) {
            $fieldAllow = [
                'Gift Card Amount'          => 'aw_gc_amount',
                'Gift Card Sender'          => 'aw_gc_sender_name',
                'Gift Card Recipient'       => 'aw_gc_recipient_name',
                'Gift Card Sender Email'    => 'aw_gc_sender_email',
                'Gift Card Recipient Email' => 'aw_gc_recipient_email',
                'Gift Card Delivery Date'   => 'aw_gc_delivery_date',
                'Gift Card Expire Date'     => 'aw_gc_expire',
                'Gift Card Created Codes'   => 'aw_gc_created_codes',
            ];
            foreach ($fieldAllow as $field => $key) {
                if (isset($productOptions[$key])) {
                    $option['options'][] = [
                        'key'   => $key,
                        'label' => $field,
                        'value' => $productOptions[$key],
                    ];
                }
            }
        }

        if (!isset($option['options']) && isset($productOptions['giftcard_created_codes'])) {
            $fieldAllow = [
                'giftcard_amount'          => ['aw_gc_amount', 'Gift Card Amount'],
                'giftcard_sender_name'     => ['aw_gc_sender_name', 'Gift Card Sender'],
                'giftcard_recipient_name'  => ['aw_gc_recipient_name', 'Gift Card Recipient'],
                'giftcard_sender_email'    => ['aw_gc_sender_email', 'Gift Card Sender Email'],
                'giftcard_recipient_email' => ['aw_gc_recipient_email', 'Gift Card Recipient Email'],
                'giftcard_message'         => ['aw_gc_message', 'Gift Card Message'],
                'giftcard_lifetime'        => ['aw_gc_expire', 'Gift Card Expire Date'],
                'giftcard_created_codes'   => ['aw_gc_created_codes', 'Gift Card Created Code'],
            ];
            foreach ($fieldAllow as $key => $value) {
                if ($key === 'giftcard_amount') {
                    $option['options'][] = [
                        'key'   => $value[0],
                        'label' => $value[1],
                        'value' => $this->getData('price'),
                    ];
                } else {
                    if (isset($productOptions[$key])) {
                        $option['options'][] = [
                            'key'   => $value[0],
                            'label' => $value[1],
                            'value' => $productOptions[$key],
                        ];
                    }
                }
            }
        }

        return $option;
    }

    public function getBuyRequest()
    {
        $buyRequest = $this->getData('buy_request');
        $buyRequest['product_id'] = $this->getData('product_id');

        return $buyRequest;
    }

    public function getChildren()
    {
        return $this->getData('children');
    }

    public function getOriginImage()
    {
        return $this->getData('origin_image');
    }

    public function getIsChildrenCalculated()
    {
        return $this->getData('isChildrenCalculated');
    }

    public function getStockItemToCheck()
    {
        return $this->getData('stockItemToCheck');
    }

    public function getPrice()
    {
        return $this->getData('price');
    }

    public function getTaxAmount()
    {
        return $this->getData('tax_amount');
    }

    public function getTaxPercent()
    {
        return $this->getData('tax_percent');
    }

    public function getPriceInclTax()
    {
        return $this->getData('price_incl_tax');
    }

    public function getProduct()
    {
        return $this->getData('product');
    }

    public function getSerialNumber()
    {
        return $this->getData('serial_number');
    }

    public function getDiscountPercent()
    {
        return $this->getData('discount_percent');
    }

    public function getDiscountAmount()
    {
        return $this->getData('discount_amount');
    }
}
