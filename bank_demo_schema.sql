-- Adminer 4.8.1 MySQL 10.11.13-MariaDB-0ubuntu0.24.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `account_type` enum('Savings','Current','Credit') NOT NULL,
  `balance` decimal(12,2) DEFAULT 0.00,
  `currency` varchar(10) DEFAULT 'BHD',
  `opened_at` date DEFAULT curdate(),
  PRIMARY KEY (`account_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `loans`;
CREATE TABLE `loans` (
  `loan_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `loan_type` enum('Personal','Auto','Mortgage') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('Active','Closed') DEFAULT 'Active',
  PRIMARY KEY (`loan_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) NOT NULL,
  `payment_date` date NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `method` enum('Transfer','Cash','Card') DEFAULT 'Transfer',
  PRIMARY KEY (`payment_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_type` enum('Deposit','Withdrawal','Transfer') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- 2025-11-12 15:22:49
