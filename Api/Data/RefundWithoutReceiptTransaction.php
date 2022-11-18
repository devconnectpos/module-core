<?php
/**
 * Created by Nomad
 * Date: 7/1/19
 * Time: 1:29 PM
 */

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class RefundWithoutReceiptTransaction extends ApiDataAbstract
{

    public function getTransactionId()
    {
        return $this->getData('transaction_id');
    }

    public function getExchangeOrderId()
    {
        return $this->getData('exchange_order_id');
    }

    public function getExchangeOrderIncrementId()
    {
        return $this->getData('exchange_order_increment_id');
    }

    public function getCustomerId()
    {
        return $this->getData('customer_id');
    }

    public function getCustomerFirstName()
    {
        return $this->getData('customer_first_name');
    }

    public function getCustomerLastName()
    {
        return $this->getData('customer_last_name');
    }

    public function getCustomerEmail()
    {
        return $this->getData('customer_email');
    }

    public function getCustomerTelephone()
    {
        return $this->getData('customer_telephone');
    }

    public function getShippingAddress()
    {
        if ($shippingAdd = $this->getData('shipping_address')) {
            return $shippingAdd;
        }
        return [];
    }

    public function getTotalRefundAmount()
    {
        return $this->getData('total_refund_amount');
    }

    public function getStoreId()
    {
        return $this->getData('store_id');
    }

    public function getOutletId()
    {
        return $this->getData('outlet_id');
    }

    public function getRegisterId()
    {
        return $this->getData('register_id');
    }

    public function getWarehouseId()
    {
        return $this->getData('warehouse_id');
    }

    public function getCreatedAt()
    {
        return $this->getData('created_at');
    }

    public function getUpdatedAt()
    {
        return $this->getData('updated_at');
    }

    public function getRefundedItems()
    {
        return $this->getData('refunded_items');
    }

    public function getUserId()
    {
        return $this->getData('user_id');
    }

    public function getSellers()
    {
        return explode(",", (string)$this->getData('sellers'));
    }

    public function getPaymentData()
    {
        $data = $this->getData('payment_data');
        if (empty($data)) {
            return [];
        }

        return json_decode($data, true);
    }

	public function getSubtotalRefundAmount()
	{
		return $this->getData('subtotal_refund_amount');
	}

	public function getRefundTaxAmount()
	{
		return $this->getData('tax_amount');
	}

	public function getShiftAdjustmentId()
	{
		return $this->getData('shift_adjustment_id');
	}

	public function getShiftId()
	{
		return $this->getData('shift_id');
	}
}
