-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Hazırlanma Vaxtı: 25 Okt, 2021 saat 09:49
-- Server versiyası: 8.0.21
-- PHP Versiyası: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Verilənlər Bazası: `bookstore`
--

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `abouts`
--

DROP TABLE IF EXISTS `abouts`;
CREATE TABLE IF NOT EXISTS `abouts` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `abouts`
--

INSERT INTO `abouts` (`id`, `about`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '<html>\r\n<head>\r\n	<title></title>\r\n</head>\r\n<body>\r\n<h3>BookStore<br />\r\nKifayat Ahmad Gizi</h3>\r\n</body>\r\n</html>', NULL, '2021-10-14 08:57:29', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activation_key` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_manage` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `admin`
--

INSERT INTO `admin` (`id`, `first_name`, `last_name`, `email`, `mobile`, `password`, `address`, `city`, `state`, `country`, `zip_code`, `phone`, `activation_key`, `is_active`, `is_manage`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(5, 'Book', 'Store', 'mqalayciyev@mail.ru', '+994000000000', '$2y$10$ZU9zp.grpRBEK.hkHa2Y2u8s7cCBhmDTjjCW8WJWvkPoIo1xLBbqq', 'C. Cabbarli 44', 'Baku', 'Baku', 'Azerbaijan', 'AZ1100', '+994000000000', NULL, 1, 1, 'FuwvYuFh70FVXVLx0G2GHjF6xmxHGnV08KopUSDzhrxbdcLEfGYGXGZmVTif', '2021-02-19 12:01:36', '2021-03-26 16:20:59', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `banners`
--

DROP TABLE IF EXISTS `banners`;
CREATE TABLE IF NOT EXISTS `banners` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `banner_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner_image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner_slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner_order` int NOT NULL,
  `banner_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `brand`
--

DROP TABLE IF EXISTS `brand`;
CREATE TABLE IF NOT EXISTS `brand` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `manage` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `brand_product`
--

DROP TABLE IF EXISTS `brand_product`;
CREATE TABLE IF NOT EXISTS `brand_product` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `brand_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `brand_product_brand_id_foreign` (`brand_id`),
  KEY `brand_product_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(31, 192, '2021-10-14 07:43:19', '2021-10-14 07:43:19', NULL),
(32, 192, '2021-10-23 09:08:46', '2021-10-23 09:08:46', NULL),
(33, 192, '2021-10-23 09:22:00', '2021-10-23 09:22:00', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `cart_product`
--

DROP TABLE IF EXISTS `cart_product`;
CREATE TABLE IF NOT EXISTS `cart_product` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cart_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `piece` int NOT NULL,
  `amount` decimal(5,2) NOT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_product_cart_id_foreign` (`cart_id`),
  KEY `cart_product_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `cart_product`
--

INSERT INTO `cart_product` (`id`, `cart_id`, `product_id`, `piece`, `amount`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(91, 31, 65, 1, '52.50', 'Pending', '2021-10-14 09:25:47', '2021-10-14 09:25:47', NULL),
(92, 31, 66, 1, '52.50', 'Pending', '2021-10-23 08:22:57', '2021-10-23 08:22:57', NULL),
(93, 32, 65, 1, '52.50', 'Pending', '2021-10-23 09:08:46', '2021-10-23 09:08:46', NULL),
(94, 33, 67, 1, '52.50', 'Pending', '2021-10-23 09:22:00', '2021-10-25 07:05:20', '2021-10-25 07:05:20'),
(95, 33, 65, 1, '52.50', 'Pending', '2021-10-25 07:36:50', '2021-10-25 07:38:04', '2021-10-25 07:38:04');

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `top_id` int DEFAULT NULL,
  `category_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `manage` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `category`
--

INSERT INTO `category` (`id`, `top_id`, `category_name`, `slug`, `manage`, `created_at`, `updated_at`, `deleted_at`) VALUES
(73, NULL, 'Azerbaijan', 'azerbaycan', 0, '2021-10-14 06:38:17', '2021-10-14 06:40:19', NULL),
(74, NULL, 'English', 'english', 0, '2021-10-14 06:38:28', '2021-10-14 06:38:28', NULL),
(75, NULL, 'Russian', 'russkiy', 0, '2021-10-14 06:39:08', '2021-10-14 06:40:02', NULL),
(76, NULL, 'Arabic', 'arabic', 0, '2021-10-14 06:39:42', '2021-10-14 06:39:42', NULL),
(77, NULL, 'Korean', 'korean', 0, '2021-10-14 09:18:19', '2021-10-14 09:18:19', NULL),
(78, NULL, 'French', 'french', 0, '2021-10-14 09:19:19', '2021-10-14 09:19:19', NULL),
(79, NULL, 'Japanese', 'japanese', 0, '2021-10-14 09:20:14', '2021-10-14 09:20:14', NULL),
(80, NULL, 'Italian', 'italian', 0, '2021-10-14 09:21:08', '2021-10-14 09:21:08', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `category_product`
--

DROP TABLE IF EXISTS `category_product`;
CREATE TABLE IF NOT EXISTS `category_product` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_product_category_id_foreign` (`category_id`),
  KEY `category_product_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `category_product`
--

INSERT INTO `category_product` (`id`, `category_id`, `product_id`) VALUES
(60, 76, 60),
(61, 74, 61),
(62, 73, 62),
(63, 75, 63),
(64, 77, 64),
(65, 78, 65),
(66, 79, 66),
(67, 80, 67);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `feedback` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `message`, `feedback`, `created_at`, `updated_at`, `deleted_at`) VALUES
(7, 'Mehemmed Qalayciyev', 'qalayciyev@gmail.com', 'sass', NULL, '2021-10-23 07:50:35', '2021-10-23 07:50:35', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manage` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `customer`
--

INSERT INTO `customer` (`id`, `name`, `company`, `email`, `mobile`, `phone`, `website`, `fax`, `zip_code`, `country`, `state`, `city`, `street`, `manage`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Ceyhun Hasanov', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-26 17:41:38', '2018-05-17 16:37:14', '2018-05-17 16:37:14'),
(2, 'Zaur Mammadli', NULL, 'zaurmemmadli@gmail.com', NULL, NULL, NULL, NULL, NULL, 'Azerbaijan', NULL, NULL, 'Baku', 0, '2020-03-27 21:12:24', '2020-07-04 04:01:58', '2020-07-04 04:01:58'),
(3, 'Sub', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-09-18 00:55:25', '2020-09-18 00:55:25', NULL),
(4, 'subh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-09-18 00:55:29', '2020-09-18 00:55:29', NULL),
(5, 'Subhan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-09-18 00:55:36', '2020-09-18 00:55:36', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `infos`
--

DROP TABLE IF EXISTS `infos`;
CREATE TABLE IF NOT EXISTS `infos` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `logo` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `facebook` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `instagram` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `twitter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `youtube` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `pinterest` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `delivery` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `infos`
--

INSERT INTO `infos` (`id`, `logo`, `title`, `description`, `keywords`, `phone`, `mobile`, `email`, `address`, `facebook`, `instagram`, `twitter`, `youtube`, `pinterest`, `delivery`) VALUES
(1, 'logo-1634204181.png', 'BookStore', 'BookStore', 'BookStore', '+99 ** *** ** **', '+99 ** *** ** **', 'info@bookstore.uk', 'C.Cabbarli 44', 'https://www.facebook.com/', 'https://instagram.com/', 'https://www.twitter.com/', 'https://www.youtube.com/', 'https://www.pinterest.com', 'Catdirilma xidmeti');

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(16, '2018_03_22_101115_create_category_table', 1),
(17, '2018_03_22_130714_create_product_table', 1),
(18, '2018_03_22_165805_create_category_product_table', 1),
(19, '2018_03_23_063758_create_product_detail_table', 1),
(20, '2018_03_24_131540_create_user_table', 1),
(21, '2018_03_27_063926_create_cart_table', 1),
(22, '2018_03_27_064601_create_cart_product_table', 1),
(23, '2018_03_28_085845_create_order_table', 1),
(24, '2018_03_28_085948_create_user_detail_table', 1),
(25, '2018_03_28_090033_create_product_image_table', 1),
(26, '2018_04_12_214139_create_brand_table', 1),
(27, '2018_04_16_164623_create_supplier_table', 1),
(28, '2018_04_17_185615_create_supplier_product_table', 1),
(29, '2018_04_18_114617_create_tag_table', 1),
(30, '2018_04_18_130456_create_tag_product_table', 1),
(31, '2018_04_23_210853_create_brand_product_table', 2),
(32, '2018_04_24_105708_create_admin_table', 3),
(33, '2018_04_26_151002_create_customer_table', 4),
(34, '2018_05_10_180233_create_rating_table', 5),
(41, '2021_02_25_130226_create_wish_list_table', 6),
(42, '2021_03_02_115938_create_sliders_table', 6),
(43, '2021_03_02_130744_create_banners_table', 6),
(45, '2021_03_02_153617_create_reviews_table', 7);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cart_id` int UNSIGNED NOT NULL,
  `order_amount` decimal(10,2) NOT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installment_number` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_cart_id_unique` (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `order`
--

INSERT INTO `order` (`id`, `cart_id`, `order_amount`, `status`, `first_name`, `last_name`, `address`, `phone`, `mobile`, `bank`, `installment_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(14, 31, '105.00', 'Your order has been received', 'Mehemmed', 'Qalayciyev', 'Baku Umid Ekberov 86', '+994514598208', '+994514598208', 'Qapıda Ödəmə', 1, '2021-10-23 08:28:06', '2021-10-23 12:19:18', NULL),
(15, 32, '52.50', 'Your order has been received', 'Mehemmed', 'Qalayciyev', 'Baku Umid Ekberov 86', '+994514598208', '+994514598208', 'Payment at the door', 1, '2021-10-23 09:09:02', '2021-10-23 12:19:29', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'mqalayciyev@mail.ru', 'SmK6PJCJ05XnYBWE2XSlWFAmymuNZxqoTiifYw0qsi2PCy1Z9exVAw2hnAxK', '2021-03-05 16:28:11', '2021-03-05 16:33:32', '2021-03-05 16:33:32');

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_discription` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stok_piece` int NOT NULL,
  `supply_price` decimal(6,2) NOT NULL,
  `markup` decimal(6,2) DEFAULT NULL,
  `retail_price` decimal(6,2) NOT NULL,
  `discount` decimal(6,2) DEFAULT NULL,
  `sale_price` decimal(6,2) NOT NULL,
  `point_of_sale` tinyint(1) NOT NULL DEFAULT '0',
  `wish_list` tinyint(1) DEFAULT '0',
  `manage` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `product`
--

INSERT INTO `product` (`id`, `slug`, `product_name`, `product_description`, `meta_title`, `meta_discription`, `stok_piece`, `supply_price`, `markup`, `retail_price`, `discount`, `sale_price`, `point_of_sale`, `wish_list`, `manage`, `created_at`, `updated_at`, `deleted_at`) VALUES
(60, 'arabic-reading', 'Arabic Reading', '<html><head><title></title></head><body>Arabic Reading</body></html>', 'Arabic Reading', 'Arabic Reading', 10, '50.00', '50.00', '75.00', NULL, '75.00', 0, 0, 0, '2021-10-14 09:13:16', '2021-10-14 09:13:16', NULL),
(61, 'english-reading', 'English Reading', '<html><head><title></title></head><body>English Reading</body></html>', 'English Reading', 'English Reading', 10, '50.00', '50.00', '75.00', NULL, '75.00', 0, 0, 0, '2021-10-14 09:15:37', '2021-10-14 09:15:37', NULL),
(62, 'azerbaijan-reading', 'Azerbaijan Reading', '<html><head><title></title></head><body>Azerbaijan Reading</body></html>', 'Azerbaijan Reading', 'Azerbaijan Reading', 10, '50.00', '50.00', '75.00', NULL, '75.00', 0, 0, 0, '2021-10-14 09:16:34', '2021-10-14 09:16:34', NULL),
(63, 'russian-reading', 'Russian Reading', '<html><head><title></title></head><body>Russian Reading</body></html>', 'Russian Reading', 'Russian Reading', 10, '50.00', '50.00', '75.00', NULL, '75.00', 0, 0, 0, '2021-10-14 09:17:32', '2021-10-14 09:17:32', NULL),
(64, 'korean-reading', 'Korean Reading', '<html><head><title></title></head><body>Korean Reading</body></html>', 'Korean Reading', 'Korean Reading', 10, '50.00', '50.00', '75.00', '30.00', '52.50', 0, 0, 0, '2021-10-14 09:18:40', '2021-10-14 09:18:40', NULL),
(65, 'french-reading', 'French Reading', '<html><head><title></title></head><body>French Reading</body></html>', 'French Reading', 'French Reading', 10, '50.00', '50.00', '75.00', '30.00', '52.50', 0, 0, 0, '2021-10-14 09:19:34', '2021-10-23 12:18:56', NULL),
(66, 'japanese-reading', 'Japanese Reading', '<html><head><title></title></head><body>Japanese Reading</body></html>', 'Japanese Reading', 'Japanese Reading', 10, '50.00', '50.00', '75.00', '30.00', '52.50', 0, 0, 0, '2021-10-14 09:20:29', '2021-10-23 12:18:56', NULL),
(67, 'italian-reading', 'Italian Reading', '<html><head><title></title></head><body>Italian Reading</body></html>', 'Italian Reading', 'Italian Reading', 10, '50.00', '50.00', '75.00', '30.00', '52.50', 0, 0, 0, '2021-10-14 09:21:25', '2021-10-14 09:21:25', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `product_detail`
--

DROP TABLE IF EXISTS `product_detail`;
CREATE TABLE IF NOT EXISTS `product_detail` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED NOT NULL,
  `show_slider` tinyint(1) NOT NULL DEFAULT '0',
  `show_new_collection` tinyint(1) NOT NULL DEFAULT '0',
  `show_hot_deal` tinyint(1) NOT NULL DEFAULT '0',
  `show_best_seller` tinyint(1) NOT NULL DEFAULT '0',
  `show_latest_products` tinyint(1) NOT NULL DEFAULT '0',
  `show_deals_of_the_day` tinyint(1) NOT NULL DEFAULT '0',
  `show_picked_for_you` tinyint(1) NOT NULL DEFAULT '0',
  `size_s` tinyint(1) NOT NULL DEFAULT '0',
  `size_xs` tinyint(1) NOT NULL DEFAULT '0',
  `size_m` tinyint(1) NOT NULL DEFAULT '0',
  `size_l` tinyint(1) NOT NULL DEFAULT '0',
  `size_xl` tinyint(1) NOT NULL DEFAULT '0',
  `size_sl` tinyint(1) NOT NULL DEFAULT '0',
  `color_red` int NOT NULL DEFAULT '0',
  `color_black` int NOT NULL DEFAULT '0',
  `color_white` int NOT NULL DEFAULT '0',
  `color_green` int NOT NULL DEFAULT '0',
  `color_orange` int NOT NULL DEFAULT '0',
  `color_blue` int NOT NULL DEFAULT '0',
  `color_pink` int NOT NULL DEFAULT '0',
  `color_yellow` int NOT NULL DEFAULT '0',
  `color_cyan` int NOT NULL DEFAULT '0',
  `color_grey` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_detail_product_id_unique` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `product_detail`
--

INSERT INTO `product_detail` (`id`, `product_id`, `show_slider`, `show_new_collection`, `show_hot_deal`, `show_best_seller`, `show_latest_products`, `show_deals_of_the_day`, `show_picked_for_you`, `size_s`, `size_xs`, `size_m`, `size_l`, `size_xl`, `size_sl`, `color_red`, `color_black`, `color_white`, `color_green`, `color_orange`, `color_blue`, `color_pink`, `color_yellow`, `color_cyan`, `color_grey`) VALUES
(60, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(61, 61, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(62, 62, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(63, 63, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(64, 64, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(65, 65, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(66, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(67, 67, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `product_image`
--

DROP TABLE IF EXISTS `product_image`;
CREATE TABLE IF NOT EXISTS `product_image` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED NOT NULL,
  `image_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumb_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `main_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_image_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `product_image`
--

INSERT INTO `product_image` (`id`, `product_id`, `image_name`, `thumb_name`, `main_name`, `created_at`, `updated_at`) VALUES
(90, 60, 'product-0_60_1634202796.webp', 'thumb_product-0_60_1634202796.webp', 'main_product-0_60_1634202796.webp', '2021-10-14 09:13:16', '2021-10-14 09:13:16'),
(91, 61, 'product-0_61_1634202938.webp', 'thumb_product-0_61_1634202938.webp', 'main_product-0_61_1634202938.webp', '2021-10-14 09:15:38', '2021-10-14 09:15:38'),
(92, 62, 'product-0_62_1634202994.webp', 'thumb_product-0_62_1634202994.webp', 'main_product-0_62_1634202994.webp', '2021-10-14 09:16:35', '2021-10-14 09:16:35'),
(93, 63, 'product-0_63_1634203052.webp', 'thumb_product-0_63_1634203052.webp', 'main_product-0_63_1634203052.webp', '2021-10-14 09:17:32', '2021-10-14 09:17:32'),
(94, 64, 'product-0_64_1634203120.webp', 'thumb_product-0_64_1634203120.webp', 'main_product-0_64_1634203120.webp', '2021-10-14 09:18:41', '2021-10-14 09:18:41'),
(95, 65, 'product-0_65_1634203174.webp', 'thumb_product-0_65_1634203174.webp', 'main_product-0_65_1634203174.webp', '2021-10-14 09:19:34', '2021-10-14 09:19:34'),
(96, 66, 'product-0_66_1634203229.webp', 'thumb_product-0_66_1634203229.webp', 'main_product-0_66_1634203229.webp', '2021-10-14 09:20:30', '2021-10-14 09:20:30'),
(97, 67, 'product-0_67_1634203285.webp', 'thumb_product-0_67_1634203285.webp', 'main_product-0_67_1634203285.webp', '2021-10-14 09:21:26', '2021-10-14 09:21:26');

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `rating`
--

DROP TABLE IF EXISTS `rating`;
CREATE TABLE IF NOT EXISTS `rating` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `rating` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `rating`
--

INSERT INTO `rating` (`id`, `product_id`, `rating`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 1),
(5, 5, 5),
(6, 6, 1),
(7, 7, 2),
(8, 8, 4),
(9, 9, 1),
(10, 10, 2),
(11, 11, 5),
(12, 12, 3),
(13, 13, 2),
(14, 13, 5),
(15, 13, 5),
(16, 6, 5),
(17, 4, 3),
(18, 4, 3),
(19, 4, 3),
(20, 4, 5),
(21, 4, 5),
(22, 4, 5),
(23, 4, 5),
(24, 4, 1),
(25, 6, 5),
(26, 10, 5),
(27, 12, 5),
(28, 11, 1),
(29, 13, 1),
(30, 10, 1),
(31, 1, 5),
(32, 11, 5),
(33, 11, 1),
(34, 11, 1),
(35, 11, 4),
(36, 11, 5),
(37, 11, 1),
(38, 11, 5),
(39, 1, 5),
(40, 2, 1),
(41, 11, 5),
(42, 12, 5),
(43, 12, 1),
(44, 11, 5),
(45, 11, 5),
(46, 10, 5),
(47, 10, 5),
(48, 9, 5),
(49, 7, 5),
(50, 4, 1),
(51, 21, 5),
(52, 19, 4),
(53, 19, 5),
(54, 20, 1),
(55, 20, 3),
(56, 25, 3),
(57, 26, 3),
(58, 25, 4),
(59, 26, 4),
(60, 18, 2),
(61, 18, 5),
(62, 18, 5),
(63, 18, 4),
(64, 25, 5),
(65, 36, 5),
(66, 36, 3),
(67, 35, 3),
(68, 37, 4),
(69, 40, 4),
(70, 40, 5),
(71, 40, 5),
(72, 37, 4),
(73, 36, 5),
(74, 37, 5),
(75, 43, 5),
(76, 46, 5),
(77, 50, 5),
(78, 50, 2),
(79, 50, 1),
(80, 50, 5),
(81, 50, 5),
(82, 50, 5),
(83, 51, 5),
(84, 51, 5),
(85, 51, 5),
(86, 53, 5),
(87, 52, 5),
(88, 47, 5),
(89, 48, 5),
(90, 49, 5),
(91, 35, 5),
(92, 58, 5);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `review` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int NOT NULL,
  `rating` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `shipping_returns`
--

DROP TABLE IF EXISTS `shipping_returns`;
CREATE TABLE IF NOT EXISTS `shipping_returns` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `shipping_return` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `shipping_returns`
--

INSERT INTO `shipping_returns` (`id`, `shipping_return`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '<html>\r\n<head>\r\n	<title></title>\r\n</head>\r\n<body>\r\n<article>\r\n<h1>BookStore</h1>\r\n</article>\r\n</body>\r\n</html>', NULL, '2021-10-14 08:56:29', NULL),
(2, '<html>\r\n<head>\r\n	<title></title>\r\n</head>\r\n<body>\r\n<article>\r\n<h3>Sifarişin izlənilməsi</h3>\r\n\r\n<p>Kuryer ilə planlı və ya ekspress &ccedil;atdırılmanı se&ccedil;dikdə siz sifariş &ccedil;atdırılmaya veriləndə və kuryer sizə y&ouml;nlənəndə SMS bildirişlərini alacaqsınız.</p>\r\n\r\n<p>Təhvil məntəqələrindən alınmanı se&ccedil;diyiniz zaman sifariş təhvil məntəqəsinə &ccedil;atdırıldıqda siz SMS bildirişini alacaqsınız.</p>\r\n</article>\r\n\r\n<article>\r\n<h3>&Ccedil;atdırılma vaxtının dəyişdirilməsi</h3>\r\n\r\n<p>Əgər planlarınız dəyişib və &ccedil;atdırılma vaxtını və ya &uuml;nvanını dəyişmək lazımdırsa, 915 n&ouml;mrəsinə zəng vuraraq &Ccedil;ağrı mərkəzi ilə əlaqə saxlamağınız xahiş olunur.</p>\r\n</article>\r\n\r\n<article>\r\n<h3>Təhvil məntəqəsini necə tapmaq olar</h3>\r\n\r\n<p>Umico Market-in təhvil məntəqələrinin aktual siyahısı ilə burada tanış ola bilərsiniz</p>\r\n</article>\r\n\r\n<article>\r\n<h3>Sifarişin yoxlanılması</h3>\r\n\r\n<p>Kuryer tərəfindən &ccedil;atdırılan malları siz hər zaman zədələrin olub-olmamasını, mal dəstinin tam olmasını və işlək vəziyyətdə olub-olmamasını yoxlaya bilərsiniz. Xahiş olunur nəzərinizə alasınız ki, sifariş təhvil alındıqda yoxlanılmasa, m&uuml;bahisəli hadisələrin sizin xeyrinizə həll olunmasına zəmanət verə bilmirik.</p>\r\n\r\n<p>Quraşdırılma tələb olunan texnikanın işlək vəziyyətdə olub-olmamasını avtorizə edilmiş servis mərkəzinin ustası yoxlayır.</p>\r\n\r\n<p>Mallar təhvil məntəqəsindən alındıqda, sifarişin yoxlanılma imkanları təhvil məntəqəsinin n&ouml;v&uuml;ndən asılı olur. Sifarişin yoxlanılması imkanı ekspress təhvil məntəqələri istisna olmaqla, b&uuml;t&uuml;n təhvil məntəqələrində m&ouml;vcuddur. Ekspress təhvil məntəqələrində bağlamaları yoxlamadan yalnız təhvil ala bilərsiniz.</p>\r\n</article>\r\n\r\n<article>\r\n<h3>&Ouml;dəmə &uuml;sulları</h3>\r\n\r\n<p>Umico Market-də yerləşdirilən istənilən sifarişi sizin se&ccedil;iminizə uyğun olaraq n&ouml;vbəti &uuml;sullar ilə &ouml;dəniş edə bilərsiniz:</p>\r\n<img alt=\"\" src=\"https://umico.az/images/shipping-payment/credit-card.svg\" /><br />\r\n&Ouml;dəmə kartı vasitəsi ilə onlayn<br />\r\n<img alt=\"\" src=\"https://umico.az/images/shipping-payment/card-terminal.svg\" /><br />\r\n&Ouml;dəmə kartı vasitəsi ilə məhsulu təhvil alarkən<br />\r\n<img alt=\"\" src=\"https://umico.az/images/shipping-payment/purse.svg\" /><br />\r\nNəğd pul ilə</article>\r\n</body>\r\n</html>', '2021-03-11 18:33:23', '2021-03-11 18:33:23', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `sliders`
--

DROP TABLE IF EXISTS `sliders`;
CREATE TABLE IF NOT EXISTS `sliders` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `slider_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slider_image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slider_slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slider_order` int NOT NULL,
  `slider_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `sliders`
--

INSERT INTO `sliders` (`id`, `slider_name`, `slider_image`, `slider_slug`, `slider_order`, `slider_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'undefined', 'slider_1634205787.webp', 'slider1', 1, 1, '2021-03-02 22:10:33', '2021-10-14 10:03:08', NULL),
(2, 'slider2', 'slider_1634205809.webp', 'slider2', 2, 1, '2021-03-02 22:10:54', '2021-10-14 10:03:30', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `markup` int NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manage` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `supplier`
--

INSERT INTO `supplier` (`id`, `name`, `first_name`, `last_name`, `markup`, `description`, `company`, `email`, `phone`, `mobile`, `fax`, `website`, `postcode`, `state`, `country`, `manage`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Ceyhun Hasanov', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-19 09:24:26', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(2, 'Ziya Azimzade', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-19 17:00:16', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(3, 'Ramal Aliyev', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-20 14:33:19', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(4, 'Vüsal Hasanov', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-20 14:36:22', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(5, 'Cavid Hasanov', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-23 06:33:34', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(6, 'Kenan Gulahmedov', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-23 13:44:52', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(7, 'Murad Nurehmedov', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-23 17:30:10', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(8, 'Fuad Ibrahimbeyov', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-04-26 17:31:30', '2018-05-17 16:36:55', '2018-05-17 16:36:55'),
(9, 'cavidan', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2018-11-29 12:52:23', '2020-07-19 18:55:02', '2020-07-19 18:55:02'),
(10, 'royal', NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2019-06-06 16:01:03', '2020-07-19 18:55:02', '2020-07-19 18:55:02'),
(11, 'raml', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-02 17:26:29', '2020-07-19 18:55:02', '2020-07-19 18:55:02'),
(12, 'NERGIZ', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-11 01:06:09', '2020-07-19 18:55:02', '2020-07-19 18:55:02'),
(13, 'iu', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-23 19:47:44', '2020-07-23 19:47:44', NULL),
(14, 'Mobil__az', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-08-03 02:55:07', '2020-08-03 02:55:07', NULL),
(15, 'Aliyev', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-08-14 20:56:21', '2020-08-14 20:56:21', NULL),
(16, 'Rm', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-08-14 21:00:29', '2020-08-14 21:00:29', NULL),
(17, 'Mr', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-08-14 21:00:35', '2020-08-14 21:00:35', NULL),
(18, 'dodo', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-08-14 21:08:14', '2020-08-14 21:08:14', NULL),
(19, 'do', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-08-14 21:08:17', '2020-08-14 21:08:17', NULL),
(20, 'Perviz bəy', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-09-01 16:19:29', '2021-01-24 01:29:20', '2021-01-24 01:29:20'),
(21, 'cavid', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-09-13 15:59:33', '2021-01-24 01:29:10', '2021-01-24 01:29:10'),
(22, 'SLgifts', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2020-12-07 05:58:10', '2020-12-07 05:58:10', NULL),
(23, 'Ruslan', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2021-02-23 06:05:16', '2021-02-23 06:05:16', NULL),
(24, 'Arif', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2021-02-23 06:06:40', '2021-02-23 06:06:40', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `supplier_product`
--

DROP TABLE IF EXISTS `supplier_product`;
CREATE TABLE IF NOT EXISTS `supplier_product` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `supplier_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `supplier_product_supplier_id_foreign` (`supplier_id`),
  KEY `supplier_product_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `manage` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `tag_product`
--

DROP TABLE IF EXISTS `tag_product`;
CREATE TABLE IF NOT EXISTS `tag_product` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_product_tag_id_foreign` (`tag_id`),
  KEY `tag_product_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activation_key` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `manage` int NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_uindex` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `mobile`, `password`, `activation_key`, `is_active`, `manage`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(192, 'Mehemmed', 'Qalayciyev', 'qalayciyev@gmail.com', '+994514598208', '$2y$10$e7N.YIKOSTRYubzOvARZp.WoDaym0VMPLtE5laJuW5laoXw9tRR0y', NULL, 1, 0, NULL, '2021-10-14 07:43:19', '2021-10-23 09:08:16', NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `user_detail`
--

DROP TABLE IF EXISTS `user_detail`;
CREATE TABLE IF NOT EXISTS `user_detail` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_detail_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `user_detail`
--

INSERT INTO `user_detail` (`id`, `user_id`, `address`, `city`, `state`, `country`, `zip_code`, `phone`) VALUES
(193, 192, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `wish_list`
--

DROP TABLE IF EXISTS `wish_list`;
CREATE TABLE IF NOT EXISTS `wish_list` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `wish_list`
--

INSERT INTO `wish_list` (`id`, `user_id`, `product_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 174, 58, '2021-03-09 06:01:11', '2021-03-09 06:01:21', '2021-03-09 06:01:21'),
(2, 176, 56, '2021-03-10 20:08:45', '2021-03-10 20:08:45', NULL),
(3, 176, 57, '2021-03-10 20:09:02', '2021-03-10 20:09:02', NULL),
(4, 176, 55, '2021-03-10 20:09:11', '2021-03-10 20:09:11', NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `brand_product`
--
ALTER TABLE `brand_product`
  ADD CONSTRAINT `brand_product_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `brand_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_product`
--
ALTER TABLE `cart_product`
  ADD CONSTRAINT `cart_product_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_product`
--
ALTER TABLE `category_product`
  ADD CONSTRAINT `category_product_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `category_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_detail`
--
ALTER TABLE `product_detail`
  ADD CONSTRAINT `product_detail_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_image`
--
ALTER TABLE `product_image`
  ADD CONSTRAINT `product_image_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supplier_product`
--
ALTER TABLE `supplier_product`
  ADD CONSTRAINT `supplier_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supplier_product_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tag_product`
--
ALTER TABLE `tag_product`
  ADD CONSTRAINT `tag_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tag_product_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_detail`
--
ALTER TABLE `user_detail`
  ADD CONSTRAINT `user_detail_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
