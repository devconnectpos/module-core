<?php


namespace SM\Core\Api\Data\AwCodePool;


use SM\Core\Api\Data\Contract\ApiDataAbstract;
use SM\Integrate\Api\Data\Pool\CodeInterface;

class AwGcCode extends ApiDataAbstract implements CodeInterface
{

    /**
     * @inheritDoc
     */
    public function getId()
    {
        return $this->getData(self::ID);
    }

    /**
     * @inheritDoc
     */
    public function setId($id)
    {
        return $this->setData(self::ID);
    }

    /**
     * @inheritDoc
     */
    public function getPoolId()
    {
        return $this->getData(self::POOL_ID);
    }

    /**
     * @inheritDoc
     */
    public function setPoolId($poolId)
    {
        return $this->setData(self::POOL_ID);
    }

    /**
     * @inheritDoc
     */
    public function getCode()
    {
        return $this->getData(self::CODE);
    }

    /**
     * @inheritDoc
     */
    public function setCode($code)
    {
        return $this->setData(self::CODE);
    }

    /**
     * @inheritDoc
     */
    public function getUsed()
    {
        return $this->getData(self::USED);
    }

    /**
     * @inheritDoc
     */
    public function setUsed($used)
    {
        return $this->setData(self::USED);
    }
}
