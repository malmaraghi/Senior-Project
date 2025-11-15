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

INSERT INTO `accounts` (`account_id`, `customer_id`, `account_type`, `balance`, `currency`, `opened_at`) VALUES
(1,	1,	'Savings',	1250.50,	'BHD',	'2025-11-12'),
(2,	1,	'Current',	430.25,	'BHD',	'2025-11-12'),
(3,	2,	'Savings',	990.00,	'BHD',	'2025-11-12'),
(4,	3,	'Credit',	-150.00,	'BHD',	'2025-11-12'),
(5,	4,	'Savings',	2200.75,	'BHD',	'2025-11-12'),
(6,	5,	'Current',	3400.00,	'BHD',	'2025-11-12'),
(7,	6,	'Savings',	1780.25,	'BHD',	'2025-11-12'),
(8,	7,	'Savings',	900.00,	'BHD',	'2025-11-12'),
(9,	8,	'Current',	620.00,	'BHD',	'2025-11-12'),
(10,	9,	'Savings',	1500.50,	'BHD',	'2025-11-12'),
(11,	10,	'Savings',	850.75,	'BHD',	'2025-11-12');

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

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `phone`, `address`, `city`, `country`, `created_at`) VALUES
(1,	'Mohamed',	'Almaraghi',	'm.almaraghi@mail.com',	'35550001',	'Building 12, Road 14',	'Manama',	'Bahrain',	'2025-11-12 15:21:44'),
(2,	'Sara',	'Hassan',	's.hassan@mail.com',	'35550002',	'Flat 5, Road 22',	'Riffa',	'Bahrain',	'2025-11-12 15:21:44'),
(3,	'Omar',	'Ali',	'o.ali@mail.com',	'35550003',	'Villa 9, Road 11',	'Muharraq',	'Bahrain',	'2025-11-12 15:21:44'),
(4,	'Fatima',	'Yousef',	'f.yousef@mail.com',	'35550004',	'House 7, Road 3',	'Isa Town',	'Bahrain',	'2025-11-12 15:21:44'),
(5,	'Adnan',	'Khaled',	'a.khaled@mail.com',	'35550005',	'Villa 25, Avenue 9',	'Saar',	'Bahrain',	'2025-11-12 15:21:44'),
(6,	'Maryam',	'Saleh',	'm.saleh@mail.com',	'35550006',	'Flat 12, Road 33',	'Manama',	'Bahrain',	'2025-11-12 15:21:44'),
(7,	'Ali',	'Mahmood',	'a.mahmood@mail.com',	'35550007',	'Building 8, Road 5',	'Riffa',	'Bahrain',	'2025-11-12 15:21:44'),
(8,	'Khawla',	'Ahmed',	'k.ahmed@mail.com',	'35550008',	'House 3, Road 7',	'Budaiya',	'Bahrain',	'2025-11-12 15:21:44'),
(9,	'Zainab',	'Noor',	'z.noor@mail.com',	'35550009',	'Flat 9, Avenue 12',	'Isa Town',	'Bahrain',	'2025-11-12 15:21:44'),
(10,	'Yousif',	'Nasser',	'y.nasser@mail.com',	'35550010',	'Building 15, Road 10',	'Hidd',	'Bahrain',	'2025-11-12 15:21:44');

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

INSERT INTO `loans` (`loan_id`, `customer_id`, `loan_type`, `amount`, `interest_rate`, `start_date`, `end_date`, `status`) VALUES
(1,	1,	'Personal',	5000.00,	4.50,	'2024-01-01',	'2027-01-01',	'Active'),
(2,	2,	'Auto',	8000.00,	3.80,	'2023-06-01',	'2028-06-01',	'Active'),
(3,	3,	'Mortgage',	45000.00,	2.90,	'2022-05-01',	'2042-05-01',	'Active'),
(4,	4,	'Personal',	3000.00,	5.00,	'2024-03-01',	'2026-03-01',	'Active'),
(5,	5,	'Auto',	12000.00,	3.60,	'2023-09-01',	'2028-09-01',	'Active'),
(6,	6,	'Personal',	2000.00,	6.00,	'2025-01-15',	'2027-01-15',	'Active'),
(7,	7,	'Mortgage',	55000.00,	2.70,	'2021-12-01',	'2041-12-01',	'Active');

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

INSERT INTO `payments` (`payment_id`, `loan_id`, `payment_date`, `amount_paid`, `method`) VALUES
(1,	1,	'2024-03-01',	150.00,	'Transfer'),
(2,	1,	'2024-04-01',	150.00,	'Transfer'),
(3,	2,	'2024-02-15',	200.00,	'Card'),
(4,	3,	'2024-06-20',	400.00,	'Transfer'),
(5,	4,	'2024-04-10',	250.00,	'Cash'),
(6,	5,	'2024-07-05',	300.00,	'Transfer'),
(7,	6,	'2025-02-01',	100.00,	'Card'),
(8,	7,	'2024-12-01',	500.00,	'Transfer');

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

INSERT INTO `transactions` (`transaction_id`, `account_id`, `amount`, `transaction_type`, `description`, `created_at`) VALUES
(1,	1,	500.00,	'Deposit',	'Salary credit',	'2025-11-12 15:21:44'),
(2,	1,	-100.00,	'Withdrawal',	'ATM withdrawal',	'2025-11-12 15:21:44'),
(3,	2,	200.00,	'Deposit',	'Transfer from main account',	'2025-11-12 15:21:44'),
(4,	3,	-50.00,	'Withdrawal',	'Card payment',	'2025-11-12 15:21:44'),
(5,	4,	1500.00,	'Deposit',	'Bonus payment',	'2025-11-12 15:21:44'),
(6,	5,	-250.00,	'Withdrawal',	'Utility payment',	'2025-11-12 15:21:44'),
(7,	6,	300.00,	'Deposit',	'Gift transfer',	'2025-11-12 15:21:44'),
(8,	7,	-120.00,	'Withdrawal',	'Groceries',	'2025-11-12 15:21:44'),
(9,	8,	700.00,	'Deposit',	'Freelance payment',	'2025-11-12 15:21:44'),
(10,	9,	-200.00,	'Withdrawal',	'Online shopping',	'2025-11-12 15:21:44'),
(11,	10,	1000.00,	'Deposit',	'Project income',	'2025-11-12 15:21:44');

-- 2025-11-15 13:02:45
