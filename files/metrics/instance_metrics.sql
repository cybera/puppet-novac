-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'instance'
--
-- ---

DROP TABLE IF EXISTS `instance`;

CREATE TABLE `instance` (
  `uuid` CHAR(38) NULL DEFAULT NULL,
  `instance` char(19) NULL DEFAULT NULL,
  PRIMARY KEY (`uuid`)
);

-- ---
-- Table 'cpu'
--
-- ---

DROP TABLE IF EXISTS `cpu`;

CREATE TABLE `cpu` (
  `id` integer NULL AUTO_INCREMENT DEFAULT NULL,
  `uuid` CHAR(38) NULL DEFAULT NULL,
  `timestamp` INTEGER NULL DEFAULT NULL,
  `cpu_usage` FLOAT(7,2) NULL DEFAULT 0,
  `cpu_time` INTEGER NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'memory'
--
-- ---

DROP TABLE IF EXISTS `memory`;

CREATE TABLE `memory` (
  `id` integer NULL AUTO_INCREMENT DEFAULT NULL,
  `uuid` CHAR(38) NULL DEFAULT NULL,
  `timestamp` INTEGER NULL DEFAULT NULL,
  `available` INTEGER NULL DEFAULT 0,
  `used` INTEGER NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'interface'
--
-- ---

DROP TABLE IF EXISTS `interface`;

CREATE TABLE `interface` (
  `id` integer NULL AUTO_INCREMENT DEFAULT NULL,
  `uuid` CHAR(38) NULL DEFAULT NULL,
  `interface` CHAR(5) NULL DEFAULT NULL,
  `timestamp` INTEGER NULL DEFAULT NULL,
  `rx_bytes` BIGINT UNSIGNED NULL DEFAULT 0,
  `tx_bytes` BIGINT UNSIGNED NULL DEFAULT 0,
  `rx_errs` BIGINT UNSIGNED NULL DEFAULT 0,
  `tx_errs` BIGINT UNSIGNED NULL DEFAULT 0,
  `rx_packets` BIGINT UNSIGNED NULL DEFAULT 0,
  `tx_packets` BIGINT UNSIGNED NULL DEFAULT 0,
  `rx_drop` BIGINT UNSIGNED NULL DEFAULT 0,
  `tx_drop` BIGINT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'disk'
--
-- ---

DROP TABLE IF EXISTS `disk`;

CREATE TABLE `disk` (
  `id` integer NULL AUTO_INCREMENT DEFAULT NULL,
  `uuid` CHAR(38) NULL DEFAULT NULL,
  `timestamp` INTEGER NULL DEFAULT NULL,
  `disk` char(5) NULL DEFAULT NULL,
  `flush_operations` BIGINT UNSIGNED NULL DEFAULT 0,
  `wr_bytes` BIGINT UNSIGNED NULL DEFAULT 0,
  `flush_total_times` BIGINT UNSIGNED NULL DEFAULT 0,
  `rd_req` BIGINT UNSIGNED NULL DEFAULT 0,
  `wr_total_times` BIGINT UNSIGNED NULL DEFAULT 0,
  `rd_total_times` BIGINT UNSIGNED NULL DEFAULT 0,
  `wr_req` BIGINT UNSIGNED NULL DEFAULT 0,
  `rd_bytes` BIGINT UNSIGNED NULL DEFAULT 0,
  `bytes_used` BIGINT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys
-- ---


-- ---
-- Table Properties
-- ---

-- ALTER TABLE `instances` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `cpu` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `memory` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `interface` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `disk` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
