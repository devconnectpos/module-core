<?php

namespace SM\Core\Command;

use Magento\Framework\App\Area;
use Magento\Framework\App\State;
use Magento\Framework\ObjectManagerInterface;
use Magento\Framework\Setup\ModuleDataSetupInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

// Upgrade schema services
use SM\Customer\Setup\UpgradeSchema as CustomerUpgradeSchema;
use SM\DiscountPerItem\Setup\UpgradeSchema as DiscountPerItemUpgradeSchema;
use SM\ElectronicJournal\Setup\UpgradeSchema as ElectronicJournalUpgradeSchema;
use SM\Payment\Setup\UpgradeSchema as PaymentUpgradeSchema;
use SM\PaymentExpress\Setup\UpgradeSchema as PaymentExpressUpgradeSchema;
use SM\Performance\Setup\UpgradeSchema as PerformanceUpgradeSchema;
use SM\PWA\Setup\UpgradeSchema as PWAUpgradeSchema;
use SM\PWABanner\Setup\InstallSchema as PWABannerInstallSchema;
use SM\PWAKeyword\Setup\InstallSchema as PWAKeywordInstallSchema;
use SM\RefundWithoutReceipt\Setup\InstallSchema as RefundWithoutReceiptInstallSchema;
use SM\Sales\Setup\UpgradeData as SalesUpgradeData;
use SM\Sales\Setup\UpgradeSchema as SalesUpgradeSchema;
use SM\Shift\Setup\UpgradeSchema as ShiftUpgradeSchema;
use SM\Shipping\Setup\UpgradeSchema as ShippingUpgradeSchema;
use SM\XRetail\Setup\UpgradeSchema as XRetailUpgradeSchema;

class Setup extends Command
{
    /**
     * @var State
     */
    private $appState;

    /**
     * @var \Magento\Framework\Setup\SchemaSetupInterface
     */
    private $schemaSetup;

    /**
     * @var ModuleDataSetupInterface
     */
    private $moduleDataSetup;

    /**
     * @var CustomerUpgradeSchema
     */
    private $customerUpgradeSchema;

    /**
     * @var DiscountPerItemUpgradeSchema
     */
    private $discountPerItemUpgradeSchema;

    /**
     * @var ElectronicJournalUpgradeSchema
     */
    private $electronicJournalUpgradeSchema;

    /**
     * @var PaymentUpgradeSchema
     */
    private $paymentUpgradeSchema;

    /**
     * @var PaymentExpressUpgradeSchema
     */
    private $paymentExpressUpgradeSchema;

    /**
     * @var PerformanceUpgradeSchema
     */
    private $performanceUpgradeSchema;

    /**
     * @var PWAUpgradeSchema
     */
    private $pwaUpgradeSchema;

    /**
     * @var PWABannerInstallSchema
     */
    private $pwaBannerInstallSchema;

    /**
     * @var PWAKeywordInstallSchema
     */
    private $pwaKeywordInstallSchema;

    /**
     * @var RefundWithoutReceiptInstallSchema
     */
    private $refundWithoutReceiptInstallSchema;

    /**
     * @var SalesUpgradeData
     */
    private $salesUpgradeData;

    /**
     * @var SalesUpgradeData
     */
    private $salesUpgradeSchema;

    /**
     * @var ShiftUpgradeSchema
     */
    private $shiftUpgradeSchema;

    /**
     * @var ShippingUpgradeSchema
     */
    private $shippingUpgradeSchema;

    /**
     * @var XRetailUpgradeSchema
     */
    private $xRetailUpgradeSchema;

    /**
     * @var ObjectManagerInterface
     */
    private $objectManager;

    public function __construct(
        State $appState,
        ModuleDataSetupInterface $moduleDataSetup,
        ObjectManagerInterface $objectManager,

        CustomerUpgradeSchema $customerUpgradeSchema,
        DiscountPerItemUpgradeSchema $discountPerItemUpgradeSchema,
        ElectronicJournalUpgradeSchema $electronicJournalUpgradeSchema,
        PaymentUpgradeSchema $paymentUpgradeSchema,
        PaymentExpressUpgradeSchema $paymentExpressUpgradeSchema,
        PerformanceUpgradeSchema $performanceUpgradeSchema,
        PWAUpgradeSchema $pwaUpgradeSchema,
        PWABannerInstallSchema $pwaBannerInstallSchema,
        PWAKeywordInstallSchema $pwaKeywordInstallSchema,
        RefundWithoutReceiptInstallSchema $refundWithoutReceiptInstallSchema,
        SalesUpgradeData $salesUpgradeData,
        SalesUpgradeSchema $salesUpgradeSchema,
        ShiftUpgradeSchema $shiftUpgradeSchema,
        ShippingUpgradeSchema $shippingUpgradeSchema,
        XRetailUpgradeSchema $xRetailUpgradeSchema,

        string $name = null
    ) {
        $this->appState = $appState;
        $this->objectManager = $objectManager;
        $this->schemaSetup = $objectManager->get('Magento\Framework\Setup\SchemaSetupInterface');
        $this->moduleDataSetup = $moduleDataSetup;

        $this->customerUpgradeSchema = $customerUpgradeSchema;
        $this->discountPerItemUpgradeSchema = $discountPerItemUpgradeSchema;
        $this->electronicJournalUpgradeSchema = $electronicJournalUpgradeSchema;
        $this->paymentUpgradeSchema = $paymentUpgradeSchema;
        $this->paymentExpressUpgradeSchema = $paymentExpressUpgradeSchema;
        $this->performanceUpgradeSchema = $performanceUpgradeSchema;
        $this->pwaUpgradeSchema = $pwaUpgradeSchema;
        $this->pwaBannerInstallSchema = $pwaBannerInstallSchema;
        $this->pwaKeywordInstallSchema = $pwaKeywordInstallSchema;
        $this->refundWithoutReceiptInstallSchema = $refundWithoutReceiptInstallSchema;
        $this->salesUpgradeData = $salesUpgradeData;
        $this->salesUpgradeSchema = $salesUpgradeSchema;
        $this->shiftUpgradeSchema = $shiftUpgradeSchema;
        $this->shippingUpgradeSchema = $shippingUpgradeSchema;
        $this->xRetailUpgradeSchema = $xRetailUpgradeSchema;

        parent::__construct($name);
    }

    public function configure()
    {
        $this->setName("cpos:setup");
        $this->setDescription("Manually setup database schema and necessary entity attributes for ConnectPOS");
        parent::configure();
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     *
     * @return int|void
     * @throws \Magento\Framework\Exception\LocalizedException
     * @throws \Zend_Validate_Exception
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output->writeln("---[  CONNECTPOS DATABASE SETUP SCRIPT  ]---");

        $this->appState->emulateAreaCode(Area::AREA_ADMINHTML, [$this, 'setup'], [$output]);

        $output->writeln("DONE!");
    }

    /**
     * @param OutputInterface $output
     *
     * @throws \Magento\Framework\Exception\LocalizedException
     * @throws \Zend_Validate_Exception|\Zend_Db_Exception
     */
    public function setup(OutputInterface $output): void
    {
        // Core
        $output->writeln("-- Core");
        $this->xRetailUpgradeSchema->execute($this->schemaSetup, $output);

        // Shift
        $output->writeln("-- Shift");
        $this->shiftUpgradeSchema->execute($this->schemaSetup, $output);

        // Customer
        $output->writeln("-- Customer");
        $this->customerUpgradeSchema->execute($this->schemaSetup, $output);

        // Product
        $output->writeln("-- Product");
        $this->discountPerItemUpgradeSchema->execute($this->schemaSetup, $output);

        // Payment
        $output->writeln("-- Payment");
        $this->paymentUpgradeSchema->execute($this->schemaSetup, $output);

        // Sales entities
        $output->writeln("-- Sales entities");
        $this->salesUpgradeSchema->execute($this->schemaSetup, $output);
        $this->salesUpgradeData->execute($this->moduleDataSetup, $output);

        // PWA
        $output->writeln("-- PWA data");
        $this->pwaUpgradeSchema->execute($this->schemaSetup, $output);
        $this->pwaBannerInstallSchema->execute($this->schemaSetup, $output);
        $this->pwaKeywordInstallSchema->execute($this->schemaSetup, $output);

        // Create new database schemas
        $output->writeln("-- Initialize miscellaneous schemas and data");
        $this->shippingUpgradeSchema->execute($this->schemaSetup, $output);
        $this->performanceUpgradeSchema->execute($this->schemaSetup, $output);
        $this->refundWithoutReceiptInstallSchema->execute($this->schemaSetup, $output);
        $this->paymentExpressUpgradeSchema->execute($this->schemaSetup, $output);
        $this->electronicJournalUpgradeSchema->execute($this->schemaSetup, $output);
    }
}
