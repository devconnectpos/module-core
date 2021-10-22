-- Set module schema/data upgrade to latest version
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_Customer', '0.0.7', '0.0.7')
ON DUPLICATE KEY UPDATE `schema_version` = '0.0.7',
                        `data_version`   = '0.0.7';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_DiscountPerItem', '0.0.6', '0.0.6')
ON DUPLICATE KEY UPDATE `schema_version` = '0.0.6',
                        `data_version`   = '0.0.6';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_ElectronicJournal', '0.0.1', '0.0.1')
ON DUPLICATE KEY UPDATE `schema_version` = '0.0.1',
                        `data_version`   = '0.0.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_Payment', '0.3.0', '0.3.0')
ON DUPLICATE KEY UPDATE `schema_version` = '0.3.0',
                        `data_version`   = '0.3.0';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_PaymentExpress', '0.0.1', '0.0.1')
ON DUPLICATE KEY UPDATE `schema_version` = '0.0.1',
                        `data_version`   = '0.0.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_Performance', '0.1.0', '0.1.0')
ON DUPLICATE KEY UPDATE `schema_version` = '0.1.0',
                        `data_version`   = '0.1.0';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_PWA', '0.0.6', '0.0.6')
ON DUPLICATE KEY UPDATE `schema_version` = '0.0.6',
                        `data_version`   = '0.0.6';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_PWABanner', '0.1.1', '0.1.1')
ON DUPLICATE KEY UPDATE `schema_version` = '0.1.1',
                        `data_version`   = '0.1.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_PWAKeyword', '0.1.1', '0.1.1')
ON DUPLICATE KEY UPDATE `schema_version` = '0.1.1',
                        `data_version`   = '0.1.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_RefundWithoutReceipt', '0.0.3', '0.0.3')
ON DUPLICATE KEY UPDATE `schema_version` = '0.0.3',
                        `data_version`   = '0.0.3';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_Sales', '0.4.1', '0.4.1')
ON DUPLICATE KEY UPDATE `schema_version` = '0.4.1',
                        `data_version`   = '0.4.1';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_Shift', '1.1.5', '1.1.5')
ON DUPLICATE KEY UPDATE `schema_version` = '1.1.5',
                        `data_version`   = '1.1.5';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_Shipping', '0.0.2', '0.0.2')
ON DUPLICATE KEY UPDATE `schema_version` = '0.0.2',
                        `data_version`   = '0.0.2';
INSERT INTO `setup_module` (`module`, `schema_version`, `data_version`)
VALUES ('SM_XRetail', '0.4.7', '0.4.7')
ON DUPLICATE KEY UPDATE `schema_version` = '0.4.7',
                        `data_version`   = '0.4.7';

-- Initialize variables
SET @dbname = DATABASE();
SET @quoteTable = 'quote';
SET @quoteItemTable = 'quote_item';
SET @salesOrderTable = 'sales_order';
SET @salesOrderGridTable = 'sales_order_grid';
SET @salesOrderItemTable = 'sales_order_item';

-- Initialize procedure
DELIMITER //

DROP PROCEDURE IF EXISTS AddColumnIfNotExists;
CREATE PROCEDURE AddColumnIfNotExists(databaseName varchar(100), tableName varchar(100), columnName varchar(100), columnDefinition TEXT)
BEGIN
    SET @preparedStatement = (
        SELECT IF(
                       (
                           SELECT COUNT(*)
                           FROM INFORMATION_SCHEMA.COLUMNS
                           WHERE (table_name = tableName)
                             AND (table_schema = databaseName)
                             AND (column_name = columnName)
                       ) > 0,
                       'SET @noop = null;', -- Do nothing when the column exists
                       CONCAT('ALTER TABLE ', tableName, ' ADD COLUMN ', columnName, ' ', columnDefinition) -- Add new column when it does not exists
                   )
    );
    PREPARE alterIfNotExists FROM @preparedStatement;
    EXECUTE alterIfNotExists;
    DEALLOCATE PREPARE alterIfNotExists;
END //

DELIMITER ;

-- Add columns to quote table
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'discount_per_item', 'decimal(12,4) DEFAULT NULL COMMENT ''Discount per item'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'base_discount_per_item', 'decimal(12,4) DEFAULT NULL COMMENT ''Base Discount per item'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'is_pwa', 'smallint(6) DEFAULT 0 COMMENT ''Is enable PWA'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'outlet_id', 'int(11) DEFAULT NULL COMMENT ''Outlet id'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'retail_id', 'varchar(32) DEFAULT NULL COMMENT ''Retail Id'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'retail_status', 'smallint(6) DEFAULT NULL COMMENT ''Retail Status'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'retail_note', 'text DEFAULT NULL COMMENT ''Retail Note'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'retail_has_shipment', 'smallint(6) DEFAULT NULL COMMENT ''Retail Shipment'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'is_exchange', 'smallint(6) DEFAULT NULL COMMENT ''Is Exchange'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'user_id', 'text DEFAULT NULL COMMENT ''Cashier Id'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'register_id', 'int(11) DEFAULT NULL COMMENT ''Register id'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'xRefNum', 'text DEFAULT NULL COMMENT ''xRefNum'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'sm_seller_ids', 'text DEFAULT NULL COMMENT ''Seller Ids'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'pickup_outlet_id', 'int(11) DEFAULT NULL COMMENT ''Store Pickup Outlet id'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'store_credit_balance', 'decimal(12,2) DEFAULT NULL COMMENT ''Store Credit Balance'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'previous_reward_points_balance', 'int(11) DEFAULT NULL COMMENT ''Previous Reward Points Balance'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'reward_points_redeemed', 'int(11) DEFAULT NULL COMMENT ''Reward Points Redeemed'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'reward_points_earned', 'int(11) DEFAULT NULL COMMENT ''Reward Points Earned'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'reward_points_refunded', 'int(11) DEFAULT NULL COMMENT ''Reward Points Refunded'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'transId', 'text DEFAULT NULL COMMENT ''transId'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'reward_points_earned_amount', 'decimal(12,4) DEFAULT NULL COMMENT ''Reward Points Earned Amount'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'user_name', 'text DEFAULT NULL COMMENT ''User name'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'estimated_availability', 'decimal(12,4) DEFAULT 0.0000 COMMENT ''Estimated Availability'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'sm_seller_username', 'text DEFAULT NULL COMMENT ''Seller Username'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'outlet_name', 'varchar(50) DEFAULT NULL COMMENT ''Outlet Name'';');
CALL AddColumnIfNotExists(@dbname, @quoteTable, 'outlet_payment_method', 'varchar(255) DEFAULT NULL COMMENT ''Outlet Payment Method'';');

-- Add columns to sales_order table
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'discount_per_item', 'decimal(12,4) DEFAULT NULL COMMENT ''Discount per item'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'base_discount_per_item', 'decimal(12,4) DEFAULT NULL COMMENT ''Base Discount per item'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'is_pwa', 'smallint(6) DEFAULT 0 COMMENT ''Is enable PWA'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'outlet_id', 'int(11) DEFAULT NULL COMMENT ''Outlet id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'retail_id', 'varchar(32) DEFAULT NULL COMMENT ''Retail Id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'retail_status', 'smallint(6) DEFAULT NULL COMMENT ''Retail Status'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'retail_note', 'text DEFAULT NULL COMMENT ''Retail Note'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'retail_has_shipment', 'smallint(6) DEFAULT NULL COMMENT ''Retail Shipment'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'is_exchange', 'smallint(6) DEFAULT NULL COMMENT ''Is Exchange'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'user_id', 'text DEFAULT NULL COMMENT ''Cashier Id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'register_id', 'int(11) DEFAULT NULL COMMENT ''Register id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'xRefNum', 'text DEFAULT NULL COMMENT ''xRefNum'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'sm_seller_ids', 'text DEFAULT NULL COMMENT ''Seller Ids'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'pickup_outlet_id', 'int(11) DEFAULT NULL COMMENT ''Store Pickup Outlet id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'order_rate', 'smallint(6) DEFAULT NULL COMMENT ''Order Rate'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'order_feedback', 'text DEFAULT NULL COMMENT ''Order Feedback'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'store_credit_balance', 'decimal(12,2) DEFAULT NULL COMMENT ''Store Credit Balance'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'previous_reward_points_balance', 'int(11) DEFAULT NULL COMMENT ''Previous Reward Points Balance'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'reward_points_redeemed', 'int(11) DEFAULT NULL COMMENT ''Reward Points Redeemed'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'reward_points_earned', 'int(11) DEFAULT NULL COMMENT ''Reward Points Earned'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'reward_points_refunded', 'int(11) DEFAULT NULL COMMENT ''Reward Points Refunded'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'transId', 'text DEFAULT NULL COMMENT ''transId'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'reward_points_earned_amount', 'decimal(12,4) DEFAULT NULL COMMENT ''Reward Points Earned Amount'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'print_time_counter', 'int(11) DEFAULT 0 COMMENT ''Print time counter'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'user_name', 'text DEFAULT NULL COMMENT ''User name'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'estimated_availability', 'decimal(12,4) DEFAULT 0.0000 COMMENT ''Estimated Availability'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'sm_seller_username', 'text DEFAULT NULL COMMENT ''Seller Username'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'outlet_name', 'varchar(50) DEFAULT NULL COMMENT ''Outlet Name'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'outlet_payment_method', 'varchar(255) DEFAULT NULL COMMENT ''Outlet Payment Method'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'origin_order_id', 'int(11) DEFAULT NULL COMMENT ''Origin Order Id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'rwr_transaction_id', 'int(11) DEFAULT NULL COMMENT ''Rwr Transaction Id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'exchange_order_ids', 'text DEFAULT NULL COMMENT ''Exchange Order Ids'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderTable, 'cpos_is_new', 'int(11) DEFAULT NULL COMMENT ''Cpos Is New'';');

-- Add columns to sales_order_grid table
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'discount_per_item', 'decimal(12,4) DEFAULT NULL COMMENT ''Discount per item'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'base_discount_per_item', 'decimal(12,4) DEFAULT NULL COMMENT ''Base Discount per item'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'is_pwa', 'smallint(6) DEFAULT 0 COMMENT ''Is enable PWA'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'outlet_id', 'int(11) DEFAULT NULL COMMENT ''Outlet id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'retail_id', 'varchar(32) DEFAULT NULL COMMENT ''Retail Id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'retail_status', 'smallint(6) DEFAULT NULL COMMENT ''Retail Status'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'retail_note', 'text DEFAULT NULL COMMENT ''Retail Note'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'retail_has_shipment', 'smallint(6) DEFAULT NULL COMMENT ''Retail Shipment'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'is_exchange', 'smallint(6) DEFAULT NULL COMMENT ''Is Exchange'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'user_id', 'text DEFAULT NULL COMMENT ''Cashier Id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'register_id', 'int(11) DEFAULT NULL COMMENT ''Register id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'xRefNum', 'text DEFAULT NULL COMMENT ''xRefNum'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'sm_seller_ids', 'text DEFAULT NULL COMMENT ''Seller Ids'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'pickup_outlet_id', 'int(11) DEFAULT NULL COMMENT ''Store Pickup Outlet id'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'store_credit_balance', 'decimal(12,2) DEFAULT NULL COMMENT ''Store Credit Balance'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'previous_reward_points_balance', 'int(11) DEFAULT NULL COMMENT ''Previous Reward Points Balance'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'reward_points_redeemed', 'int(11) DEFAULT NULL COMMENT ''Reward Points Redeemed'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'reward_points_earned', 'int(11) DEFAULT NULL COMMENT ''Reward Points Earned'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'reward_points_refunded', 'int(11) DEFAULT NULL COMMENT ''Reward Points Refunded'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'transId', 'text DEFAULT NULL COMMENT ''transId'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'reward_points_earned_amount', 'decimal(12,4) DEFAULT NULL COMMENT ''Reward Points Earned Amount'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'estimated_availability', 'decimal(12,4) DEFAULT 0.0000 COMMENT ''Estimated Availability'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'sm_seller_username', 'text DEFAULT NULL COMMENT ''Seller Username'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'outlet_name', 'varchar(50) DEFAULT NULL COMMENT ''Outlet Name'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderGridTable, 'outlet_payment_method', 'varchar(255) DEFAULT NULL COMMENT ''Outlet Payment Method'';');

-- Add columns to quote_item table
CALL AddColumnIfNotExists(@dbname, @quoteItemTable, 'serial_number', 'varchar(250) DEFAULT NULL COMMENT ''Serial number'';');

-- Add columns to sales_order_item table
CALL AddColumnIfNotExists(@dbname, @salesOrderItemTable, 'cpos_discount_per_item', 'decimal(12,4) DEFAULT NULL COMMENT ''Discount per item'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderItemTable, 'cpos_discount_per_item_percent', 'decimal(12,4) DEFAULT NULL COMMENT ''Discount per item percent'';');
CALL AddColumnIfNotExists(@dbname, @salesOrderItemTable, 'serial_number', 'varchar(250) DEFAULT NULL COMMENT ''Serial number'';');

-- Create tables
CREATE TABLE IF NOT EXISTS `sm_advertisement`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `list_media`  text             NOT NULL COMMENT 'List Media',
    `name`        varchar(255)     NOT NULL COMMENT 'Demo Title',
    `description` text                      DEFAULT NULL COMMENT 'Description',
    `type`        varchar(255)     NOT NULL COMMENT 'Type',
    `duration`    int(11)                   DEFAULT NULL COMMENT 'Duration',
    `priority`    int(11)                   DEFAULT NULL COMMENT 'Priority',
    `created_at`  timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at`  timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_active`   smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_advertisement';

CREATE TABLE IF NOT EXISTS `sm_electronic_journal`
(
    `id`                int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `outlet_id`         int(11)          NOT NULL COMMENT 'Outlet Id',
    `register_id`       int(11)          NOT NULL COMMENT 'Register Id',
    `message`           text             NOT NULL COMMENT 'Message',
    `event_type`        text             NOT NULL COMMENT 'Type',
    `employee_id`       text             NOT NULL COMMENT 'Employee Id',
    `employee_username` text             NOT NULL COMMENT 'Employee username',
    `amount`            decimal(12, 4)            DEFAULT NULL COMMENT 'Amount',
    `created_at`        timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Created At',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_electronic_journal';

CREATE TABLE IF NOT EXISTS `sm_feedback`
(
    `id`              int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `retail_id`       varchar(32)      NOT NULL COMMENT 'Retail Id',
    `retail_feedback` text        DEFAULT NULL COMMENT 'Retail Feedback',
    `retail_rate`     smallint(6) DEFAULT NULL COMMENT 'Retail Rate',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_feedback';

CREATE TABLE IF NOT EXISTS `sm_media_library`
(
    `id`         int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `name`       varchar(255)     NOT NULL COMMENT 'Demo Title',
    `url`        text             NOT NULL COMMENT 'Url',
    `type`       text             NOT NULL COMMENT 'Media Type',
    `created_at` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at` timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_active`  smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_media_library';

CREATE TABLE IF NOT EXISTS `sm_order_sync_error`
(
    `id`            int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `retail_id`     text             NOT NULL COMMENT 'retail_id',
    `outlet_id`     int(11)          NOT NULL COMMENT 'retail_id',
    `store_id`      int(11)          NOT NULL COMMENT 'retail_id',
    `message`       text             NOT NULL COMMENT 'error',
    `order_offline` text             NOT NULL COMMENT 'Order offline data',
    `created_at`    timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at`    timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_order_sync_error';

CREATE TABLE IF NOT EXISTS `sm_payment`
(
    `id`                    int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `type`                  varchar(25)               DEFAULT NULL COMMENT 'Outlet Id',
    `title`                 varchar(255)              DEFAULT NULL COMMENT 'Title',
    `payment_data`          text                      DEFAULT NULL COMMENT 'Payment Data',
    `created_at`            timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at`            timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_active`             smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    `is_dummy`              smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Dummy',
    `allow_amount_tendered` smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Allow Amount Tendered',
    `sm_payment`            int(11)                   DEFAULT NULL COMMENT 'Register id',
    `register_id`           int(11)                   DEFAULT NULL COMMENT 'Register id',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 28
  DEFAULT CHARSET = utf8 COMMENT ='sm_payment';

CREATE TABLE IF NOT EXISTS `sm_payment_express_history`
(
    `id`           int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `hit_username` text                      DEFAULT NULL COMMENT 'HIT Username',
    `hit_key`      text                      DEFAULT NULL COMMENT 'HIT Key',
    `device_id`    text                      DEFAULT NULL COMMENT 'Device ID',
    `station_id`   text                      DEFAULT NULL COMMENT 'Station ID',
    `dl1`          text                      DEFAULT NULL COMMENT 'DL1 Message',
    `dl2`          text                      DEFAULT NULL COMMENT 'DL2 Message',
    `message`      text                      DEFAULT NULL COMMENT 'Text Message',
    `type`         text                      DEFAULT NULL COMMENT 'Type Transaction',
    `txnref`       text                      DEFAULT NULL COMMENT 'TxnRef Transaction',
    `created_at`   timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at`   timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_payment_express_history';

CREATE TABLE IF NOT EXISTS `sm_performance_product_cache_instance`
(
    `id`            int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `is_over`       smallint(5) unsigned      DEFAULT NULL COMMENT 'Has Full Cache',
    `cache_time`    text                      DEFAULT NULL COMMENT 'Cache Time',
    `warehouse_id`  mediumtext       NOT NULL COMMENT 'WareHouse ID',
    `store_id`      int(10) unsigned          DEFAULT NULL COMMENT 'Store ID',
    `page_size`     int(10) unsigned          DEFAULT NULL COMMENT 'Store ID',
    `current_page`  int(10) unsigned          DEFAULT NULL COMMENT 'Store ID',
    `creation_time` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `update_time`   timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_performance_product_cache_instance';

CREATE TABLE IF NOT EXISTS `sm_permission`
(
    `id`           int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `role_id`      int(10) unsigned NOT NULL COMMENT 'Role ID',
    `group`        varchar(50)      NOT NULL COMMENT 'Group',
    `permission`   varchar(50)      NOT NULL COMMENT 'Permission',
    `created_at`   timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_time` timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_active`    smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    PRIMARY KEY (`id`),
    KEY `ID_ROLE_ID_SM_ROLE_ID` (`role_id`),
    CONSTRAINT `ID_ROLE_ID_SM_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `sm_role` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_permission';

CREATE TABLE IF NOT EXISTS `sm_pwa_banner`
(
    `banner_id`  int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `banner_url` text             NOT NULL COMMENT 'Banner URL',
    `is_active`  smallint(6)      NOT NULL COMMENT 'Is Active',
    `created_at` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Created At',
    `updated_at` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Modified',
    `store`      text                      DEFAULT NULL COMMENT 'Store Ids',
    PRIMARY KEY (`banner_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='PWA Banner';

CREATE TABLE IF NOT EXISTS `sm_pwa_keyword`
(
    `keyword_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Keyword ID',
    `text`       varchar(255)              DEFAULT NULL COMMENT 'Text',
    `created_at` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at` timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `store`      text                      DEFAULT NULL COMMENT 'Store Ids',
    PRIMARY KEY (`keyword_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_pwa_keyword';

CREATE TABLE IF NOT EXISTS `sm_realtime_storage`
(
    `id`            int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `data_realtime` text                      DEFAULT NULL COMMENT 'Data Realtime',
    `creation_time` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_realtime_storage';

CREATE TABLE IF NOT EXISTS `sm_refund_without_receipt_item`
(
    `item_id`            int(10) unsigned        NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
    `transaction_id`     int(10) unsigned        NOT NULL COMMENT 'Transaction ID',
    `product_id`         int(10) unsigned        NOT NULL COMMENT 'Product ID',
    `product_type`       varchar(255)            NOT NULL COMMENT 'Product ID',
    `product_options`    text                    NOT NULL COMMENT 'Product Options',
    `product_sku`        varchar(255) DEFAULT NULL COMMENT 'Product SKU',
    `product_name`       varchar(255) DEFAULT NULL COMMENT 'Product Name',
    `product_qty`        decimal(12, 4) unsigned NOT NULL COMMENT 'Product Quantity',
    `product_price`      decimal(12, 4)          NOT NULL COMMENT 'Product Refund Price',
    `base_product_price` decimal(12, 4)          NOT NULL COMMENT 'Base Product Refund Price',
    `row_total`          decimal(12, 4)          NOT NULL COMMENT 'Row total',
    `base_row_total`     decimal(12, 4)          NOT NULL COMMENT 'Base Row Total',
    `sub_total`          decimal(12, 4)          NOT NULL COMMENT 'Sub Total',
    `base_sub_total`     decimal(12, 4)          NOT NULL COMMENT 'Base Sub Total',
    `custom_sales_note`  text         DEFAULT NULL COMMENT 'Custom Sales Note',
    `back_to_stock`      smallint(6)  DEFAULT NULL COMMENT 'Back To Stock',
    PRIMARY KEY (`item_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_refund_without_receipt_item';

CREATE TABLE IF NOT EXISTS `sm_refund_without_receipt_transaction`
(
    `transaction_id`              int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction ID',
    `exchange_order_id`           int(11)               DEFAULT NULL COMMENT 'Exchange Order Id',
    `exchange_order_increment_id` varchar(20)           DEFAULT NULL COMMENT 'Exchange Order Increment Id',
    `customer_id`                 int(11)               DEFAULT NULL COMMENT 'Customer Id',
    `customer_group_id`           int(11)               DEFAULT NULL COMMENT 'Customer Group Id',
    `customer_first_name`         varchar(255)          DEFAULT NULL COMMENT 'Customer First Name',
    `customer_last_name`          varchar(255)          DEFAULT NULL COMMENT 'Customer Last Name',
    `customer_email`              varchar(255)          DEFAULT NULL COMMENT 'Customer Email',
    `customer_shipping_address`   text                  DEFAULT NULL COMMENT 'Customer Shipping Address',
    `customer_billing_address`    text                  DEFAULT NULL COMMENT 'Customer Billing Address',
    `customer_telephone`          varchar(255)          DEFAULT NULL COMMENT 'Customer Telephone',
    `total_refund_amount`         decimal(12, 4)        DEFAULT NULL COMMENT 'Total Refund Amount',
    `base_total_refund_amount`    decimal(12, 4)        DEFAULT NULL COMMENT 'Base Total Refund Amount',
    `store_id`                    int(11)               DEFAULT NULL COMMENT 'Store Id',
    `outlet_id`                   int(11)               DEFAULT NULL COMMENT 'Outlet Id',
    `register_id`                 int(11)               DEFAULT NULL COMMENT 'Register Id',
    `warehouse_id`                varchar(255)          DEFAULT NULL COMMENT 'Warehouse Id',
    `user_id`                     varchar(255)          DEFAULT NULL COMMENT 'User Id',
    `sellers`                     text                  DEFAULT NULL COMMENT 'Sellers',
    `currency_code`               varchar(3)            DEFAULT NULL COMMENT 'Currency Code',
    `payment_data`                text                  DEFAULT NULL COMMENT 'Payment',
    `tax_percent`                 decimal(12, 4)        DEFAULT 0.0000 COMMENT 'Tax Percent',
    `tax_amount`                  decimal(12, 4)        DEFAULT 0.0000 COMMENT 'Tax Amount',
    `base_tax_amount`             decimal(12, 4)        DEFAULT 0.0000 COMMENT 'Base Tax Amount',
    `subtotal_refund_amount`      decimal(12, 4)        DEFAULT 0.0000 COMMENT 'Subtotal Amount',
    `base_subtotal_refund_amount` decimal(12, 4)        DEFAULT 0.0000 COMMENT 'Base Subtotal Amount',
    `shift_adjustment_id`         int(11)               DEFAULT NULL COMMENT 'Shift Adjustment Id',
    `shift_id`                    int(11)               DEFAULT NULL COMMENT 'Shift Id',
    `created_at`                  timestamp        NULL DEFAULT NULL COMMENT 'Created At',
    `updated_at`                  timestamp        NULL DEFAULT NULL COMMENT 'Updated At',
    PRIMARY KEY (`transaction_id`),
    KEY `SM_REFUND_WITHOUT_RECEIPT_TRANSACTION_TRANSACTION_ID` (`transaction_id`),
    KEY `SM_REFUND_WITHOUT_RECEIPT_TRANSACTION_TOTAL_REFUND_AMOUNT` (`total_refund_amount`),
    KEY `SM_REFUND_WITHOUT_RECEIPT_TRANSACTION_CUSTOMER_EMAIL` (`customer_email`),
    KEY `SM_REFUND_WITHOUT_RECEIPT_TRANSACTION_CUSTOMER_FIRST_NAME` (`customer_first_name`),
    KEY `SM_REFUND_WITHOUT_RECEIPT_TRANSACTION_CUSTOMER_LAST_NAME` (`customer_last_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_refund_without_receipt_transaction';

CREATE TABLE IF NOT EXISTS `sm_retail_transaction`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `payment_id`         int(10) unsigned          DEFAULT NULL COMMENT 'Payment Id',
    `shift_id`           int(10) unsigned          DEFAULT NULL COMMENT 'Outlet Id',
    `outlet_id`          int(10) unsigned          DEFAULT NULL COMMENT 'Outlet Id',
    `register_id`        int(10) unsigned          DEFAULT NULL COMMENT 'Register Id',
    `payment_title`      varchar(255)     NOT NULL COMMENT 'Payment title',
    `payment_type`       varchar(255)     NOT NULL COMMENT 'Payment type',
    `amount`             decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Amount',
    `base_amount`        decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Base Amount',
    `is_purchase`        smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    `created_at`         timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at`         timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `order_id`           int(11)          NOT NULL COMMENT 'Modification Time',
    `user_name`          varchar(255)     NOT NULL COMMENT 'User name',
    `rwr_transaction_id` int(11)                   DEFAULT NULL COMMENT 'Refund Without Receipt Transaction Id',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_retail_transaction';

CREATE TABLE IF NOT EXISTS `sm_role`
(
    `id`           int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `name`         varchar(255)     NOT NULL COMMENT 'Demo Title',
    `created_at`   timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_time` timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_active`    smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8 COMMENT ='sm_role';

CREATE TABLE IF NOT EXISTS `sm_shift_shift`
(
    `id`                    int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `outlet_id`             int(10) unsigned          DEFAULT NULL COMMENT 'Outlet Id',
    `register_id`           int(10) unsigned          DEFAULT NULL COMMENT 'Register Id',
    `user_open_id`          int(10) unsigned          DEFAULT NULL COMMENT 'User Open Id',
    `user_close_id`         int(10) unsigned          DEFAULT NULL COMMENT 'user close id',
    `user_open_name`        varchar(255)     NOT NULL COMMENT 'User name Open',
    `user_close_name`       varchar(255)     NOT NULL COMMENT 'User name close',
    `open_note`             varchar(255)     NOT NULL COMMENT 'User name close',
    `close_note`            varchar(255)     NOT NULL COMMENT 'User name close',
    `data`                  text             NOT NULL COMMENT 'Note',
    `point_earned`          decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Point Earn',
    `point_spent`           decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Point Earn',
    `total_adjustment`      decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Expected amount',
    `total_expected_amount` decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Total Expected',
    `total_counted_amount`  decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Total Counted',
    `total_net_amount`      decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Total Counted',
    `take_out_amount`       decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Take out',
    `start_amount`          decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Take out',
    `open_at`               timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `close_at`              timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_open`               smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    `total_order_tax`       decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Total order tax',
    `base_total_order_tax`  decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Base total order tax',
    `detail_tax`            text             NOT NULL COMMENT 'Detail all tax in shift',
    `bank_notes`            mediumtext                DEFAULT NULL COMMENT 'Shift bank notes',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_shift_shift';

CREATE TABLE IF NOT EXISTS `sm_shift_shiftinout`
(
    `id`         int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `shift_id`   int(10) unsigned          DEFAULT NULL COMMENT 'Shift Id',
    `user_id`    int(10) unsigned          DEFAULT NULL COMMENT 'User Id',
    `user_name`  varchar(255)     NOT NULL COMMENT 'User name',
    `note`       varchar(255)     NOT NULL COMMENT 'Note',
    `amount`     decimal(12, 4)   NOT NULL DEFAULT 0.0000 COMMENT 'Total Expected',
    `is_in`      smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is In',
    `created_at` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at` timestamp        NULL     DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp() COMMENT 'Modification Time',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_shift_shiftinout';

CREATE TABLE IF NOT EXISTS `sm_shipping_carrier_additional_data`
(
    `id`              int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `carrier_code`    varchar(50)      NOT NULL COMMENT 'Carrier Code',
    `additional_data` text DEFAULT NULL COMMENT 'Additional Data JSON',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_shipping_carrier_additional_data';

CREATE TABLE IF NOT EXISTS `sm_token`
(
    `id`         int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `token`      text             NOT NULL COMMENT 'Token',
    `user_id`    varchar(255)     NOT NULL COMMENT 'User Id',
    `expired_at` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Expired At',
    `created_at` timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Created At',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_token';

CREATE TABLE IF NOT EXISTS `sm_xretail_outlet`
(
    `id`                           int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `name`                         varchar(255)     NOT NULL COMMENT 'Demo Title',
    `warehouse_id`                 mediumtext       NOT NULL DEFAULT '' COMMENT 'WareHouse ID',
    `store_id`                     int(10) unsigned          DEFAULT NULL COMMENT 'Store ID',
    `cashier_ids`                  mediumtext       NOT NULL COMMENT 'Cashier Ids',
    `enable_guest_checkout`        smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Enable Guest Checkout',
    `tax_calculation_based_on`     varchar(20)      NOT NULL COMMENT 'Tax Calculation Based On',
    `paper_receipt_template_id`    varchar(5)       NOT NULL COMMENT 'Paper Receipt''s template',
    `street`                       varchar(255)     NOT NULL COMMENT 'Street',
    `city`                         varchar(255)     NOT NULL COMMENT 'City',
    `country_id`                   varchar(10)      NOT NULL COMMENT 'Country Id',
    `region_id`                    varchar(10)      NOT NULL COMMENT 'Region Id',
    `postcode`                     varchar(10)      NOT NULL COMMENT 'Postcode',
    `telephone`                    varchar(40)      NOT NULL COMMENT 'Telephone',
    `creation_time`                timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `update_time`                  timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_active`                    smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    `category_id`                  int(11)                   DEFAULT NULL COMMENT 'Category ID',
    `place_id`                     varchar(255)     NOT NULL DEFAULT '' COMMENT 'Place ID Google Map',
    `url`                          text             NOT NULL DEFAULT '' COMMENT 'URL Google Map',
    `lat`                          varchar(255)     NOT NULL DEFAULT '' COMMENT 'Latitude Google Map',
    `lng`                          varchar(255)     NOT NULL DEFAULT '' COMMENT 'Longitude Google Map',
    `location_id`                  varchar(255)     NOT NULL DEFAULT '' COMMENT 'Location Id',
    `allow_click_and_collect`      smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Allow click and collect',
    `allow_out_of_stock`           smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Allow placing order with out of stock products',
    `default_guest_customer_email` varchar(50)      NOT NULL DEFAULT 'guest@sales.connectpos.com' COMMENT 'Default guest customer email',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_xretail_outlet';

CREATE TABLE IF NOT EXISTS `sm_xretail_receipt`
(
    `id`                          int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `logo_image_status`           smallint(6)      NOT NULL COMMENT 'Logo image status',
    `logo_url`                    text             NOT NULL COMMENT 'Logo Url',
    `name`                        varchar(255)     NOT NULL COMMENT 'Name',
    `footer_image_status`         smallint(6)      NOT NULL COMMENT 'Logo image status',
    `footer_url`                  text             NOT NULL COMMENT 'Footer Url',
    `header`                      mediumtext       NOT NULL COMMENT 'Header',
    `footer`                      varchar(255)     NOT NULL COMMENT 'Footer',
    `customer_info`               varchar(5)       NOT NULL COMMENT 'Customer Info',
    `font_type`                   varchar(5)       NOT NULL COMMENT 'Font Type',
    `barcode_symbology`           varchar(20)      NOT NULL COMMENT 'Barcode Symbology',
    `row_total_incl_tax`          smallint(6)      NOT NULL COMMENT 'Row total Incl tax',
    `subtotal_incl_tax`           smallint(6)      NOT NULL COMMENT 'Subtotal Incl Tax',
    `enable_barcode`              smallint(6)      NOT NULL COMMENT 'Enable Barcode',
    `enable_power_text`           smallint(6)      NOT NULL COMMENT 'Enable Power text',
    `created_at`                  timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `updated_at`                  timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_default`                  smallint(6)      NOT NULL COMMENT 'Default receipt',
    `day_of_week`                 varchar(128)     NOT NULL DEFAULT 'dddd' COMMENT 'Day of Week',
    `day_of_month`                varchar(128)     NOT NULL DEFAULT 'Do' COMMENT 'Day of Month',
    `month`                       varchar(128)     NOT NULL DEFAULT 'MMM' COMMENT 'Month',
    `year`                        varchar(128)     NOT NULL DEFAULT 'YYYY' COMMENT 'Year',
    `time`                        varchar(128)     NOT NULL DEFAULT 'h:mm a' COMMENT 'Time',
    `insert_header_logo`          mediumtext       NOT NULL COMMENT 'Insert Header Logo',
    `insert_footer_logo`          mediumtext       NOT NULL COMMENT 'Insert Footer Logo',
    `display_custom_tax`          int(11)                   DEFAULT 0 COMMENT 'Is Display Custom Tax',
    `custom_tax_multiplier`       decimal(12, 9)            DEFAULT 0.000000000 COMMENT 'Custom Tax Multiplier',
    `paper_size`                  varchar(255)     NOT NULL COMMENT 'Paper Size',
    `style_customer_info`         varchar(255)     NOT NULL COMMENT 'Style For Customer Info',
    `store_info`                  varchar(255)     NOT NULL COMMENT 'Store Info',
    `store_phone`                 varchar(255)     NOT NULL COMMENT 'Store Phone',
    `store_website`               varchar(255)     NOT NULL COMMENT 'Store Website',
    `enable_terms_and_conditions` varchar(255)     NOT NULL COMMENT 'Terms and Conditions of Sale',
    `terms_and_conditions`        mediumtext       NOT NULL COMMENT 'Terms and Conditions Content',
    `enable_customer_signature`   varchar(255)     NOT NULL COMMENT 'Customer Signature',
    `custom_tax_label`            varchar(20)               DEFAULT 'Tax' COMMENT 'Custom Tax Label',
    `sm_xretail_receipt`          int(11)                   DEFAULT 0 COMMENT 'Display Two Languages',
    `second_language`             varchar(3)                DEFAULT 'en' COMMENT 'Second Language',
    `order_info`                  text             NOT NULL COMMENT 'Order Info',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8 COMMENT ='sm_xretail_receipt';

CREATE TABLE IF NOT EXISTS `sm_xretail_register`
(
    `id`               int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `outlet_id`        int(10) unsigned NOT NULL COMMENT 'Entity ID',
    `name`             varchar(255)     NOT NULL COMMENT 'Demo Title',
    `creation_time`    timestamp        NOT NULL DEFAULT current_timestamp() COMMENT 'Creation Time',
    `update_time`      timestamp        NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Modification Time',
    `is_active`        smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Active',
    `is_print_receipt` smallint(6)      NOT NULL DEFAULT 1 COMMENT 'Is Always Print Receipt',
    PRIMARY KEY (`id`),
    KEY `ID_OUTLET_ID_SM_XRETAIL_OUTLET_ID` (`outlet_id`),
    CONSTRAINT `ID_OUTLET_ID_SM_XRETAIL_OUTLET_ID` FOREIGN KEY (`outlet_id`) REFERENCES `sm_xretail_outlet` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_xretail_register';

CREATE TABLE IF NOT EXISTS `sm_xretail_userordercounter`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    `user_id`     text             DEFAULT NULL COMMENT 'User ID',
    `outlet_id`   int(10) unsigned DEFAULT NULL COMMENT 'Outlet ID',
    `register_id` int(10) unsigned DEFAULT NULL COMMENT 'Outlet ID',
    `order_count` int(10) unsigned DEFAULT NULL COMMENT 'Order Count',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='sm_xretail_userordercounter';
