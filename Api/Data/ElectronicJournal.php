<?php

namespace SM\Core\Api\Data;

use SM\Core\Api\Data\Contract\ApiDataAbstract;

/**
 * Class ElectronicJournal
 * @package SM\Core\Api\Data
 */
class ElectronicJournal extends ApiDataAbstract
{

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->getData('id');
    }

    /**
     * @return mixed
     */
    public function getOutletId()
    {
        return $this->getData('outlet_id');
    }

    /**
     * @return mixed
     */
    public function getRegisterId()
    {
        return $this->getData('register_id');
    }

    /**
     * @return mixed
     */
    public function getEventType()
    {
        return $this->getData('event_type');
    }

    /**
     * @return mixed
     */
    public function getEmployeeId()
    {
        return $this->getData('employee_id');
    }

    /**
     * @return mixed
     */
    public function getEmployeeUsername()
    {
        return $this->getData('employee_username');
    }

    /**
     * @return mixed
     */
    public function getMessage()
    {
        return $this->getData('message');
    }

    /**
     * @return mixed
     */
    public function getCreatedAt()
    {
        return $this->getData('created_at');
    }

}

