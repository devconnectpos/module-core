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

        if (!isset($option['options'])) {
            $option['options'] = [];
        }

        // AheadWorks gift card
        if (isset($productOptions['aw_gc_amount'])) {
            $fieldAllow = [
                'aw_gc_amount'          => 'Gift Card Amount',
                'aw_gc_sender_name'     => 'Gift Card Sender',
                'aw_gc_recipient_name'  => 'Gift Card Recipient',
                'aw_gc_sender_email'    => 'Gift Card Sender Email',
                'aw_gc_recipient_email' => 'Gift Card Recipient Email',
                'aw_gc_delivery_date'   => 'Gift Card Delivery Date',
                'aw_gc_expire'          => 'Gift Card Expire Date',
                'aw_gc_created_codes'   => 'Gift Card Created Codes',
            ];
            $awGcOptions = [];

            foreach ($fieldAllow as $key => $field) {
                if (!isset($productOptions[$key])) {
                    continue;
                }
                $awGcOptions[] = [
                    'key'   => $key,
                    'label' => $field,
                    'value' => $productOptions[$key],
                ];
            }

            $option['options'] += $awGcOptions;
        }

        // Magento gift card
        if (isset($productOptions['giftcard_created_codes'])) {
            $fieldAllow = [
                'giftcard_amount'          => 'Gift Card Amount',
                'giftcard_sender_name'     => 'Gift Card Sender',
                'giftcard_recipient_name'  => 'Gift Card Recipient',
                'giftcard_sender_email'    => 'Gift Card Sender Email',
                'giftcard_recipient_email' => 'Gift Card Recipient Email',
                'giftcard_message'         => 'Gift Card Message',
                'giftcard_lifetime'        => 'Gift Card Expire Date',
                'giftcard_created_codes'   => 'Gift Card Created Codes',
            ];

            $gcOptions = [];

            foreach ($fieldAllow as $key => $field) {
                if (!isset($productOptions[$key])) {
                    continue;
                }

                $gcOptions[] = [
                    'key'   => $key,
                    'label' => $field,
                    'value' => $productOptions[$key],
                ];
            }

            $option['options'] += $gcOptions;
        }

        // Amasty gift card
        if (isset($productOptions['am_giftcard_created_codes'])) {
            $fieldAllow = [
                'am_giftcard_amount'                 => 'Gift Card Amount',
                'am_giftcard_amount_custom'          => 'Gift Card Custom Amount',
                'am_giftcard_type'                   => 'Gift Card Type',
                'am_giftcard_sender_name'            => 'Gift Card Sender',
                'am_giftcard_sender_email'           => 'Gift Card Sender Email',
                'am_giftcard_recipient_name'         => 'Gift Card Recipient',
                'am_giftcard_recipient_email'        => 'Gift Card Recipient Email',
                'is_date_delivery'                   => 'Gift Card Allow Delivery Date',
                'am_giftcard_date_delivery'          => 'Gift Card Delivery Date',
                'am_giftcard_date_delivery_timezone' => 'Gift Card Delivery Timezone',
                'am_giftcard_image'                  => 'Gift Card Image',
                'am_giftcard_message'                => 'Gift Card Message',
                'am_giftcard_created_codes'          => 'Gift Card Created Codes',
            ];

            $amGcOptions = [];

            foreach ($fieldAllow as $key => $field) {
                if (!isset($productOptions[$key])) {
                    continue;
                }

                $amGcOptions[] = [
                    'key'   => $key,
                    'label' => $field,
                    'value' => $productOptions[$key],
                ];
            }


            $buyRequest = $productOptions['info_buyRequest'] ?? [];

            if (isset($buyRequest['gift_card'])) {
                foreach($buyRequest['gift_card'] as $k => $v) {
                    if (!isset($fieldAllow[$k])) {
                        continue;
                    }

                    $amGcOptions[] = [
                        'key'   => $k,
                        'label' => $fieldAllow[$k],
                        'value' => $v,
                    ];
                }
            }

            $option['options'] += $amGcOptions;

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
