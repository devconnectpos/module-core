<?php
/**
 * Created by mr.vjcspy@gmail.com - khoild@smartosc.com.
 * Date: 07/01/2017
 * Time: 16:16
 */

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

class XOrder extends ApiDataAbstract
{
    public function getOrderId()
    {
        return $this->getData('entity_id');
    }

    public function getIncrementId()
    {
        return $this->getData('increment_id');
    }

    public function getRetailId()
    {
        return $this->getData('retail_id');
    }

    public function getRetailStatus()
    {
        return $this->getData('retail_status');
    }

    public function getStatus()
    {
        return $this->getData('status');
    }

    public function getRetailNote()
    {
        return $this->getData('retail_note');
    }

    public function getCustomer()
    {
        return $this->getData('customer');
    }

    public function getItems()
    {
        return $this->getData('items');
    }

    public function getCanCreditmemo()
    {
        return $this->getData('can_creditmemo');
    }

    public function getCanShip()
    {
        return $this->getData('can_ship');
    }

    public function getCanInvoice()
    {
        return $this->getData('can_invoice');
    }

    public function getIsOrderVirtual()
    {
        return $this->getData('is_order_virtual') == 1;
    }

    public function getBillingAddress()
    {
        if ($billingAdd = $this->getData('billing_address')) {
            return $billingAdd;
        }
        return [];
    }

    public function getShippingAddress()
    {
        if ($shippingAdd = $this->getData('shipping_address')) {
            return $shippingAdd;
        }
        return [];
    }

    public function getPayment()
    {
        return $this->getData('payment');
    }

    public function getTotals()
    {
        return $this->getData('totals');
    }

    public function getCreatedAt()
    {
        return $this->getData('created_at');
    }

    public function getHasShipment()
    {
        return $this->getData('retail_has_shipment') == 1;
    }

    public function getUserId()
    {
        return $this->getData('user_id');
    }

    public function getXRefNum()
    {
        return $this->getData('xRefNum');
    }

    public function getSellers()
    {
        return explode(",", (string)$this->getData('sm_seller_ids'));
    }

    public function getSellersUsername()
    {
        return $this->getData('sm_seller_username');
    }

    public function getShippingMethod()
    {
        return $this->getData('shipping_method');
    }

    public function getOrderRate()
    {
        return $this->getData('order_rate');
    }

    public function getOrderFeedback()
    {
        return $this->getData('order_feedback');
    }

    public function getOutletId()
    {
        return $this->getData('outlet_id');
    }

    public function getStoreCreditBalance()
    {
        return $this->getData('store_credit_balance');
    }

    public function getPreviousRewardPointsBalance()
    {
        return $this->getData('previous_reward_points_balance');
    }

    public function getRewardPointsRedeemed()
    {
        return $this->getData('reward_points_redeemed');
    }

    public function getRewardPointsEarned()
    {
        return $this->getData('reward_points_earned');
    }

    public function getRewardPointsEarnedAmount()
    {
        return $this->getData('reward_points_earned_amount');
    }

    public function getRewardPointsRefunded()
    {
        return $this->getData('reward_points_refunded');
    }

    public function getTransId()
    {
        return $this->getData('transId');
    }

    public function getIsExchange()
    {
        return $this->getData('is_exchange');
    }

    public function getPrintTimeCounter()
    {
        return $this->getData('print_time_counter');
    }

    public function getIsPwa()
    {
        return $this->getData('is_pwa');
    }

    public function getPickupOutletId()
    {
        return $this->getData('pickup_outlet_id');
    }

    public function getInvoiceCollection()
    {
        return $this->getData('invoice_collection');
    }

    public function getEstimatedAvailability()
    {
        return $this->getData('estimated_availability');
    }

    public function getLocationId()
    {
        return $this->getData('mageworx_pickup_location_id');
    }

    public function getCommentHistory()
    {
        return $this->getData('comment_history');
    }

    public function getOriginOrderId()
    {
        return $this->getData('origin_order_id');
    }

    public function getOriginOrderRetailId()
    {
        return $this->getData('origin_order_retail_id');
    }

    public function getRwrTransactionId()
    {
        return $this->getData('rwr_transaction_id');
    }

    public function getExchangeOrderIds()
    {
        $ids = $this->getData('exchange_order_ids');

        if (empty($ids)) {
            return [];
        }

        return json_decode((string)$ids, true);
    }

    public function getItemAppliedTaxes()
    {
        return $this->getData('item_applied_taxes');
    }
}
