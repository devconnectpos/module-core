<?php


namespace SM\Core\Api\Data;


use SM\Core\Api\Data\Contract\ApiDataAbstract;
use SM\Integrate\Api\Data\PoolInterface;

class AwCodePool extends ApiDataAbstract implements PoolInterface
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
    public function getName()
    {
        return $this->getData(self::NAME);
    }

    /**
     * @inheritDoc
     */
    public function setName($name)
    {
        return $this->setData(self::NAME);
    }

    /**
     * @inheritDoc
     */
    public function getCodeLength()
    {
        return $this->getData(self::CODE_LENGTH);
    }

    /**
     * @inheritDoc
     */
    public function setCodeLength($codeLength)
    {
        return $this->setData(self::CODE_LENGTH);
    }

    /**
     * @inheritDoc
     */
    public function getCodeFormat()
    {
        return $this->getData(self::CODE_FORMAT);
    }

    /**
     * @inheritDoc
     */
    public function setCodeFormat($codeFormat)
    {
        return $this->setData(self::CODE_FORMAT);
    }

    /**
     * @inheritDoc
     */
    public function getCodePrefix()
    {
        return $this->getData(self::CODE_PREFIX);
    }

    /**
     * @inheritDoc
     */
    public function setCodePrefix($codePrefix)
    {
        return $this->setData(self::CODE_PREFIX);
    }

    /**
     * @inheritDoc
     */
    public function getCodeSuffix()
    {
        return $this->getData(self::CODE_SUFFIX);
    }

    /**
     * @inheritDoc
     */
    public function setCodeSuffix($codeSuffix)
    {
        return $this->setData(self::CODE_SUFFIX);
    }

    /**
     * @inheritDoc
     */
    public function getCodeDelimiterAtEvery()
    {
        return $this->getData(self::CODE_DELIMITER_AT_EVERY);
    }

    /**
     * @inheritDoc
     */
    public function setCodeDelimiterAtEvery($codeDelimiterAtEvery)
    {
        return $this->setData(self::CODE_DELIMITER_AT_EVERY);
    }

    public function getCodes()
    {
        return $this->getData('codes');
    }

    public function setCodes($codes)
    {
        return $this->setData('codes', $codes);
    }
}
