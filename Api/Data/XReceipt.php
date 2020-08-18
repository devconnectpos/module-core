<?php

namespace SM\Core\Api\Data;

class XReceipt extends \SM\Core\Api\Data\Contract\ApiDataAbstract
{

    public function getId()
    {
        return $this->getData('id');
    }

    public function getLogoImageStatus()
    {
        return $this->getData('logo_image_status');
    }

    public function getLogoUrl()
    {
        return $this->getData('logo_url');
    }

    public function getInsertHeaderLogo()
    {
        return $this->getData('insert_header_logo');
    }

    public function getName()
    {
        return $this->getData('name');
    }

    public function getFooterImageStatus()
    {
        return $this->getData('footer_image_status');
    }

    public function getFooterUrl()
    {
        return $this->getData('footer_url');
    }

    public function getInsertFooterLogo()
    {
        return $this->getData('insert_footer_logo');
    }

    public function getHeader()
    {
        return $this->getData('header');
    }

    public function getFooter()
    {
        return $this->getData('footer');
    }

    public function getCustomerInfo()
    {
        return $this->getData('customer_info');
    }

    public function getFontType()
    {
        return $this->getData('font_type');
    }

    public function getBarcodeSymbology()
    {
        return $this->getData('barcode_symbology');
    }

    public function getRowTotalInclTax()
    {
        return $this->getData('row_total_incl_tax');
    }

    public function getSubtotalInclTax()
    {
        return $this->getData('subtotal_incl_tax');
    }

    public function getEnableBarcode()
    {
        return $this->getData('enable_barcode');
    }

    public function getEnablePowerText()
    {
        return $this->getData('enable_power_text');
    }

    public function getOrderInfo()
    {

        return json_decode($this->getData('order_info'), true);
    }

    public function getCreatedAt()
    {
        return $this->getData('created_at');
    }

    public function getUpdatedAt()
    {
        return $this->getData('updated_at');
    }

    public function getIsDefault()
    {
        return $this->getData('is_default') == 1;
    }

    public function getDayOfWeek()
    {
        return $this->getData('day_of_week');
    }

    public function getDayOfMonth()
    {

        return $this->getData('day_of_month');
    }

    public function getMonth()
    {
        return $this->getData('month');
    }

    public function getYear()
    {
        return $this->getData('year');
    }

    public function getTime()
    {
        return $this->getData('time');
    }

    public function getCustomDate()
    {
        return $this->getData('custom_date');
    }

    public function getDisplayCustomTax()
    {
        return $this->getData('display_custom_tax');
    }

    public function getCustomTaxMultiplier()
    {
        return $this->getData('custom_tax_multiplier');
    }

    public function getPaperSize()
    {
        return $this->getData('paper_size');
    }

    public function getStyleCustomerInfo()
    {
        return $this->getData('style_customer_info');
    }

    public function getStoreInfo()
    {
        return $this->getData('store_info');
    }

    public function getStorePhone()
    {
        return $this->getData('store_phone');
    }

    public function getStoreWebsite()
    {
        return $this->getData('store_website');
    }

    public function getStoreEmail()
    {
        return $this->getData('store_email');
    }

    public function getEnableTermsAndConditions()
    {
        return $this->getData('enable_terms_and_conditions');
    }

    public function getTermsAndConditions()
    {
        return $this->getData('terms_and_conditions');
    }

    public function getEnableCustomerSignature()
    {
        return $this->getData('enable_customer_signature');
    }
    
    public function getCustomTaxLabel()
    {
        return $this->getData('custom_tax_label');
    }
}
