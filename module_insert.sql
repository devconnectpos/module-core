-- This script must be run before installation of ConnectPOS for specific customer to skip data upgrade of modules with heavy queries and database modification
-- Database schema upgrades can be ran manually later using the bin/magento cpos:setup command

INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_Customer', '0.0.7', '0.0.7') ON DUPLICATE KEY UPDATE `schema_version` = '0.0.7', `data_version` = '0.0.7';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_DiscountPerItem', '0.0.6', '0.0.6') ON DUPLICATE KEY UPDATE `schema_version` = '0.0.6', `data_version` = '0.0.6';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_ElectronicJournal', '0.0.1', '0.0.1') ON DUPLICATE KEY UPDATE `schema_version` = '0.0.1', `data_version` = '0.0.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_Payment', '0.3.0', '0.3.0') ON DUPLICATE KEY UPDATE `schema_version` = '0.3.0', `data_version` = '0.3.0';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_PaymentExpress', '0.0.1', '0.0.1') ON DUPLICATE KEY UPDATE `schema_version` = '0.0.1', `data_version` = '0.0.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_Performance', '0.1.0', '0.1.0') ON DUPLICATE KEY UPDATE `schema_version` = '0.1.0', `data_version` = '0.1.0';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_PWA', '0.0.6', '0.0.6') ON DUPLICATE KEY UPDATE `schema_version` = '0.0.6', `data_version` = '0.0.6';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_PWABanner', '0.1.1', '0.1.1') ON DUPLICATE KEY UPDATE `schema_version` = '0.1.1', `data_version` = '0.1.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_PWAKeyword', '0.1.1', '0.1.1') ON DUPLICATE KEY UPDATE `schema_version` = '0.1.1', `data_version` = '0.1.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_RefundWithoutReceipt', '0.0.3', '0.0.3') ON DUPLICATE KEY UPDATE `schema_version` = '0.0.3', `data_version` = '0.0.3';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_Sales', '0.4.1', '0.4.1') ON DUPLICATE KEY UPDATE `schema_version` = '0.4.1', `data_version` = '0.4.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_Shift', '1.1.5', '1.1.5') ON DUPLICATE KEY UPDATE `schema_version` = '1.1.5', `data_version` = '1.1.5';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_Shipping', '0.0.2', '0.0.2') ON DUPLICATE KEY UPDATE `schema_version` = '0.0.2', `data_version` = '0.0.2';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`) VALUES ('SM_XRetail', '0.4.7', '0.4.7') ON DUPLICATE KEY UPDATE `schema_version` = '0.4.7', `data_version` = '0.4.7';
