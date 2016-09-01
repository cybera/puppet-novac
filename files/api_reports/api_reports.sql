-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'log'
--
-- ---

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `api_reports` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `api_reports`;

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `id` integer NULL AUTO_INCREMENT DEFAULT NULL,
  `log_date` DATETIME NULL DEFAULT NULL,
  `service` VARCHAR(255) NULL DEFAULT NULL,
  `tenant_id` VARCHAR(38) NULL DEFAULT NULL,
  `ip` VARCHAR(45) NULL DEFAULT NULL,
  `request_type` VARCHAR(10) NULL DEFAULT NULL,
  `request` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`log_date`, `service`, `tenant_id`, `ip`, `request_type`, `request`),
  KEY(`id`)
);

CREATE INDEX log_date_idx on log (log_date);

-- ---
-- Table Properties
-- ---

ALTER TABLE `log` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
