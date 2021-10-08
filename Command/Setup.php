<?php

namespace SM\Core\Command;

use Magento\Framework\App\Area;
use Magento\Framework\App\State;
use Magento\Framework\Setup\ModuleDataSetupInterface;
use Magento\Framework\Setup\SchemaSetupInterface;
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

class Setup extends Command
{
    /**
     * @var State
     */
    private $appState;

    /**
     * @var SchemaSetupInterface
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

    public function __construct(
        State $appState,
        SchemaSetupInterface $schemaSetup,
        ModuleDataSetupInterface $moduleDataSetup,

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

        string $name = null
    ) {
        $this->appState = $appState;
        $this->schemaSetup = $schemaSetup;
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
        // Customer
        $output->writeln("-- Customer");
        $this->customerUpgradeSchema->execute($this->schemaSetup, $output);

        // Product
        $output->writeln("-- Product");
        $this->discountPerItemUpgradeSchema->execute($this->schemaSetup, $output);

        // Payment
        $output->writeln("-- Payment");
        $this->paymentUpgradeSchema->execute($this->schemaSetup, $output);

        // PWA
        $output->writeln("-- PWA Data");
        $this->pwaUpgradeSchema->execute($this->schemaSetup, $output);
        $this->pwaBannerInstallSchema->execute($this->schemaSetup, $output);
        $this->pwaKeywordInstallSchema->execute($this->schemaSetup, $output);

        // Create new database schemas
        $output->writeln("-- Initialize miscellaneous schemas and data");
        $this->performanceUpgradeSchema->execute($this->schemaSetup, $output);
        $this->refundWithoutReceiptInstallSchema->execute($this->schemaSetup, $output);
        $this->paymentExpressUpgradeSchema->execute($this->schemaSetup, $output);
        $this->electronicJournalUpgradeSchema->execute($this->schemaSetup, $output);
    }
}
