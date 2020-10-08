<?php
declare(strict_types=1);

namespace SM\Core\Api\Data;

use Magento\Customer\Api\Data\CustomerInterface;
use Magento\Quote\Api\Data\AddressInterface;
use Magento\Quote\Api\Data\CurrencyInterface;
use SM\Core\Api\Data\Contract\ApiDataAbstract;
use Magento\Quote\Api\Data\CartInterface;

/**
 * Class XQuote
 * @package SM\Core\Api\Data
 */
class XQuote extends ApiDataAbstract
{
    /**
     * Returns the cart/quote ID.
     *
     * @return int Cart/quote ID.
     */
    public function getId()
    {
        return $this->getData(CartInterface::KEY_ENTITY_ID);
    }

    /**
     * Returns the cart creation date and time.
     *
     * @return string|null Cart creation date and time. Otherwise, null.
     */
    public function getCreatedAt()
    {
        return $this->getData(CartInterface::KEY_CREATED_AT);
    }

    /**
     * Returns the cart last update date and time.
     *
     * @return string|null Cart last update date and time. Otherwise, null.
     */
    public function getUpdatedAt()
    {
        return $this->getData(CartInterface::KEY_UPDATED_AT);
    }

    /**
     * Returns the cart conversion date and time.
     *
     * @return string|null Cart conversion date and time. Otherwise, null.
     */
    public function getConvertedAt()
    {
        return $this->getData(CartInterface::KEY_CONVERTED_AT);
    }

    /**
     * Determines whether the cart is still active.
     *
     * @return bool|null Active status flag value. Otherwise, null.
     */
    public function getIsActive()
    {
        return $this->getData(CartInterface::KEY_IS_ACTIVE);
    }

    /**
     * Determines whether the cart is a virtual cart.
     *
     * A virtual cart contains virtual items.
     *
     * @return bool|null Virtual flag value. Otherwise, null.
     */
    public function getIsVirtual()
    {
        return $this->getData(CartInterface::KEY_IS_VIRTUAL);
    }

    /**
     * Lists items in the cart.
     *
     * @return \Magento\Quote\Api\Data\CartItemInterface[]|null Array of items. Otherwise, null.
     */
    public function getItems()
    {
        return $this->getData(CartInterface::KEY_ITEMS);
    }

    /**
     * Returns the number of different items or products in the cart.
     *
     * @return int|null Number of different items or products in the cart. Otherwise, null.
     */
    public function getItemsCount()
    {
        return $this->getData(CartInterface::KEY_ITEMS_COUNT);
    }

    /**
     * Returns the total quantity of all cart items.
     *
     * @return float|null Total quantity of all cart items. Otherwise, null.
     */
    public function getItemsQty()
    {
        return $this->getData(CartInterface::KEY_ITEMS_QTY);
    }

    /**
     * Returns information about the customer who is assigned to the cart.
     *
     * @return CustomerInterface Information about the customer who is assigned to the cart.
     */
    public function getCustomer()
    {
        return $this->getData(CartInterface::KEY_CUSTOMER);
    }

    /**
     * Returns the cart billing address.
     *
     * @return AddressInterface|null Cart billing address. Otherwise, null.
     */
    public function getBillingAddress()
    {
        return $this->getData(CartInterface::KEY_BILLING_ADDRESS);
    }

    /**
     * Returns the reserved order ID for the cart.
     *
     * @return string|null Reserved order ID. Otherwise, null.
     */
    public function getReservedOrderId()
    {
        return $this->getData(CartInterface::KEY_RESERVED_ORDER_ID);
    }

    /**
     * Returns the original order ID for the cart.
     *
     * @return int|null Original order ID. Otherwise, null.
     */
    public function getOrigOrderId()
    {
        return $this->getData(CartInterface::KEY_ORIG_ORDER_ID);
    }

    /**
     * Returns information about quote currency, such as code, exchange rate, and so on.
     *
     * @return CurrencyInterface|null Quote currency information. Otherwise, null.
     */
    public function getCurrency()
    {
        return $this->getData(CartInterface::KEY_CURRENCY);
    }

    /**
     * True for guest customers, false for logged in customers
     *
     * @return bool|null
     */
    public function getCustomerIsGuest()
    {
        return $this->getData(CartInterface::KEY_CUSTOMER_IS_GUEST);
    }

    /**
     * Customer notice text
     *
     * @return string|null
     */
    public function getCustomerNote()
    {
        return $this->getData(CartInterface::KEY_CUSTOMER_NOTE);
    }

    /**
     * Send customer notification flag
     *
     * @return bool|null
     */
    public function getCustomerNoteNotify()
    {
        return $this->getData(CartInterface::KEY_CUSTOMER_NOTE_NOTIFY);
    }

    /**
     * Get customer tax class ID.
     *
     * @return int|null
     */
    public function getCustomerTaxClassId()
    {
        return $this->getData(CartInterface::KEY_CUSTOMER_TAX_CLASS_ID);
    }

    /**
     * Get store identifier
     *
     * @return int
     */
    public function getStoreId()
    {
        return $this->getData(CartInterface::KEY_STORE_ID);
    }
}
