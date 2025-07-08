-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: phonestore1
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `idbrand` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`idbrand`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Xiaomi'),(2,'Samsung'),(3,'Xmobile'),(4,'Apple'),(5,'Oppo'),(6,'Sony'),(7,'Anker'),(8,'Baseus');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `CartID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `Product_Item_ID` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  `AddedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CartID`),
  KEY `UserID` (`UserID`),
  KEY `fk_cart_product_item_idx` (`Product_Item_ID`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `fk_cart_product_item` FOREIGN KEY (`Product_Item_ID`) REFERENCES `product_item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (24,4,27,7,'2025-04-15 14:27:35'),(25,5,28,1,'2025-04-16 03:59:51'),(26,4,37,9,'2025-04-16 06:57:40'),(27,5,37,11,'2025-04-16 07:01:10'),(28,5,29,6,'2025-04-16 07:33:24'),(29,5,35,5,'2025-04-16 07:39:01'),(30,5,27,6,'2025-04-16 07:39:58'),(31,5,20,7,'2025-04-16 07:59:08'),(32,5,44,1,'2025-04-17 02:28:11'),(33,NULL,22,1,'2025-05-16 00:41:57');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CategoryID`),
  UNIQUE KEY `CategoryName` (`CategoryName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Điện thoại','2025-03-10 11:51:51'),(2,'Tai nghe','2025-03-18 14:27:01'),(3,'Cáp sạc','2025-03-29 01:06:10'),(4,'Sạc dự phòng','2025-04-13 16:40:10'),(5,'Adapter sạc','2025-04-17 01:24:06');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `DiscountID` int NOT NULL AUTO_INCREMENT,
  `DiscountCode` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `DiscountType` enum('percentage','fixed') COLLATE utf8mb4_general_ci DEFAULT 'percentage',
  `DiscountValue` decimal(10,2) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`DiscountID`),
  UNIQUE KEY `DiscountCode` (`DiscountCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `ImageID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `ImageURL` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ImageID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `images_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `Action` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ActionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LogID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `NotificationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `Message` text COLLATE utf8mb4_general_ci NOT NULL,
  `IsRead` tinyint(1) DEFAULT '0',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NotificationID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `idorder_status` int NOT NULL AUTO_INCREMENT,
  `idorder` int NOT NULL,
  `status` varchar(45) NOT NULL,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idorder_status`),
  KEY `fk_order_status1_idx` (`idorder`),
  CONSTRAINT `fk_order_1` FOREIGN KEY (`idorder`) REFERENCES `orders` (`OrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=1445 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (12,19,'Chờ duyệt','2025-04-10 04:48:54'),(13,19,'Chuẩn bị hàng','2025-04-10 04:50:03'),(14,20,'Chờ duyệt','2025-04-10 04:50:58'),(15,20,'Chuẩn bị hàng','2025-04-10 04:52:04'),(16,19,'Quá hạn thanh toán','2025-04-10 12:32:03'),(17,20,'Quá hạn thanh toán','2025-04-10 12:32:03'),(18,19,'Chuẩn bị hàng','2025-04-10 12:33:07'),(19,20,'Chuẩn bị hàng','2025-04-10 12:33:07'),(20,21,'Chờ duyệt','2025-04-10 12:35:43'),(21,22,'Chờ duyệt','2025-04-10 12:35:57'),(22,23,'Chờ duyệt','2025-04-10 12:36:05'),(23,24,'Chờ duyệt','2025-04-10 12:39:23'),(24,24,'Chuẩn bị hàng','2025-04-10 12:40:06'),(25,22,'Quá hạn thanh toán','2025-04-11 00:44:04'),(26,23,'Quá hạn thanh toán','2025-04-11 00:44:04'),(27,22,'Quá hạn thanh toán','2025-04-11 00:45:03'),(28,23,'Quá hạn thanh toán','2025-04-11 00:45:03'),(29,22,'Quá hạn thanh toán','2025-04-11 00:46:04'),(30,23,'Quá hạn thanh toán','2025-04-11 00:46:04'),(31,22,'Quá hạn thanh toán','2025-04-11 00:47:02'),(32,23,'Quá hạn thanh toán','2025-04-11 00:47:02'),(33,22,'Quá hạn thanh toán','2025-04-11 00:48:03'),(34,23,'Quá hạn thanh toán','2025-04-11 00:48:03'),(35,22,'Quá hạn thanh toán','2025-04-11 00:49:05'),(36,23,'Quá hạn thanh toán','2025-04-11 00:49:05'),(37,22,'Quá hạn thanh toán','2025-04-11 00:50:04'),(38,23,'Quá hạn thanh toán','2025-04-11 00:50:04'),(39,22,'Quá hạn thanh toán','2025-04-11 00:51:04'),(40,23,'Quá hạn thanh toán','2025-04-11 00:51:04'),(41,22,'Quá hạn thanh toán','2025-04-11 00:54:04'),(42,23,'Quá hạn thanh toán','2025-04-11 00:54:04'),(43,22,'Quá hạn thanh toán','2025-04-11 00:55:03'),(44,23,'Quá hạn thanh toán','2025-04-11 00:55:03'),(45,22,'Quá hạn thanh toán','2025-04-11 00:56:03'),(46,23,'Quá hạn thanh toán','2025-04-11 00:56:03'),(47,22,'Quá hạn thanh toán','2025-04-11 00:57:04'),(48,23,'Quá hạn thanh toán','2025-04-11 00:57:04'),(49,22,'Quá hạn thanh toán','2025-04-11 00:58:04'),(50,23,'Quá hạn thanh toán','2025-04-11 00:58:04'),(51,22,'Quá hạn thanh toán','2025-04-11 00:59:03'),(52,23,'Quá hạn thanh toán','2025-04-11 00:59:03'),(53,22,'Quá hạn thanh toán','2025-04-11 01:00:03'),(54,23,'Quá hạn thanh toán','2025-04-11 01:00:03'),(55,22,'Quá hạn thanh toán','2025-04-11 01:01:03'),(56,23,'Quá hạn thanh toán','2025-04-11 01:01:03'),(57,22,'Quá hạn thanh toán','2025-04-11 01:02:04'),(58,23,'Quá hạn thanh toán','2025-04-11 01:02:04'),(59,22,'Quá hạn thanh toán','2025-04-11 01:03:03'),(60,23,'Quá hạn thanh toán','2025-04-11 01:03:03'),(61,22,'Quá hạn thanh toán','2025-04-11 01:04:04'),(62,23,'Quá hạn thanh toán','2025-04-11 01:04:04'),(63,22,'Quá hạn thanh toán','2025-04-11 01:05:03'),(64,23,'Quá hạn thanh toán','2025-04-11 01:05:03'),(65,22,'Quá hạn thanh toán','2025-04-11 01:06:03'),(66,23,'Quá hạn thanh toán','2025-04-11 01:06:03'),(67,22,'Quá hạn thanh toán','2025-04-11 01:07:03'),(68,23,'Quá hạn thanh toán','2025-04-11 01:07:03'),(69,22,'Quá hạn thanh toán','2025-04-11 01:08:03'),(70,23,'Quá hạn thanh toán','2025-04-11 01:08:03'),(71,22,'Quá hạn thanh toán','2025-04-11 01:09:03'),(72,23,'Quá hạn thanh toán','2025-04-11 01:09:03'),(73,22,'Quá hạn thanh toán','2025-04-11 01:10:03'),(74,23,'Quá hạn thanh toán','2025-04-11 01:10:03'),(75,22,'Quá hạn thanh toán','2025-04-11 01:11:05'),(76,23,'Quá hạn thanh toán','2025-04-11 01:11:05'),(77,22,'Quá hạn thanh toán','2025-04-11 01:12:04'),(78,23,'Quá hạn thanh toán','2025-04-11 01:12:04'),(79,22,'Quá hạn thanh toán','2025-04-11 01:13:04'),(80,23,'Quá hạn thanh toán','2025-04-11 01:13:04'),(81,22,'Quá hạn thanh toán','2025-04-11 01:14:04'),(82,23,'Quá hạn thanh toán','2025-04-11 01:14:04'),(83,22,'Quá hạn thanh toán','2025-04-11 01:15:03'),(84,23,'Quá hạn thanh toán','2025-04-11 01:15:03'),(85,22,'Quá hạn thanh toán','2025-04-11 01:16:04'),(86,23,'Quá hạn thanh toán','2025-04-11 01:16:04'),(87,22,'Quá hạn thanh toán','2025-04-11 01:17:04'),(88,23,'Quá hạn thanh toán','2025-04-11 01:17:04'),(89,22,'Quá hạn thanh toán','2025-04-11 01:18:03'),(90,23,'Quá hạn thanh toán','2025-04-11 01:18:03'),(91,22,'Quá hạn thanh toán','2025-04-11 01:20:03'),(92,23,'Quá hạn thanh toán','2025-04-11 01:20:03'),(93,22,'Quá hạn thanh toán','2025-04-11 01:21:05'),(94,23,'Quá hạn thanh toán','2025-04-11 01:21:05'),(95,22,'Quá hạn thanh toán','2025-04-11 01:23:04'),(96,23,'Quá hạn thanh toán','2025-04-11 01:23:04'),(97,22,'Quá hạn thanh toán','2025-04-11 01:24:04'),(98,23,'Quá hạn thanh toán','2025-04-11 01:24:04'),(99,22,'Quá hạn thanh toán','2025-04-11 01:25:04'),(100,23,'Quá hạn thanh toán','2025-04-11 01:25:04'),(101,22,'Quá hạn thanh toán','2025-04-11 01:26:04'),(102,23,'Quá hạn thanh toán','2025-04-11 01:26:04'),(103,22,'Quá hạn thanh toán','2025-04-11 01:27:03'),(104,23,'Quá hạn thanh toán','2025-04-11 01:27:03'),(105,22,'Quá hạn thanh toán','2025-04-11 01:28:04'),(106,23,'Quá hạn thanh toán','2025-04-11 01:28:04'),(107,22,'Quá hạn thanh toán','2025-04-11 01:29:04'),(108,23,'Quá hạn thanh toán','2025-04-11 01:29:04'),(109,22,'Quá hạn thanh toán','2025-04-11 01:30:04'),(110,23,'Quá hạn thanh toán','2025-04-11 01:30:04'),(111,22,'Quá hạn thanh toán','2025-04-11 01:31:05'),(112,23,'Quá hạn thanh toán','2025-04-11 01:31:05'),(113,22,'Quá hạn thanh toán','2025-04-11 01:32:03'),(114,23,'Quá hạn thanh toán','2025-04-11 01:32:04'),(115,22,'Quá hạn thanh toán','2025-04-11 01:33:04'),(116,23,'Quá hạn thanh toán','2025-04-11 01:33:04'),(117,22,'Quá hạn thanh toán','2025-04-11 01:34:03'),(118,23,'Quá hạn thanh toán','2025-04-11 01:34:03'),(119,22,'Quá hạn thanh toán','2025-04-11 01:35:04'),(120,23,'Quá hạn thanh toán','2025-04-11 01:35:04'),(121,22,'Quá hạn thanh toán','2025-04-11 01:36:03'),(122,23,'Quá hạn thanh toán','2025-04-11 01:36:03'),(123,22,'Quá hạn thanh toán','2025-04-11 01:37:05'),(124,23,'Quá hạn thanh toán','2025-04-11 01:37:05'),(125,22,'Quá hạn thanh toán','2025-04-11 01:38:05'),(126,23,'Quá hạn thanh toán','2025-04-11 01:38:05'),(127,22,'Quá hạn thanh toán','2025-04-11 01:39:05'),(128,23,'Quá hạn thanh toán','2025-04-11 01:39:05'),(129,22,'Quá hạn thanh toán','2025-04-11 01:40:03'),(130,23,'Quá hạn thanh toán','2025-04-11 01:40:03'),(131,22,'Quá hạn thanh toán','2025-04-11 01:41:03'),(132,23,'Quá hạn thanh toán','2025-04-11 01:41:04'),(133,22,'Quá hạn thanh toán','2025-04-11 01:42:03'),(134,23,'Quá hạn thanh toán','2025-04-11 01:42:03'),(135,22,'Quá hạn thanh toán','2025-04-12 00:29:05'),(136,23,'Quá hạn thanh toán','2025-04-12 00:29:05'),(137,22,'Quá hạn thanh toán','2025-04-12 00:30:04'),(138,23,'Quá hạn thanh toán','2025-04-12 00:30:04'),(139,22,'Quá hạn thanh toán','2025-04-12 00:31:03'),(140,23,'Quá hạn thanh toán','2025-04-12 00:31:03'),(141,22,'Quá hạn thanh toán','2025-04-12 00:32:04'),(142,23,'Quá hạn thanh toán','2025-04-12 00:32:04'),(143,22,'Quá hạn thanh toán','2025-04-12 00:33:03'),(144,23,'Quá hạn thanh toán','2025-04-12 00:33:03'),(145,22,'Quá hạn thanh toán','2025-04-12 00:34:03'),(146,23,'Quá hạn thanh toán','2025-04-12 00:34:03'),(147,22,'Quá hạn thanh toán','2025-04-12 00:35:03'),(148,23,'Quá hạn thanh toán','2025-04-12 00:35:03'),(149,22,'Quá hạn thanh toán','2025-04-12 00:36:03'),(150,23,'Quá hạn thanh toán','2025-04-12 00:36:03'),(151,22,'Quá hạn thanh toán','2025-04-12 00:37:04'),(152,23,'Quá hạn thanh toán','2025-04-12 00:37:04'),(153,22,'Quá hạn thanh toán','2025-04-12 00:38:03'),(154,23,'Quá hạn thanh toán','2025-04-12 00:38:03'),(155,22,'Quá hạn thanh toán','2025-04-12 00:39:04'),(156,23,'Quá hạn thanh toán','2025-04-12 00:39:04'),(157,22,'Quá hạn thanh toán','2025-04-12 00:40:04'),(158,23,'Quá hạn thanh toán','2025-04-12 00:40:04'),(159,22,'Quá hạn thanh toán','2025-04-12 00:41:04'),(160,23,'Quá hạn thanh toán','2025-04-12 00:41:04'),(161,22,'Quá hạn thanh toán','2025-04-12 00:42:03'),(162,23,'Quá hạn thanh toán','2025-04-12 00:42:03'),(163,22,'Quá hạn thanh toán','2025-04-12 00:43:04'),(164,23,'Quá hạn thanh toán','2025-04-12 00:43:04'),(165,22,'Quá hạn thanh toán','2025-04-12 00:45:03'),(166,23,'Quá hạn thanh toán','2025-04-12 00:45:03'),(167,22,'Quá hạn thanh toán','2025-04-12 00:49:04'),(168,23,'Quá hạn thanh toán','2025-04-12 00:49:04'),(169,22,'Quá hạn thanh toán','2025-04-12 00:50:03'),(170,23,'Quá hạn thanh toán','2025-04-12 00:50:03'),(171,22,'Quá hạn thanh toán','2025-04-12 00:51:04'),(172,23,'Quá hạn thanh toán','2025-04-12 00:51:04'),(173,22,'Quá hạn thanh toán','2025-04-12 00:52:03'),(174,23,'Quá hạn thanh toán','2025-04-12 00:52:03'),(175,22,'Quá hạn thanh toán','2025-04-12 00:53:04'),(176,23,'Quá hạn thanh toán','2025-04-12 00:53:04'),(177,22,'Quá hạn thanh toán','2025-04-12 00:54:05'),(178,23,'Quá hạn thanh toán','2025-04-12 00:54:05'),(179,22,'Quá hạn thanh toán','2025-04-12 00:55:03'),(180,23,'Quá hạn thanh toán','2025-04-12 00:55:03'),(181,22,'Quá hạn thanh toán','2025-04-12 00:56:04'),(182,23,'Quá hạn thanh toán','2025-04-12 00:56:04'),(183,22,'Quá hạn thanh toán','2025-04-12 00:57:05'),(184,23,'Quá hạn thanh toán','2025-04-12 00:57:05'),(185,22,'Quá hạn thanh toán','2025-04-12 00:58:03'),(186,23,'Quá hạn thanh toán','2025-04-12 00:58:03'),(187,22,'Quá hạn thanh toán','2025-04-12 00:59:04'),(188,23,'Quá hạn thanh toán','2025-04-12 00:59:04'),(189,22,'Quá hạn thanh toán','2025-04-12 01:00:04'),(190,23,'Quá hạn thanh toán','2025-04-12 01:00:04'),(191,22,'Quá hạn thanh toán','2025-04-12 01:01:05'),(192,23,'Quá hạn thanh toán','2025-04-12 01:01:05'),(193,22,'Quá hạn thanh toán','2025-04-12 01:02:03'),(194,23,'Quá hạn thanh toán','2025-04-12 01:02:03'),(195,22,'Quá hạn thanh toán','2025-04-12 01:03:05'),(196,23,'Quá hạn thanh toán','2025-04-12 01:03:05'),(197,22,'Quá hạn thanh toán','2025-04-12 01:04:03'),(198,23,'Quá hạn thanh toán','2025-04-12 01:04:03'),(199,22,'Quá hạn thanh toán','2025-04-12 01:05:03'),(200,23,'Quá hạn thanh toán','2025-04-12 01:05:03'),(201,22,'Quá hạn thanh toán','2025-04-12 01:06:05'),(202,23,'Quá hạn thanh toán','2025-04-12 01:06:05'),(203,22,'Quá hạn thanh toán','2025-04-12 01:07:03'),(204,23,'Quá hạn thanh toán','2025-04-12 01:07:03'),(205,22,'Quá hạn thanh toán','2025-04-12 01:08:03'),(206,23,'Quá hạn thanh toán','2025-04-12 01:08:03'),(207,22,'Quá hạn thanh toán','2025-04-12 01:09:03'),(208,23,'Quá hạn thanh toán','2025-04-12 01:09:03'),(209,22,'Quá hạn thanh toán','2025-04-12 01:10:03'),(210,23,'Quá hạn thanh toán','2025-04-12 01:10:03'),(211,22,'Quá hạn thanh toán','2025-04-12 01:11:03'),(212,23,'Quá hạn thanh toán','2025-04-12 01:11:03'),(213,22,'Quá hạn thanh toán','2025-04-12 01:12:03'),(214,23,'Quá hạn thanh toán','2025-04-12 01:12:03'),(215,22,'Quá hạn thanh toán','2025-04-12 01:14:03'),(216,23,'Quá hạn thanh toán','2025-04-12 01:14:03'),(217,22,'Quá hạn thanh toán','2025-04-12 01:15:04'),(218,23,'Quá hạn thanh toán','2025-04-12 01:15:04'),(219,22,'Quá hạn thanh toán','2025-04-12 01:16:04'),(220,23,'Quá hạn thanh toán','2025-04-12 01:16:04'),(221,22,'Quá hạn thanh toán','2025-04-12 01:17:11'),(222,23,'Quá hạn thanh toán','2025-04-12 01:17:11'),(223,22,'Quá hạn thanh toán','2025-04-12 01:18:07'),(224,23,'Quá hạn thanh toán','2025-04-12 01:18:07'),(225,22,'Quá hạn thanh toán','2025-04-12 01:19:04'),(226,23,'Quá hạn thanh toán','2025-04-12 01:19:04'),(227,22,'Quá hạn thanh toán','2025-04-12 01:20:04'),(228,23,'Quá hạn thanh toán','2025-04-12 01:20:04'),(229,22,'Quá hạn thanh toán','2025-04-12 01:21:04'),(230,23,'Quá hạn thanh toán','2025-04-12 01:21:04'),(231,22,'Quá hạn thanh toán','2025-04-12 01:22:03'),(232,23,'Quá hạn thanh toán','2025-04-12 01:22:03'),(233,22,'Quá hạn thanh toán','2025-04-12 01:23:03'),(234,23,'Quá hạn thanh toán','2025-04-12 01:23:03'),(235,22,'Quá hạn thanh toán','2025-04-12 01:24:03'),(236,23,'Quá hạn thanh toán','2025-04-12 01:24:03'),(237,22,'Quá hạn thanh toán','2025-04-12 01:26:05'),(238,23,'Quá hạn thanh toán','2025-04-12 01:26:05'),(239,22,'Quá hạn thanh toán','2025-04-12 01:27:04'),(240,23,'Quá hạn thanh toán','2025-04-12 01:27:04'),(241,22,'Quá hạn thanh toán','2025-04-12 01:28:03'),(242,23,'Quá hạn thanh toán','2025-04-12 01:28:03'),(243,22,'Quá hạn thanh toán','2025-04-12 01:29:04'),(244,23,'Quá hạn thanh toán','2025-04-12 01:29:04'),(245,22,'Quá hạn thanh toán','2025-04-12 01:30:02'),(246,23,'Quá hạn thanh toán','2025-04-12 01:30:02'),(247,22,'Quá hạn thanh toán','2025-04-12 01:31:04'),(248,23,'Quá hạn thanh toán','2025-04-12 01:31:04'),(249,22,'Quá hạn thanh toán','2025-04-12 01:32:03'),(250,23,'Quá hạn thanh toán','2025-04-12 01:32:03'),(251,22,'Quá hạn thanh toán','2025-04-12 01:33:03'),(252,23,'Quá hạn thanh toán','2025-04-12 01:33:03'),(253,22,'Quá hạn thanh toán','2025-04-12 01:34:03'),(254,23,'Quá hạn thanh toán','2025-04-12 01:34:03'),(255,22,'Quá hạn thanh toán','2025-04-12 01:35:02'),(256,23,'Quá hạn thanh toán','2025-04-12 01:35:02'),(257,22,'Quá hạn thanh toán','2025-04-12 01:36:04'),(258,23,'Quá hạn thanh toán','2025-04-12 01:36:04'),(259,22,'Quá hạn thanh toán','2025-04-12 01:37:04'),(260,23,'Quá hạn thanh toán','2025-04-12 01:37:04'),(261,22,'Quá hạn thanh toán','2025-04-12 01:38:03'),(262,23,'Quá hạn thanh toán','2025-04-12 01:38:03'),(263,22,'Quá hạn thanh toán','2025-04-12 01:39:03'),(264,23,'Quá hạn thanh toán','2025-04-12 01:39:03'),(265,22,'Quá hạn thanh toán','2025-04-12 01:40:03'),(266,23,'Quá hạn thanh toán','2025-04-12 01:40:03'),(267,22,'Quá hạn thanh toán','2025-04-12 01:41:02'),(268,23,'Quá hạn thanh toán','2025-04-12 01:41:03'),(269,22,'Quá hạn thanh toán','2025-04-12 01:42:05'),(270,23,'Quá hạn thanh toán','2025-04-12 01:42:05'),(271,22,'Quá hạn thanh toán','2025-04-12 01:43:02'),(272,23,'Quá hạn thanh toán','2025-04-12 01:43:02'),(273,22,'Quá hạn thanh toán','2025-04-12 01:44:04'),(274,23,'Quá hạn thanh toán','2025-04-12 01:44:04'),(275,22,'Quá hạn thanh toán','2025-04-12 01:45:03'),(276,23,'Quá hạn thanh toán','2025-04-12 01:45:03'),(277,22,'Quá hạn thanh toán','2025-04-12 01:46:03'),(278,23,'Quá hạn thanh toán','2025-04-12 01:46:03'),(279,22,'Quá hạn thanh toán','2025-04-12 01:47:04'),(280,23,'Quá hạn thanh toán','2025-04-12 01:47:04'),(281,22,'Quá hạn thanh toán','2025-04-12 01:48:04'),(282,23,'Quá hạn thanh toán','2025-04-12 01:48:04'),(283,22,'Quá hạn thanh toán','2025-04-12 01:49:02'),(284,23,'Quá hạn thanh toán','2025-04-12 01:49:02'),(285,22,'Quá hạn thanh toán','2025-04-12 01:50:03'),(286,23,'Quá hạn thanh toán','2025-04-12 01:50:03'),(287,22,'Quá hạn thanh toán','2025-04-12 01:51:03'),(288,23,'Quá hạn thanh toán','2025-04-12 01:51:03'),(289,22,'Quá hạn thanh toán','2025-04-12 01:52:02'),(290,23,'Quá hạn thanh toán','2025-04-12 01:52:02'),(291,22,'Quá hạn thanh toán','2025-04-12 01:53:04'),(292,23,'Quá hạn thanh toán','2025-04-12 01:53:04'),(293,22,'Quá hạn thanh toán','2025-04-12 01:54:03'),(294,23,'Quá hạn thanh toán','2025-04-12 01:54:03'),(295,22,'Quá hạn thanh toán','2025-04-12 01:55:02'),(296,23,'Quá hạn thanh toán','2025-04-12 01:55:02'),(297,22,'Quá hạn thanh toán','2025-04-12 01:56:02'),(298,23,'Quá hạn thanh toán','2025-04-12 01:56:02'),(299,22,'Quá hạn thanh toán','2025-04-12 01:57:03'),(300,23,'Quá hạn thanh toán','2025-04-12 01:57:03'),(301,22,'Quá hạn thanh toán','2025-04-12 01:58:03'),(302,23,'Quá hạn thanh toán','2025-04-12 01:58:03'),(303,22,'Quá hạn thanh toán','2025-04-12 01:59:04'),(304,23,'Quá hạn thanh toán','2025-04-12 01:59:04'),(305,22,'Quá hạn thanh toán','2025-04-12 02:00:05'),(306,23,'Quá hạn thanh toán','2025-04-12 02:00:05'),(307,22,'Quá hạn thanh toán','2025-04-12 02:01:03'),(308,23,'Quá hạn thanh toán','2025-04-12 02:01:03'),(309,22,'Quá hạn thanh toán','2025-04-12 02:02:04'),(310,23,'Quá hạn thanh toán','2025-04-12 02:02:04'),(311,22,'Quá hạn thanh toán','2025-04-12 02:03:04'),(312,23,'Quá hạn thanh toán','2025-04-12 02:03:04'),(313,22,'Quá hạn thanh toán','2025-04-12 02:04:03'),(314,23,'Quá hạn thanh toán','2025-04-12 02:04:03'),(315,22,'Quá hạn thanh toán','2025-04-12 02:05:04'),(316,23,'Quá hạn thanh toán','2025-04-12 02:05:04'),(317,22,'Quá hạn thanh toán','2025-04-12 02:06:04'),(318,23,'Quá hạn thanh toán','2025-04-12 02:06:04'),(319,22,'Quá hạn thanh toán','2025-04-12 02:07:02'),(320,23,'Quá hạn thanh toán','2025-04-12 02:07:02'),(321,22,'Quá hạn thanh toán','2025-04-12 02:08:04'),(322,23,'Quá hạn thanh toán','2025-04-12 02:08:04'),(323,22,'Quá hạn thanh toán','2025-04-12 02:09:02'),(324,23,'Quá hạn thanh toán','2025-04-12 02:09:02'),(325,22,'Quá hạn thanh toán','2025-04-12 02:10:03'),(326,23,'Quá hạn thanh toán','2025-04-12 02:10:03'),(327,22,'Quá hạn thanh toán','2025-04-12 02:11:03'),(328,23,'Quá hạn thanh toán','2025-04-12 02:11:03'),(329,22,'Quá hạn thanh toán','2025-04-12 02:12:03'),(330,23,'Quá hạn thanh toán','2025-04-12 02:12:03'),(331,22,'Quá hạn thanh toán','2025-04-12 02:13:04'),(332,23,'Quá hạn thanh toán','2025-04-12 02:13:04'),(333,22,'Quá hạn thanh toán','2025-04-12 02:14:02'),(334,23,'Quá hạn thanh toán','2025-04-12 02:14:02'),(335,22,'Quá hạn thanh toán','2025-04-12 02:18:04'),(336,23,'Quá hạn thanh toán','2025-04-12 02:18:04'),(337,22,'Quá hạn thanh toán','2025-04-12 02:19:03'),(338,23,'Quá hạn thanh toán','2025-04-12 02:19:03'),(339,22,'Quá hạn thanh toán','2025-04-12 02:20:03'),(340,23,'Quá hạn thanh toán','2025-04-12 02:20:03'),(341,22,'Quá hạn thanh toán','2025-04-12 02:21:03'),(342,23,'Quá hạn thanh toán','2025-04-12 02:21:03'),(343,22,'Quá hạn thanh toán','2025-04-12 02:22:04'),(344,23,'Quá hạn thanh toán','2025-04-12 02:22:04'),(345,22,'Quá hạn thanh toán','2025-04-12 02:23:03'),(346,23,'Quá hạn thanh toán','2025-04-12 02:23:03'),(347,22,'Quá hạn thanh toán','2025-04-12 02:24:04'),(348,23,'Quá hạn thanh toán','2025-04-12 02:24:04'),(349,22,'Quá hạn thanh toán','2025-04-12 02:25:03'),(350,23,'Quá hạn thanh toán','2025-04-12 02:25:03'),(351,22,'Quá hạn thanh toán','2025-04-12 02:26:03'),(352,23,'Quá hạn thanh toán','2025-04-12 02:26:03'),(353,22,'Quá hạn thanh toán','2025-04-12 02:27:04'),(354,23,'Quá hạn thanh toán','2025-04-12 02:27:04'),(355,22,'Quá hạn thanh toán','2025-04-12 02:28:03'),(356,23,'Quá hạn thanh toán','2025-04-12 02:28:03'),(357,22,'Quá hạn thanh toán','2025-04-12 02:29:03'),(358,23,'Quá hạn thanh toán','2025-04-12 02:29:03'),(359,22,'Quá hạn thanh toán','2025-04-12 02:30:04'),(360,23,'Quá hạn thanh toán','2025-04-12 02:30:04'),(361,22,'Quá hạn thanh toán','2025-04-12 02:31:03'),(362,23,'Quá hạn thanh toán','2025-04-12 02:31:03'),(363,22,'Quá hạn thanh toán','2025-04-12 02:32:03'),(364,23,'Quá hạn thanh toán','2025-04-12 02:32:03'),(365,22,'Quá hạn thanh toán','2025-04-12 02:33:03'),(366,23,'Quá hạn thanh toán','2025-04-12 02:33:03'),(367,22,'Quá hạn thanh toán','2025-04-12 02:34:03'),(368,23,'Quá hạn thanh toán','2025-04-12 02:34:03'),(369,22,'Quá hạn thanh toán','2025-04-12 02:35:03'),(370,23,'Quá hạn thanh toán','2025-04-12 02:35:03'),(371,22,'Quá hạn thanh toán','2025-04-12 02:36:03'),(372,23,'Quá hạn thanh toán','2025-04-12 02:36:03'),(373,22,'Quá hạn thanh toán','2025-04-12 02:37:03'),(374,23,'Quá hạn thanh toán','2025-04-12 02:37:03'),(375,22,'Quá hạn thanh toán','2025-04-12 02:38:03'),(376,23,'Quá hạn thanh toán','2025-04-12 02:38:03'),(377,22,'Quá hạn thanh toán','2025-04-12 02:39:02'),(378,23,'Quá hạn thanh toán','2025-04-12 02:39:02'),(379,22,'Quá hạn thanh toán','2025-04-12 02:40:03'),(380,23,'Quá hạn thanh toán','2025-04-12 02:40:03'),(381,22,'Quá hạn thanh toán','2025-04-12 02:41:04'),(382,23,'Quá hạn thanh toán','2025-04-12 02:41:04'),(383,22,'Quá hạn thanh toán','2025-04-12 02:42:03'),(384,23,'Quá hạn thanh toán','2025-04-12 02:42:03'),(385,22,'Quá hạn thanh toán','2025-04-12 02:43:02'),(386,23,'Quá hạn thanh toán','2025-04-12 02:43:02'),(387,22,'Quá hạn thanh toán','2025-04-12 02:44:04'),(388,23,'Quá hạn thanh toán','2025-04-12 02:44:04'),(389,22,'Quá hạn thanh toán','2025-04-12 02:45:02'),(390,23,'Quá hạn thanh toán','2025-04-12 02:45:02'),(391,22,'Quá hạn thanh toán','2025-04-12 02:46:05'),(392,23,'Quá hạn thanh toán','2025-04-12 02:46:05'),(393,22,'Quá hạn thanh toán','2025-04-12 02:47:03'),(394,23,'Quá hạn thanh toán','2025-04-12 02:47:03'),(395,22,'Quá hạn thanh toán','2025-04-12 02:48:03'),(396,23,'Quá hạn thanh toán','2025-04-12 02:48:03'),(397,22,'Quá hạn thanh toán','2025-04-12 02:49:04'),(398,23,'Quá hạn thanh toán','2025-04-12 02:49:04'),(399,22,'Quá hạn thanh toán','2025-04-12 02:50:02'),(400,23,'Quá hạn thanh toán','2025-04-12 02:50:02'),(401,22,'Quá hạn thanh toán','2025-04-12 02:51:05'),(402,23,'Quá hạn thanh toán','2025-04-12 02:51:05'),(403,22,'Quá hạn thanh toán','2025-04-12 02:52:03'),(404,23,'Quá hạn thanh toán','2025-04-12 02:52:03'),(405,22,'Quá hạn thanh toán','2025-04-12 02:53:03'),(406,23,'Quá hạn thanh toán','2025-04-12 02:53:03'),(407,22,'Quá hạn thanh toán','2025-04-12 02:54:03'),(408,23,'Quá hạn thanh toán','2025-04-12 02:54:03'),(409,22,'Quá hạn thanh toán','2025-04-12 02:55:02'),(410,23,'Quá hạn thanh toán','2025-04-12 02:55:02'),(411,22,'Quá hạn thanh toán','2025-04-12 02:56:03'),(412,23,'Quá hạn thanh toán','2025-04-12 02:56:03'),(413,22,'Quá hạn thanh toán','2025-04-12 02:57:03'),(414,23,'Quá hạn thanh toán','2025-04-12 02:57:03'),(415,22,'Quá hạn thanh toán','2025-04-12 02:58:03'),(416,23,'Quá hạn thanh toán','2025-04-12 02:58:03'),(417,22,'Quá hạn thanh toán','2025-04-12 07:26:03'),(418,23,'Quá hạn thanh toán','2025-04-12 07:26:03'),(419,22,'Quá hạn thanh toán','2025-04-12 07:27:03'),(420,23,'Quá hạn thanh toán','2025-04-12 07:27:03'),(421,22,'Quá hạn thanh toán','2025-04-12 07:28:02'),(422,23,'Quá hạn thanh toán','2025-04-12 07:28:02'),(423,22,'Quá hạn thanh toán','2025-04-12 07:29:03'),(424,23,'Quá hạn thanh toán','2025-04-12 07:29:03'),(425,22,'Quá hạn thanh toán','2025-04-12 07:30:02'),(426,23,'Quá hạn thanh toán','2025-04-12 07:30:02'),(427,22,'Quá hạn thanh toán','2025-04-12 07:31:03'),(428,23,'Quá hạn thanh toán','2025-04-12 07:31:03'),(429,22,'Quá hạn thanh toán','2025-04-12 07:32:02'),(430,23,'Quá hạn thanh toán','2025-04-12 07:32:02'),(431,22,'Quá hạn thanh toán','2025-04-12 07:33:02'),(432,23,'Quá hạn thanh toán','2025-04-12 07:33:02'),(433,22,'Quá hạn thanh toán','2025-04-12 07:34:04'),(434,23,'Quá hạn thanh toán','2025-04-12 07:34:04'),(435,22,'Quá hạn thanh toán','2025-04-12 07:35:02'),(436,23,'Quá hạn thanh toán','2025-04-12 07:35:02'),(437,22,'Quá hạn thanh toán','2025-04-12 07:36:03'),(438,23,'Quá hạn thanh toán','2025-04-12 07:36:03'),(439,22,'Quá hạn thanh toán','2025-04-12 07:37:02'),(440,23,'Quá hạn thanh toán','2025-04-12 07:37:02'),(441,22,'Quá hạn thanh toán','2025-04-12 07:38:03'),(442,23,'Quá hạn thanh toán','2025-04-12 07:38:03'),(443,22,'Quá hạn thanh toán','2025-04-12 07:39:02'),(444,23,'Quá hạn thanh toán','2025-04-12 07:39:02'),(445,22,'Quá hạn thanh toán','2025-04-12 07:40:03'),(446,23,'Quá hạn thanh toán','2025-04-12 07:40:03'),(447,22,'Quá hạn thanh toán','2025-04-12 07:41:03'),(448,23,'Quá hạn thanh toán','2025-04-12 07:41:03'),(449,22,'Quá hạn thanh toán','2025-04-12 07:42:03'),(450,23,'Quá hạn thanh toán','2025-04-12 07:42:03'),(451,22,'Quá hạn thanh toán','2025-04-12 07:43:04'),(452,23,'Quá hạn thanh toán','2025-04-12 07:43:04'),(453,22,'Quá hạn thanh toán','2025-04-12 07:44:03'),(454,23,'Quá hạn thanh toán','2025-04-12 07:44:03'),(455,22,'Quá hạn thanh toán','2025-04-12 07:45:02'),(456,23,'Quá hạn thanh toán','2025-04-12 07:45:02'),(457,22,'Quá hạn thanh toán','2025-04-12 07:46:04'),(458,23,'Quá hạn thanh toán','2025-04-12 07:46:04'),(459,22,'Quá hạn thanh toán','2025-04-12 07:47:03'),(460,23,'Quá hạn thanh toán','2025-04-12 07:47:03'),(461,22,'Quá hạn thanh toán','2025-04-12 07:48:02'),(462,23,'Quá hạn thanh toán','2025-04-12 07:48:02'),(463,22,'Quá hạn thanh toán','2025-04-12 07:49:03'),(464,23,'Quá hạn thanh toán','2025-04-12 07:49:03'),(465,22,'Quá hạn thanh toán','2025-04-12 07:50:03'),(466,23,'Quá hạn thanh toán','2025-04-12 07:50:03'),(467,22,'Quá hạn thanh toán','2025-04-12 07:51:03'),(468,23,'Quá hạn thanh toán','2025-04-12 07:51:03'),(469,22,'Quá hạn thanh toán','2025-04-12 07:52:03'),(470,23,'Quá hạn thanh toán','2025-04-12 07:52:03'),(471,22,'Quá hạn thanh toán','2025-04-12 07:53:03'),(472,23,'Quá hạn thanh toán','2025-04-12 07:53:03'),(473,22,'Quá hạn thanh toán','2025-04-12 07:54:03'),(474,23,'Quá hạn thanh toán','2025-04-12 07:54:03'),(475,22,'Quá hạn thanh toán','2025-04-12 07:55:03'),(476,23,'Quá hạn thanh toán','2025-04-12 07:55:03'),(477,22,'Quá hạn thanh toán','2025-04-12 07:56:03'),(478,23,'Quá hạn thanh toán','2025-04-12 07:56:03'),(479,22,'Quá hạn thanh toán','2025-04-12 07:57:03'),(480,23,'Quá hạn thanh toán','2025-04-12 07:57:03'),(481,22,'Quá hạn thanh toán','2025-04-12 07:58:03'),(482,23,'Quá hạn thanh toán','2025-04-12 07:58:03'),(483,22,'Quá hạn thanh toán','2025-04-12 07:59:03'),(484,23,'Quá hạn thanh toán','2025-04-12 07:59:03'),(485,22,'Quá hạn thanh toán','2025-04-12 08:00:03'),(486,23,'Quá hạn thanh toán','2025-04-12 08:00:03'),(487,22,'Quá hạn thanh toán','2025-04-12 08:01:02'),(488,23,'Quá hạn thanh toán','2025-04-12 08:01:02'),(489,22,'Quá hạn thanh toán','2025-04-12 08:02:04'),(490,23,'Quá hạn thanh toán','2025-04-12 08:02:04'),(491,22,'Quá hạn thanh toán','2025-04-12 08:03:03'),(492,23,'Quá hạn thanh toán','2025-04-12 08:03:03'),(493,22,'Quá hạn thanh toán','2025-04-12 08:04:03'),(494,23,'Quá hạn thanh toán','2025-04-12 08:04:03'),(495,22,'Quá hạn thanh toán','2025-04-12 08:05:03'),(496,23,'Quá hạn thanh toán','2025-04-12 08:05:03'),(497,22,'Quá hạn thanh toán','2025-04-12 08:06:02'),(498,23,'Quá hạn thanh toán','2025-04-12 08:06:02'),(499,22,'Quá hạn thanh toán','2025-04-12 08:07:02'),(500,23,'Quá hạn thanh toán','2025-04-12 08:07:02'),(501,22,'Quá hạn thanh toán','2025-04-12 08:08:04'),(502,23,'Quá hạn thanh toán','2025-04-12 08:08:04'),(503,22,'Quá hạn thanh toán','2025-04-12 08:09:03'),(504,23,'Quá hạn thanh toán','2025-04-12 08:09:03'),(505,22,'Quá hạn thanh toán','2025-04-12 08:10:04'),(506,23,'Quá hạn thanh toán','2025-04-12 08:10:04'),(507,22,'Quá hạn thanh toán','2025-04-12 08:11:02'),(508,23,'Quá hạn thanh toán','2025-04-12 08:11:02'),(509,22,'Quá hạn thanh toán','2025-04-12 08:13:03'),(510,23,'Quá hạn thanh toán','2025-04-12 08:13:03'),(511,22,'Quá hạn thanh toán','2025-04-12 08:14:03'),(512,23,'Quá hạn thanh toán','2025-04-12 08:14:03'),(513,22,'Quá hạn thanh toán','2025-04-12 08:15:02'),(514,23,'Quá hạn thanh toán','2025-04-12 08:15:02'),(515,22,'Quá hạn thanh toán','2025-04-12 08:16:03'),(516,23,'Quá hạn thanh toán','2025-04-12 08:16:03'),(517,22,'Quá hạn thanh toán','2025-04-12 08:17:04'),(518,23,'Quá hạn thanh toán','2025-04-12 08:17:04'),(519,22,'Quá hạn thanh toán','2025-04-12 08:18:03'),(520,23,'Quá hạn thanh toán','2025-04-12 08:18:03'),(521,22,'Quá hạn thanh toán','2025-04-12 08:19:02'),(522,23,'Quá hạn thanh toán','2025-04-12 08:19:02'),(523,22,'Quá hạn thanh toán','2025-04-12 08:20:04'),(524,23,'Quá hạn thanh toán','2025-04-12 08:20:04'),(525,22,'Quá hạn thanh toán','2025-04-12 08:22:02'),(526,23,'Quá hạn thanh toán','2025-04-12 08:22:02'),(527,22,'Quá hạn thanh toán','2025-04-12 08:23:03'),(528,23,'Quá hạn thanh toán','2025-04-12 08:23:03'),(529,22,'Quá hạn thanh toán','2025-04-12 08:24:03'),(530,23,'Quá hạn thanh toán','2025-04-12 08:24:03'),(531,22,'Quá hạn thanh toán','2025-04-12 08:25:03'),(532,23,'Quá hạn thanh toán','2025-04-12 08:25:03'),(533,22,'Quá hạn thanh toán','2025-04-12 08:26:03'),(534,23,'Quá hạn thanh toán','2025-04-12 08:26:03'),(535,22,'Quá hạn thanh toán','2025-04-12 08:27:04'),(536,23,'Quá hạn thanh toán','2025-04-12 08:27:04'),(537,22,'Quá hạn thanh toán','2025-04-12 08:28:02'),(538,23,'Quá hạn thanh toán','2025-04-12 08:28:03'),(539,22,'Quá hạn thanh toán','2025-04-12 08:29:02'),(540,23,'Quá hạn thanh toán','2025-04-12 08:29:02'),(541,22,'Quá hạn thanh toán','2025-04-12 08:30:03'),(542,23,'Quá hạn thanh toán','2025-04-12 08:30:03'),(543,22,'Quá hạn thanh toán','2025-04-12 08:31:02'),(544,23,'Quá hạn thanh toán','2025-04-12 08:31:02'),(545,22,'Quá hạn thanh toán','2025-04-12 08:32:03'),(546,23,'Quá hạn thanh toán','2025-04-12 08:32:03'),(547,22,'Quá hạn thanh toán','2025-04-12 08:33:02'),(548,23,'Quá hạn thanh toán','2025-04-12 08:33:02'),(549,22,'Quá hạn thanh toán','2025-04-12 08:34:03'),(550,23,'Quá hạn thanh toán','2025-04-12 08:34:03'),(551,22,'Quá hạn thanh toán','2025-04-12 08:35:03'),(552,23,'Quá hạn thanh toán','2025-04-12 08:35:03'),(553,22,'Quá hạn thanh toán','2025-04-12 08:36:02'),(554,23,'Quá hạn thanh toán','2025-04-12 08:36:02'),(555,22,'Quá hạn thanh toán','2025-04-12 08:37:04'),(556,23,'Quá hạn thanh toán','2025-04-12 08:37:04'),(557,22,'Quá hạn thanh toán','2025-04-12 08:38:02'),(558,23,'Quá hạn thanh toán','2025-04-12 08:38:02'),(559,22,'Quá hạn thanh toán','2025-04-12 08:39:03'),(560,23,'Quá hạn thanh toán','2025-04-12 08:39:03'),(561,22,'Quá hạn thanh toán','2025-04-12 08:40:02'),(562,23,'Quá hạn thanh toán','2025-04-12 08:40:02'),(563,22,'Quá hạn thanh toán','2025-04-12 08:41:03'),(564,23,'Quá hạn thanh toán','2025-04-12 08:41:03'),(565,22,'Quá hạn thanh toán','2025-04-12 08:42:03'),(566,23,'Quá hạn thanh toán','2025-04-12 08:42:03'),(567,22,'Quá hạn thanh toán','2025-04-12 08:43:04'),(568,23,'Quá hạn thanh toán','2025-04-12 08:43:04'),(569,22,'Quá hạn thanh toán','2025-04-12 08:44:04'),(570,23,'Quá hạn thanh toán','2025-04-12 08:44:04'),(571,22,'Quá hạn thanh toán','2025-04-12 08:45:22'),(572,23,'Quá hạn thanh toán','2025-04-12 08:45:22'),(573,22,'Quá hạn thanh toán','2025-04-12 08:46:03'),(574,23,'Quá hạn thanh toán','2025-04-12 08:46:03'),(575,22,'Quá hạn thanh toán','2025-04-12 08:47:03'),(576,23,'Quá hạn thanh toán','2025-04-12 08:47:03'),(577,22,'Quá hạn thanh toán','2025-04-12 08:48:03'),(578,23,'Quá hạn thanh toán','2025-04-12 08:48:03'),(579,22,'Quá hạn thanh toán','2025-04-12 08:49:03'),(580,23,'Quá hạn thanh toán','2025-04-12 08:49:03'),(581,22,'Quá hạn thanh toán','2025-04-12 08:50:02'),(582,23,'Quá hạn thanh toán','2025-04-12 08:50:02'),(583,22,'Quá hạn thanh toán','2025-04-12 08:51:02'),(584,23,'Quá hạn thanh toán','2025-04-12 08:51:02'),(585,22,'Quá hạn thanh toán','2025-04-12 08:52:03'),(586,23,'Quá hạn thanh toán','2025-04-12 08:52:03'),(587,22,'Quá hạn thanh toán','2025-04-12 08:54:02'),(588,23,'Quá hạn thanh toán','2025-04-12 08:54:02'),(589,22,'Quá hạn thanh toán','2025-04-12 08:55:03'),(590,23,'Quá hạn thanh toán','2025-04-12 08:55:03'),(591,22,'Quá hạn thanh toán','2025-04-12 08:56:03'),(592,23,'Quá hạn thanh toán','2025-04-12 08:56:03'),(593,22,'Quá hạn thanh toán','2025-04-12 08:57:03'),(594,23,'Quá hạn thanh toán','2025-04-12 08:57:03'),(595,22,'Quá hạn thanh toán','2025-04-12 08:58:02'),(596,23,'Quá hạn thanh toán','2025-04-12 08:58:02'),(597,22,'Quá hạn thanh toán','2025-04-12 08:59:03'),(598,23,'Quá hạn thanh toán','2025-04-12 08:59:03'),(599,22,'Quá hạn thanh toán','2025-04-12 09:00:02'),(600,23,'Quá hạn thanh toán','2025-04-12 09:00:02'),(601,22,'Quá hạn thanh toán','2025-04-12 09:01:02'),(602,23,'Quá hạn thanh toán','2025-04-12 09:01:02'),(603,22,'Quá hạn thanh toán','2025-04-12 09:02:03'),(604,23,'Quá hạn thanh toán','2025-04-12 09:02:03'),(605,22,'Quá hạn thanh toán','2025-04-12 09:03:03'),(606,23,'Quá hạn thanh toán','2025-04-12 09:03:03'),(607,22,'Quá hạn thanh toán','2025-04-12 09:04:04'),(608,23,'Quá hạn thanh toán','2025-04-12 09:04:04'),(609,22,'Quá hạn thanh toán','2025-04-12 09:05:03'),(610,23,'Quá hạn thanh toán','2025-04-12 09:05:03'),(611,22,'Quá hạn thanh toán','2025-04-12 09:06:04'),(612,23,'Quá hạn thanh toán','2025-04-12 09:06:04'),(613,22,'Quá hạn thanh toán','2025-04-12 09:07:03'),(614,23,'Quá hạn thanh toán','2025-04-12 09:07:03'),(615,22,'Quá hạn thanh toán','2025-04-12 09:08:03'),(616,23,'Quá hạn thanh toán','2025-04-12 09:08:03'),(617,22,'Quá hạn thanh toán','2025-04-12 09:09:05'),(618,23,'Quá hạn thanh toán','2025-04-12 09:09:05'),(619,22,'Quá hạn thanh toán','2025-04-12 09:10:03'),(620,23,'Quá hạn thanh toán','2025-04-12 09:10:03'),(621,22,'Quá hạn thanh toán','2025-04-12 09:11:02'),(622,23,'Quá hạn thanh toán','2025-04-12 09:11:02'),(623,22,'Quá hạn thanh toán','2025-04-12 09:12:03'),(624,23,'Quá hạn thanh toán','2025-04-12 09:12:03'),(625,22,'Quá hạn thanh toán','2025-04-12 09:13:02'),(626,23,'Quá hạn thanh toán','2025-04-12 09:13:02'),(627,22,'Quá hạn thanh toán','2025-04-12 09:14:02'),(628,23,'Quá hạn thanh toán','2025-04-12 09:14:02'),(629,22,'Quá hạn thanh toán','2025-04-12 09:15:03'),(630,23,'Quá hạn thanh toán','2025-04-12 09:15:03'),(631,22,'Quá hạn thanh toán','2025-04-12 09:16:03'),(632,23,'Quá hạn thanh toán','2025-04-12 09:16:03'),(633,22,'Quá hạn thanh toán','2025-04-12 09:17:02'),(634,23,'Quá hạn thanh toán','2025-04-12 09:17:02'),(635,22,'Quá hạn thanh toán','2025-04-12 09:18:03'),(636,23,'Quá hạn thanh toán','2025-04-12 09:18:03'),(637,22,'Quá hạn thanh toán','2025-04-12 09:20:03'),(638,23,'Quá hạn thanh toán','2025-04-12 09:20:03'),(639,22,'Quá hạn thanh toán','2025-04-12 09:21:02'),(640,23,'Quá hạn thanh toán','2025-04-12 09:21:02'),(641,22,'Quá hạn thanh toán','2025-04-12 09:22:03'),(642,23,'Quá hạn thanh toán','2025-04-12 09:22:03'),(643,22,'Quá hạn thanh toán','2025-04-12 09:23:02'),(644,23,'Quá hạn thanh toán','2025-04-12 09:23:02'),(645,22,'Quá hạn thanh toán','2025-04-12 09:24:02'),(646,23,'Quá hạn thanh toán','2025-04-12 09:24:02'),(647,22,'Quá hạn thanh toán','2025-04-12 09:25:03'),(648,23,'Quá hạn thanh toán','2025-04-12 09:25:03'),(649,22,'Quá hạn thanh toán','2025-04-12 09:26:03'),(650,23,'Quá hạn thanh toán','2025-04-12 09:26:03'),(651,22,'Quá hạn thanh toán','2025-04-12 09:27:02'),(652,23,'Quá hạn thanh toán','2025-04-12 09:27:02'),(653,22,'Quá hạn thanh toán','2025-04-12 09:28:02'),(654,23,'Quá hạn thanh toán','2025-04-12 09:28:02'),(655,22,'Quá hạn thanh toán','2025-04-12 09:29:03'),(656,23,'Quá hạn thanh toán','2025-04-12 09:29:03'),(657,22,'Quá hạn thanh toán','2025-04-12 09:30:02'),(658,23,'Quá hạn thanh toán','2025-04-12 09:30:02'),(659,22,'Quá hạn thanh toán','2025-04-12 09:31:03'),(660,23,'Quá hạn thanh toán','2025-04-12 09:31:03'),(661,22,'Quá hạn thanh toán','2025-04-12 09:32:03'),(662,23,'Quá hạn thanh toán','2025-04-12 09:32:03'),(663,22,'Quá hạn thanh toán','2025-04-12 09:33:03'),(664,23,'Quá hạn thanh toán','2025-04-12 09:33:03'),(665,22,'Quá hạn thanh toán','2025-04-12 09:34:02'),(666,23,'Quá hạn thanh toán','2025-04-12 09:34:02'),(667,22,'Quá hạn thanh toán','2025-04-12 09:35:03'),(668,23,'Quá hạn thanh toán','2025-04-12 09:35:03'),(669,22,'Quá hạn thanh toán','2025-04-12 09:36:02'),(670,23,'Quá hạn thanh toán','2025-04-12 09:36:02'),(671,22,'Quá hạn thanh toán','2025-04-12 09:37:03'),(672,23,'Quá hạn thanh toán','2025-04-12 09:37:03'),(673,22,'Quá hạn thanh toán','2025-04-12 09:38:03'),(674,23,'Quá hạn thanh toán','2025-04-12 09:38:03'),(675,22,'Quá hạn thanh toán','2025-04-12 09:39:02'),(676,23,'Quá hạn thanh toán','2025-04-12 09:39:02'),(677,22,'Quá hạn thanh toán','2025-04-12 09:40:04'),(678,23,'Quá hạn thanh toán','2025-04-12 09:40:04'),(679,22,'Quá hạn thanh toán','2025-04-12 09:41:04'),(680,23,'Quá hạn thanh toán','2025-04-12 09:41:04'),(681,22,'Quá hạn thanh toán','2025-04-12 09:42:03'),(682,23,'Quá hạn thanh toán','2025-04-12 09:42:03'),(683,22,'Quá hạn thanh toán','2025-04-12 09:43:03'),(684,23,'Quá hạn thanh toán','2025-04-12 09:43:03'),(685,22,'Quá hạn thanh toán','2025-04-12 09:44:03'),(686,23,'Quá hạn thanh toán','2025-04-12 09:44:03'),(687,22,'Quá hạn thanh toán','2025-04-12 09:45:02'),(688,23,'Quá hạn thanh toán','2025-04-12 09:45:02'),(689,22,'Quá hạn thanh toán','2025-04-12 09:46:04'),(690,23,'Quá hạn thanh toán','2025-04-12 09:46:04'),(691,22,'Quá hạn thanh toán','2025-04-12 09:47:02'),(692,23,'Quá hạn thanh toán','2025-04-12 09:47:02'),(693,22,'Quá hạn thanh toán','2025-04-12 09:48:03'),(694,23,'Quá hạn thanh toán','2025-04-12 09:48:03'),(695,22,'Quá hạn thanh toán','2025-04-12 09:49:03'),(696,23,'Quá hạn thanh toán','2025-04-12 09:49:03'),(697,22,'Quá hạn thanh toán','2025-04-12 09:50:03'),(698,23,'Quá hạn thanh toán','2025-04-12 09:50:03'),(699,22,'Quá hạn thanh toán','2025-04-12 09:51:02'),(700,23,'Quá hạn thanh toán','2025-04-12 09:51:02'),(701,22,'Quá hạn thanh toán','2025-04-12 09:52:03'),(702,23,'Quá hạn thanh toán','2025-04-12 09:52:03'),(703,22,'Quá hạn thanh toán','2025-04-12 09:53:03'),(704,23,'Quá hạn thanh toán','2025-04-12 09:53:03'),(705,22,'Quá hạn thanh toán','2025-04-12 09:54:02'),(706,23,'Quá hạn thanh toán','2025-04-12 09:54:02'),(707,22,'Quá hạn thanh toán','2025-04-12 09:55:03'),(708,23,'Quá hạn thanh toán','2025-04-12 09:55:03'),(709,22,'Quá hạn thanh toán','2025-04-12 09:56:02'),(710,23,'Quá hạn thanh toán','2025-04-12 09:56:02'),(711,22,'Quá hạn thanh toán','2025-04-12 09:57:03'),(712,23,'Quá hạn thanh toán','2025-04-12 09:57:03'),(713,22,'Quá hạn thanh toán','2025-04-12 09:58:02'),(714,23,'Quá hạn thanh toán','2025-04-12 09:58:02'),(715,22,'Quá hạn thanh toán','2025-04-12 09:59:03'),(716,23,'Quá hạn thanh toán','2025-04-12 09:59:03'),(717,22,'Quá hạn thanh toán','2025-04-12 10:00:03'),(718,23,'Quá hạn thanh toán','2025-04-12 10:00:03'),(719,22,'Quá hạn thanh toán','2025-04-12 10:01:03'),(720,23,'Quá hạn thanh toán','2025-04-12 10:01:03'),(721,22,'Quá hạn thanh toán','2025-04-12 10:02:02'),(722,23,'Quá hạn thanh toán','2025-04-12 10:02:02'),(723,22,'Quá hạn thanh toán','2025-04-12 10:03:04'),(724,23,'Quá hạn thanh toán','2025-04-12 10:03:04'),(725,22,'Quá hạn thanh toán','2025-04-12 10:04:02'),(726,23,'Quá hạn thanh toán','2025-04-12 10:04:02'),(727,22,'Quá hạn thanh toán','2025-04-12 10:05:02'),(728,23,'Quá hạn thanh toán','2025-04-12 10:05:02'),(729,22,'Quá hạn thanh toán','2025-04-12 10:06:02'),(730,23,'Quá hạn thanh toán','2025-04-12 10:06:02'),(731,22,'Quá hạn thanh toán','2025-04-12 10:07:02'),(732,23,'Quá hạn thanh toán','2025-04-12 10:07:02'),(733,22,'Quá hạn thanh toán','2025-04-12 10:08:03'),(734,23,'Quá hạn thanh toán','2025-04-12 10:08:03'),(735,22,'Quá hạn thanh toán','2025-04-12 10:09:03'),(736,23,'Quá hạn thanh toán','2025-04-12 10:09:03'),(737,22,'Quá hạn thanh toán','2025-04-12 10:10:03'),(738,23,'Quá hạn thanh toán','2025-04-12 10:10:03'),(739,22,'Quá hạn thanh toán','2025-04-12 10:11:02'),(740,23,'Quá hạn thanh toán','2025-04-12 10:11:02'),(741,22,'Quá hạn thanh toán','2025-04-12 10:12:03'),(742,23,'Quá hạn thanh toán','2025-04-12 10:12:03'),(743,22,'Quá hạn thanh toán','2025-04-12 10:13:02'),(744,23,'Quá hạn thanh toán','2025-04-12 10:13:02'),(745,22,'Quá hạn thanh toán','2025-04-12 10:14:02'),(746,23,'Quá hạn thanh toán','2025-04-12 10:14:02'),(747,22,'Quá hạn thanh toán','2025-04-12 10:15:02'),(748,23,'Quá hạn thanh toán','2025-04-12 10:15:02'),(749,22,'Quá hạn thanh toán','2025-04-12 10:16:03'),(750,23,'Quá hạn thanh toán','2025-04-12 10:16:03'),(751,22,'Quá hạn thanh toán','2025-04-12 10:17:03'),(752,23,'Quá hạn thanh toán','2025-04-12 10:17:03'),(753,22,'Quá hạn thanh toán','2025-04-12 10:18:03'),(754,23,'Quá hạn thanh toán','2025-04-12 10:18:03'),(755,22,'Quá hạn thanh toán','2025-04-12 10:19:03'),(756,23,'Quá hạn thanh toán','2025-04-12 10:19:03'),(757,22,'Quá hạn thanh toán','2025-04-12 10:20:24'),(758,23,'Quá hạn thanh toán','2025-04-12 10:20:24'),(759,22,'Quá hạn thanh toán','2025-04-12 10:21:03'),(760,23,'Quá hạn thanh toán','2025-04-12 10:21:03'),(761,22,'Quá hạn thanh toán','2025-04-12 10:22:03'),(762,23,'Quá hạn thanh toán','2025-04-12 10:22:03'),(763,22,'Quá hạn thanh toán','2025-04-12 10:23:02'),(764,23,'Quá hạn thanh toán','2025-04-12 10:23:02'),(765,22,'Quá hạn thanh toán','2025-04-12 10:24:03'),(766,23,'Quá hạn thanh toán','2025-04-12 10:24:03'),(767,22,'Quá hạn thanh toán','2025-04-12 10:25:02'),(768,23,'Quá hạn thanh toán','2025-04-12 10:25:02'),(769,22,'Quá hạn thanh toán','2025-04-12 10:26:03'),(770,23,'Quá hạn thanh toán','2025-04-12 10:26:03'),(771,22,'Quá hạn thanh toán','2025-04-12 10:27:02'),(772,23,'Quá hạn thanh toán','2025-04-12 10:27:02'),(773,22,'Quá hạn thanh toán','2025-04-12 10:28:03'),(774,23,'Quá hạn thanh toán','2025-04-12 10:28:03'),(775,22,'Quá hạn thanh toán','2025-04-12 10:29:22'),(776,23,'Quá hạn thanh toán','2025-04-12 10:29:22'),(777,22,'Quá hạn thanh toán','2025-04-12 10:30:03'),(778,23,'Quá hạn thanh toán','2025-04-12 10:30:03'),(779,22,'Quá hạn thanh toán','2025-04-12 10:31:02'),(780,23,'Quá hạn thanh toán','2025-04-12 10:31:02'),(781,22,'Quá hạn thanh toán','2025-04-12 10:32:03'),(782,23,'Quá hạn thanh toán','2025-04-12 10:32:03'),(783,22,'Quá hạn thanh toán','2025-04-12 10:33:03'),(784,23,'Quá hạn thanh toán','2025-04-12 10:33:03'),(785,22,'Quá hạn thanh toán','2025-04-12 10:34:02'),(786,23,'Quá hạn thanh toán','2025-04-12 10:34:02'),(787,22,'Quá hạn thanh toán','2025-04-12 10:35:02'),(788,23,'Quá hạn thanh toán','2025-04-12 10:35:02'),(789,22,'Quá hạn thanh toán','2025-04-12 10:36:03'),(790,23,'Quá hạn thanh toán','2025-04-12 10:36:03'),(791,22,'Quá hạn thanh toán','2025-04-12 10:37:02'),(792,23,'Quá hạn thanh toán','2025-04-12 10:37:02'),(793,22,'Quá hạn thanh toán','2025-04-12 10:38:02'),(794,23,'Quá hạn thanh toán','2025-04-12 10:38:02'),(795,22,'Quá hạn thanh toán','2025-04-12 10:39:02'),(796,23,'Quá hạn thanh toán','2025-04-12 10:39:02'),(797,22,'Quá hạn thanh toán','2025-04-12 10:40:03'),(798,23,'Quá hạn thanh toán','2025-04-12 10:40:03'),(799,22,'Quá hạn thanh toán','2025-04-12 10:41:02'),(800,23,'Quá hạn thanh toán','2025-04-12 10:41:02'),(801,22,'Quá hạn thanh toán','2025-04-12 10:42:03'),(802,23,'Quá hạn thanh toán','2025-04-12 10:42:03'),(803,22,'Quá hạn thanh toán','2025-04-12 17:22:03'),(804,23,'Quá hạn thanh toán','2025-04-12 17:22:03'),(805,22,'Quá hạn thanh toán','2025-04-12 17:23:02'),(806,23,'Quá hạn thanh toán','2025-04-12 17:23:02'),(807,22,'Quá hạn thanh toán','2025-04-12 17:24:03'),(808,23,'Quá hạn thanh toán','2025-04-12 17:24:03'),(809,22,'Quá hạn thanh toán','2025-04-12 17:25:02'),(810,23,'Quá hạn thanh toán','2025-04-12 17:25:02'),(811,22,'Quá hạn thanh toán','2025-04-12 17:26:02'),(812,23,'Quá hạn thanh toán','2025-04-12 17:26:02'),(813,22,'Quá hạn thanh toán','2025-04-12 17:27:02'),(814,23,'Quá hạn thanh toán','2025-04-12 17:27:02'),(815,22,'Quá hạn thanh toán','2025-04-12 17:28:03'),(816,23,'Quá hạn thanh toán','2025-04-12 17:28:03'),(817,22,'Quá hạn thanh toán','2025-04-12 17:29:03'),(818,23,'Quá hạn thanh toán','2025-04-12 17:29:03'),(819,22,'Quá hạn thanh toán','2025-04-12 17:30:03'),(820,23,'Quá hạn thanh toán','2025-04-12 17:30:03'),(821,22,'Quá hạn thanh toán','2025-04-12 17:31:03'),(822,23,'Quá hạn thanh toán','2025-04-12 17:31:03'),(823,22,'Quá hạn thanh toán','2025-04-12 17:32:02'),(824,23,'Quá hạn thanh toán','2025-04-12 17:32:02'),(825,22,'Quá hạn thanh toán','2025-04-12 17:33:02'),(826,23,'Quá hạn thanh toán','2025-04-12 17:33:02'),(827,22,'Quá hạn thanh toán','2025-04-12 17:34:03'),(828,23,'Quá hạn thanh toán','2025-04-12 17:34:03'),(829,22,'Quá hạn thanh toán','2025-04-12 17:35:02'),(830,23,'Quá hạn thanh toán','2025-04-12 17:35:02'),(831,22,'Quá hạn thanh toán','2025-04-12 17:36:03'),(832,23,'Quá hạn thanh toán','2025-04-12 17:36:03'),(833,22,'Quá hạn thanh toán','2025-04-12 17:37:02'),(834,23,'Quá hạn thanh toán','2025-04-12 17:37:02'),(835,22,'Quá hạn thanh toán','2025-04-12 17:38:03'),(836,23,'Quá hạn thanh toán','2025-04-12 17:38:03'),(837,22,'Quá hạn thanh toán','2025-04-12 17:39:03'),(838,23,'Quá hạn thanh toán','2025-04-12 17:39:03'),(839,22,'Quá hạn thanh toán','2025-04-12 17:40:04'),(840,23,'Quá hạn thanh toán','2025-04-12 17:40:04'),(841,22,'Quá hạn thanh toán','2025-04-12 17:41:03'),(842,23,'Quá hạn thanh toán','2025-04-12 17:41:03'),(843,22,'Quá hạn thanh toán','2025-04-12 17:42:02'),(844,23,'Quá hạn thanh toán','2025-04-12 17:42:02'),(845,22,'Quá hạn thanh toán','2025-04-12 17:43:03'),(846,23,'Quá hạn thanh toán','2025-04-12 17:43:03'),(847,22,'Quá hạn thanh toán','2025-04-12 17:44:03'),(848,23,'Quá hạn thanh toán','2025-04-12 17:44:03'),(849,22,'Quá hạn thanh toán','2025-04-12 17:45:03'),(850,23,'Quá hạn thanh toán','2025-04-12 17:45:03'),(851,22,'Quá hạn thanh toán','2025-04-12 17:46:02'),(852,23,'Quá hạn thanh toán','2025-04-12 17:46:02'),(853,22,'Quá hạn thanh toán','2025-04-12 17:47:03'),(854,23,'Quá hạn thanh toán','2025-04-12 17:47:03'),(855,22,'Quá hạn thanh toán','2025-04-12 17:48:02'),(856,23,'Quá hạn thanh toán','2025-04-12 17:48:02'),(857,22,'Quá hạn thanh toán','2025-04-12 17:49:04'),(858,23,'Quá hạn thanh toán','2025-04-12 17:49:04'),(859,22,'Quá hạn thanh toán','2025-04-12 17:51:03'),(860,23,'Quá hạn thanh toán','2025-04-12 17:51:03'),(861,22,'Quá hạn thanh toán','2025-04-12 17:52:04'),(862,23,'Quá hạn thanh toán','2025-04-12 17:52:04'),(863,22,'Quá hạn thanh toán','2025-04-12 17:53:02'),(864,23,'Quá hạn thanh toán','2025-04-12 17:53:02'),(865,22,'Quá hạn thanh toán','2025-04-12 17:54:03'),(866,23,'Quá hạn thanh toán','2025-04-12 17:54:03'),(867,22,'Quá hạn thanh toán','2025-04-12 17:55:03'),(868,23,'Quá hạn thanh toán','2025-04-12 17:55:03'),(869,22,'Quá hạn thanh toán','2025-04-12 17:56:02'),(870,23,'Quá hạn thanh toán','2025-04-12 17:56:02'),(871,22,'Quá hạn thanh toán','2025-04-12 17:57:03'),(872,23,'Quá hạn thanh toán','2025-04-12 17:57:03'),(873,22,'Quá hạn thanh toán','2025-04-13 04:40:03'),(874,23,'Quá hạn thanh toán','2025-04-13 04:40:03'),(875,22,'Quá hạn thanh toán','2025-04-13 04:41:04'),(876,23,'Quá hạn thanh toán','2025-04-13 04:41:04'),(877,22,'Quá hạn thanh toán','2025-04-13 04:42:03'),(878,23,'Quá hạn thanh toán','2025-04-13 04:42:03'),(879,22,'Quá hạn thanh toán','2025-04-13 04:43:03'),(880,23,'Quá hạn thanh toán','2025-04-13 04:43:03'),(881,22,'Quá hạn thanh toán','2025-04-13 04:44:02'),(882,23,'Quá hạn thanh toán','2025-04-13 04:44:02'),(883,22,'Quá hạn thanh toán','2025-04-13 04:45:02'),(884,23,'Quá hạn thanh toán','2025-04-13 04:45:02'),(885,22,'Quá hạn thanh toán','2025-04-13 04:46:02'),(886,23,'Quá hạn thanh toán','2025-04-13 04:46:02'),(887,22,'Quá hạn thanh toán','2025-04-13 04:47:03'),(888,23,'Quá hạn thanh toán','2025-04-13 04:47:03'),(889,22,'Quá hạn thanh toán','2025-04-13 04:48:02'),(890,23,'Quá hạn thanh toán','2025-04-13 04:48:02'),(891,22,'Quá hạn thanh toán','2025-04-13 04:49:03'),(892,23,'Quá hạn thanh toán','2025-04-13 04:49:03'),(893,22,'Quá hạn thanh toán','2025-04-13 04:50:02'),(894,23,'Quá hạn thanh toán','2025-04-13 04:50:02'),(895,22,'Quá hạn thanh toán','2025-04-13 04:51:02'),(896,23,'Quá hạn thanh toán','2025-04-13 04:51:02'),(897,22,'Quá hạn thanh toán','2025-04-13 04:52:02'),(898,23,'Quá hạn thanh toán','2025-04-13 04:52:02'),(899,22,'Quá hạn thanh toán','2025-04-13 04:53:03'),(900,23,'Quá hạn thanh toán','2025-04-13 04:53:03'),(901,22,'Quá hạn thanh toán','2025-04-13 04:54:02'),(902,23,'Quá hạn thanh toán','2025-04-13 04:54:02'),(903,22,'Quá hạn thanh toán','2025-04-13 04:55:03'),(904,23,'Quá hạn thanh toán','2025-04-13 04:55:03'),(905,22,'Quá hạn thanh toán','2025-04-13 04:56:02'),(906,23,'Quá hạn thanh toán','2025-04-13 04:56:02'),(907,22,'Quá hạn thanh toán','2025-04-13 04:57:03'),(908,23,'Quá hạn thanh toán','2025-04-13 04:57:03'),(909,22,'Quá hạn thanh toán','2025-04-13 04:58:02'),(910,23,'Quá hạn thanh toán','2025-04-13 04:58:02'),(911,22,'Quá hạn thanh toán','2025-04-13 04:59:02'),(912,23,'Quá hạn thanh toán','2025-04-13 04:59:02'),(913,22,'Quá hạn thanh toán','2025-04-13 05:00:02'),(914,23,'Quá hạn thanh toán','2025-04-13 05:00:02'),(915,22,'Quá hạn thanh toán','2025-04-13 05:01:05'),(916,23,'Quá hạn thanh toán','2025-04-13 05:01:05'),(917,22,'Quá hạn thanh toán','2025-04-13 05:02:02'),(918,23,'Quá hạn thanh toán','2025-04-13 05:02:02'),(919,22,'Quá hạn thanh toán','2025-04-13 05:03:03'),(920,23,'Quá hạn thanh toán','2025-04-13 05:03:03'),(921,22,'Quá hạn thanh toán','2025-04-13 05:04:03'),(922,23,'Quá hạn thanh toán','2025-04-13 05:04:03'),(923,22,'Quá hạn thanh toán','2025-04-13 05:05:03'),(924,23,'Quá hạn thanh toán','2025-04-13 05:05:03'),(925,22,'Quá hạn thanh toán','2025-04-13 05:06:03'),(926,23,'Quá hạn thanh toán','2025-04-13 05:06:03'),(927,22,'Quá hạn thanh toán','2025-04-13 05:07:03'),(928,23,'Quá hạn thanh toán','2025-04-13 05:07:03'),(929,22,'Quá hạn thanh toán','2025-04-13 05:08:03'),(930,23,'Quá hạn thanh toán','2025-04-13 05:08:03'),(931,22,'Quá hạn thanh toán','2025-04-13 05:09:03'),(932,23,'Quá hạn thanh toán','2025-04-13 05:09:03'),(933,22,'Quá hạn thanh toán','2025-04-13 05:10:03'),(934,23,'Quá hạn thanh toán','2025-04-13 05:10:03'),(935,22,'Quá hạn thanh toán','2025-04-13 05:11:02'),(936,23,'Quá hạn thanh toán','2025-04-13 05:11:02'),(937,22,'Quá hạn thanh toán','2025-04-13 05:12:03'),(938,23,'Quá hạn thanh toán','2025-04-13 05:12:03'),(939,22,'Quá hạn thanh toán','2025-04-13 05:13:03'),(940,23,'Quá hạn thanh toán','2025-04-13 05:13:03'),(941,22,'Quá hạn thanh toán','2025-04-13 05:14:03'),(942,23,'Quá hạn thanh toán','2025-04-13 05:14:03'),(943,22,'Quá hạn thanh toán','2025-04-13 05:15:02'),(944,23,'Quá hạn thanh toán','2025-04-13 05:15:02'),(945,22,'Quá hạn thanh toán','2025-04-13 05:16:03'),(946,23,'Quá hạn thanh toán','2025-04-13 05:16:03'),(947,22,'Quá hạn thanh toán','2025-04-13 05:17:02'),(948,23,'Quá hạn thanh toán','2025-04-13 05:17:02'),(949,22,'Quá hạn thanh toán','2025-04-13 05:18:03'),(950,23,'Quá hạn thanh toán','2025-04-13 05:18:03'),(951,22,'Quá hạn thanh toán','2025-04-13 05:19:02'),(952,23,'Quá hạn thanh toán','2025-04-13 05:19:02'),(953,22,'Quá hạn thanh toán','2025-04-13 05:20:03'),(954,23,'Quá hạn thanh toán','2025-04-13 05:20:03'),(955,22,'Quá hạn thanh toán','2025-04-13 05:21:03'),(956,23,'Quá hạn thanh toán','2025-04-13 05:21:03'),(957,22,'Quá hạn thanh toán','2025-04-13 05:22:02'),(958,23,'Quá hạn thanh toán','2025-04-13 05:22:02'),(959,22,'Quá hạn thanh toán','2025-04-13 05:23:03'),(960,23,'Quá hạn thanh toán','2025-04-13 05:23:03'),(961,22,'Quá hạn thanh toán','2025-04-13 05:24:03'),(962,23,'Quá hạn thanh toán','2025-04-13 05:24:03'),(963,22,'Quá hạn thanh toán','2025-04-13 05:25:03'),(964,23,'Quá hạn thanh toán','2025-04-13 05:25:03'),(965,22,'Quá hạn thanh toán','2025-04-13 05:26:04'),(966,23,'Quá hạn thanh toán','2025-04-13 05:26:04'),(967,22,'Quá hạn thanh toán','2025-04-13 05:27:03'),(968,23,'Quá hạn thanh toán','2025-04-13 05:27:03'),(969,22,'Quá hạn thanh toán','2025-04-13 05:28:02'),(970,23,'Quá hạn thanh toán','2025-04-13 05:28:02'),(971,22,'Quá hạn thanh toán','2025-04-13 05:29:03'),(972,23,'Quá hạn thanh toán','2025-04-13 05:29:03'),(973,22,'Quá hạn thanh toán','2025-04-13 05:30:03'),(974,23,'Quá hạn thanh toán','2025-04-13 05:30:03'),(975,22,'Quá hạn thanh toán','2025-04-13 05:31:03'),(976,23,'Quá hạn thanh toán','2025-04-13 05:31:03'),(977,22,'Quá hạn thanh toán','2025-04-13 05:32:04'),(978,23,'Quá hạn thanh toán','2025-04-13 05:32:04'),(979,22,'Quá hạn thanh toán','2025-04-13 05:33:02'),(980,23,'Quá hạn thanh toán','2025-04-13 05:33:02'),(981,22,'Quá hạn thanh toán','2025-04-13 05:34:02'),(982,23,'Quá hạn thanh toán','2025-04-13 05:34:02'),(983,22,'Quá hạn thanh toán','2025-04-13 05:36:24'),(984,23,'Quá hạn thanh toán','2025-04-13 05:36:24'),(985,22,'Quá hạn thanh toán','2025-04-13 05:37:02'),(986,23,'Quá hạn thanh toán','2025-04-13 05:37:02'),(987,22,'Quá hạn thanh toán','2025-04-13 05:38:03'),(988,23,'Quá hạn thanh toán','2025-04-13 05:38:03'),(989,22,'Quá hạn thanh toán','2025-04-13 05:39:02'),(990,23,'Quá hạn thanh toán','2025-04-13 05:39:02'),(991,22,'Quá hạn thanh toán','2025-04-13 05:40:02'),(992,23,'Quá hạn thanh toán','2025-04-13 05:40:02'),(993,22,'Quá hạn thanh toán','2025-04-13 05:41:02'),(994,23,'Quá hạn thanh toán','2025-04-13 05:41:02'),(995,22,'Quá hạn thanh toán','2025-04-13 05:42:02'),(996,23,'Quá hạn thanh toán','2025-04-13 05:42:02'),(997,22,'Quá hạn thanh toán','2025-04-13 05:43:02'),(998,23,'Quá hạn thanh toán','2025-04-13 05:43:02'),(999,22,'Quá hạn thanh toán','2025-04-13 05:44:04'),(1000,23,'Quá hạn thanh toán','2025-04-13 05:44:04'),(1001,22,'Quá hạn thanh toán','2025-04-13 05:45:02'),(1002,23,'Quá hạn thanh toán','2025-04-13 05:45:02'),(1003,22,'Quá hạn thanh toán','2025-04-13 05:46:03'),(1004,23,'Quá hạn thanh toán','2025-04-13 05:46:03'),(1005,22,'Quá hạn thanh toán','2025-04-13 05:47:02'),(1006,23,'Quá hạn thanh toán','2025-04-13 05:47:02'),(1007,22,'Quá hạn thanh toán','2025-04-13 05:48:03'),(1008,23,'Quá hạn thanh toán','2025-04-13 05:48:03'),(1009,22,'Quá hạn thanh toán','2025-04-13 05:49:02'),(1010,23,'Quá hạn thanh toán','2025-04-13 05:49:02'),(1011,22,'Quá hạn thanh toán','2025-04-13 05:50:03'),(1012,23,'Quá hạn thanh toán','2025-04-13 05:50:03'),(1013,22,'Quá hạn thanh toán','2025-04-13 05:51:02'),(1014,23,'Quá hạn thanh toán','2025-04-13 05:51:02'),(1015,22,'Quá hạn thanh toán','2025-04-13 05:52:02'),(1016,23,'Quá hạn thanh toán','2025-04-13 05:52:02'),(1017,22,'Quá hạn thanh toán','2025-04-13 05:53:02'),(1018,23,'Quá hạn thanh toán','2025-04-13 05:53:02'),(1019,22,'Quá hạn thanh toán','2025-04-13 05:54:02'),(1020,23,'Quá hạn thanh toán','2025-04-13 05:54:02'),(1021,22,'Quá hạn thanh toán','2025-04-13 05:55:03'),(1022,23,'Quá hạn thanh toán','2025-04-13 05:55:03'),(1023,22,'Quá hạn thanh toán','2025-04-13 05:56:04'),(1024,23,'Quá hạn thanh toán','2025-04-13 05:56:04'),(1025,22,'Quá hạn thanh toán','2025-04-13 05:57:03'),(1026,23,'Quá hạn thanh toán','2025-04-13 05:57:03'),(1027,22,'Quá hạn thanh toán','2025-04-13 05:58:03'),(1028,23,'Quá hạn thanh toán','2025-04-13 05:58:03'),(1029,22,'Quá hạn thanh toán','2025-04-13 05:59:02'),(1030,23,'Quá hạn thanh toán','2025-04-13 05:59:02'),(1031,22,'Quá hạn thanh toán','2025-04-13 06:00:03'),(1032,23,'Quá hạn thanh toán','2025-04-13 06:00:03'),(1033,22,'Quá hạn thanh toán','2025-04-13 06:01:02'),(1034,23,'Quá hạn thanh toán','2025-04-13 06:01:02'),(1035,22,'Quá hạn thanh toán','2025-04-13 06:02:03'),(1036,23,'Quá hạn thanh toán','2025-04-13 06:02:03'),(1037,22,'Quá hạn thanh toán','2025-04-13 06:03:03'),(1038,23,'Quá hạn thanh toán','2025-04-13 06:03:03'),(1039,22,'Quá hạn thanh toán','2025-04-13 06:04:03'),(1040,23,'Quá hạn thanh toán','2025-04-13 06:04:03'),(1041,22,'Quá hạn thanh toán','2025-04-13 06:05:02'),(1042,23,'Quá hạn thanh toán','2025-04-13 06:05:02'),(1043,22,'Quá hạn thanh toán','2025-04-13 06:06:02'),(1044,23,'Quá hạn thanh toán','2025-04-13 06:06:02'),(1045,22,'Quá hạn thanh toán','2025-04-13 06:07:21'),(1046,23,'Quá hạn thanh toán','2025-04-13 06:07:21'),(1047,22,'Quá hạn thanh toán','2025-04-13 06:08:02'),(1048,23,'Quá hạn thanh toán','2025-04-13 06:08:02'),(1049,22,'Quá hạn thanh toán','2025-04-13 06:09:03'),(1050,23,'Quá hạn thanh toán','2025-04-13 06:09:03'),(1051,22,'Quá hạn thanh toán','2025-04-13 06:10:02'),(1052,23,'Quá hạn thanh toán','2025-04-13 06:10:02'),(1053,22,'Quá hạn thanh toán','2025-04-13 06:11:02'),(1054,23,'Quá hạn thanh toán','2025-04-13 06:11:02'),(1055,22,'Quá hạn thanh toán','2025-04-13 06:12:04'),(1056,23,'Quá hạn thanh toán','2025-04-13 06:12:04'),(1057,22,'Quá hạn thanh toán','2025-04-13 06:13:02'),(1058,23,'Quá hạn thanh toán','2025-04-13 06:13:02'),(1059,22,'Quá hạn thanh toán','2025-04-13 06:14:03'),(1060,23,'Quá hạn thanh toán','2025-04-13 06:14:03'),(1061,22,'Quá hạn thanh toán','2025-04-13 06:15:19'),(1062,23,'Quá hạn thanh toán','2025-04-13 06:15:19'),(1063,22,'Quá hạn thanh toán','2025-04-13 06:16:02'),(1064,23,'Quá hạn thanh toán','2025-04-13 06:16:02'),(1065,22,'Quá hạn thanh toán','2025-04-13 06:17:03'),(1066,23,'Quá hạn thanh toán','2025-04-13 06:17:03'),(1067,22,'Quá hạn thanh toán','2025-04-13 06:18:02'),(1068,23,'Quá hạn thanh toán','2025-04-13 06:18:02'),(1069,22,'Quá hạn thanh toán','2025-04-13 06:19:02'),(1070,23,'Quá hạn thanh toán','2025-04-13 06:19:02'),(1071,22,'Quá hạn thanh toán','2025-04-13 06:20:03'),(1072,23,'Quá hạn thanh toán','2025-04-13 06:20:03'),(1073,22,'Quá hạn thanh toán','2025-04-13 06:21:03'),(1074,23,'Quá hạn thanh toán','2025-04-13 06:21:03'),(1075,22,'Quá hạn thanh toán','2025-04-13 06:22:02'),(1076,23,'Quá hạn thanh toán','2025-04-13 06:22:02'),(1077,22,'Quá hạn thanh toán','2025-04-13 06:23:02'),(1078,23,'Quá hạn thanh toán','2025-04-13 06:23:02'),(1079,22,'Quá hạn thanh toán','2025-04-13 06:24:02'),(1080,23,'Quá hạn thanh toán','2025-04-13 06:24:02'),(1081,22,'Quá hạn thanh toán','2025-04-13 06:25:03'),(1082,23,'Quá hạn thanh toán','2025-04-13 06:25:03'),(1083,22,'Quá hạn thanh toán','2025-04-13 06:26:02'),(1084,23,'Quá hạn thanh toán','2025-04-13 06:26:02'),(1085,22,'Quá hạn thanh toán','2025-04-13 06:27:03'),(1086,23,'Quá hạn thanh toán','2025-04-13 06:27:03'),(1087,22,'Quá hạn thanh toán','2025-04-13 06:28:02'),(1088,23,'Quá hạn thanh toán','2025-04-13 06:28:02'),(1089,22,'Quá hạn thanh toán','2025-04-13 06:29:03'),(1090,23,'Quá hạn thanh toán','2025-04-13 06:29:03'),(1091,22,'Quá hạn thanh toán','2025-04-13 06:30:03'),(1092,23,'Quá hạn thanh toán','2025-04-13 06:30:03'),(1093,22,'Quá hạn thanh toán','2025-04-13 06:31:22'),(1094,23,'Quá hạn thanh toán','2025-04-13 06:31:22'),(1095,22,'Quá hạn thanh toán','2025-04-13 06:32:03'),(1096,23,'Quá hạn thanh toán','2025-04-13 06:32:03'),(1097,22,'Quá hạn thanh toán','2025-04-13 06:33:02'),(1098,23,'Quá hạn thanh toán','2025-04-13 06:33:02'),(1099,22,'Quá hạn thanh toán','2025-04-13 06:34:03'),(1100,23,'Quá hạn thanh toán','2025-04-13 06:34:03'),(1101,22,'Quá hạn thanh toán','2025-04-13 06:35:02'),(1102,23,'Quá hạn thanh toán','2025-04-13 06:35:02'),(1103,22,'Quá hạn thanh toán','2025-04-13 06:36:02'),(1104,23,'Quá hạn thanh toán','2025-04-13 06:36:02'),(1105,22,'Quá hạn thanh toán','2025-04-13 06:37:02'),(1106,23,'Quá hạn thanh toán','2025-04-13 06:37:02'),(1107,22,'Quá hạn thanh toán','2025-04-13 06:38:04'),(1108,23,'Quá hạn thanh toán','2025-04-13 06:38:04'),(1109,22,'Quá hạn thanh toán','2025-04-13 06:39:03'),(1110,23,'Quá hạn thanh toán','2025-04-13 06:39:03'),(1111,22,'Quá hạn thanh toán','2025-04-13 06:40:02'),(1112,23,'Quá hạn thanh toán','2025-04-13 06:40:02'),(1113,22,'Quá hạn thanh toán','2025-04-13 06:41:03'),(1114,23,'Quá hạn thanh toán','2025-04-13 06:41:03'),(1115,22,'Quá hạn thanh toán','2025-04-13 06:42:03'),(1116,23,'Quá hạn thanh toán','2025-04-13 06:42:03'),(1117,22,'Quá hạn thanh toán','2025-04-13 06:43:03'),(1118,23,'Quá hạn thanh toán','2025-04-13 06:43:03'),(1119,22,'Quá hạn thanh toán','2025-04-13 06:44:02'),(1120,23,'Quá hạn thanh toán','2025-04-13 06:44:02'),(1121,22,'Quá hạn thanh toán','2025-04-13 06:45:03'),(1122,23,'Quá hạn thanh toán','2025-04-13 06:45:03'),(1123,22,'Quá hạn thanh toán','2025-04-13 06:46:02'),(1124,23,'Quá hạn thanh toán','2025-04-13 06:46:02'),(1125,22,'Quá hạn thanh toán','2025-04-13 06:47:03'),(1126,23,'Quá hạn thanh toán','2025-04-13 06:47:03'),(1127,22,'Quá hạn thanh toán','2025-04-13 06:48:02'),(1128,23,'Quá hạn thanh toán','2025-04-13 06:48:02'),(1129,22,'Quá hạn thanh toán','2025-04-13 06:49:03'),(1130,23,'Quá hạn thanh toán','2025-04-13 06:49:03'),(1131,22,'Quá hạn thanh toán','2025-04-13 06:50:02'),(1132,23,'Quá hạn thanh toán','2025-04-13 06:50:02'),(1133,22,'Quá hạn thanh toán','2025-04-13 06:51:03'),(1134,23,'Quá hạn thanh toán','2025-04-13 06:51:03'),(1135,22,'Quá hạn thanh toán','2025-04-13 06:52:03'),(1136,23,'Quá hạn thanh toán','2025-04-13 06:52:03'),(1137,22,'Quá hạn thanh toán','2025-04-13 06:53:03'),(1138,23,'Quá hạn thanh toán','2025-04-13 06:53:03'),(1139,22,'Quá hạn thanh toán','2025-04-13 06:54:03'),(1140,23,'Quá hạn thanh toán','2025-04-13 06:54:03'),(1141,22,'Quá hạn thanh toán','2025-04-13 06:55:03'),(1142,23,'Quá hạn thanh toán','2025-04-13 06:55:03'),(1143,22,'Quá hạn thanh toán','2025-04-13 06:56:02'),(1144,23,'Quá hạn thanh toán','2025-04-13 06:56:02'),(1145,22,'Quá hạn thanh toán','2025-04-13 06:57:03'),(1146,23,'Quá hạn thanh toán','2025-04-13 06:57:03'),(1147,22,'Quá hạn thanh toán','2025-04-13 06:58:02'),(1148,23,'Quá hạn thanh toán','2025-04-13 06:58:02'),(1149,22,'Quá hạn thanh toán','2025-04-13 06:59:02'),(1150,23,'Quá hạn thanh toán','2025-04-13 06:59:02'),(1151,22,'Quá hạn thanh toán','2025-04-13 07:00:03'),(1152,23,'Quá hạn thanh toán','2025-04-13 07:00:03'),(1153,22,'Quá hạn thanh toán','2025-04-13 07:01:03'),(1154,23,'Quá hạn thanh toán','2025-04-13 07:01:03'),(1155,22,'Quá hạn thanh toán','2025-04-13 07:02:03'),(1156,23,'Quá hạn thanh toán','2025-04-13 07:02:03'),(1157,22,'Quá hạn thanh toán','2025-04-13 07:03:03'),(1158,23,'Quá hạn thanh toán','2025-04-13 07:03:03'),(1159,22,'Quá hạn thanh toán','2025-04-13 07:04:03'),(1160,23,'Quá hạn thanh toán','2025-04-13 07:04:03'),(1161,22,'Quá hạn thanh toán','2025-04-13 07:05:03'),(1162,23,'Quá hạn thanh toán','2025-04-13 07:05:03'),(1163,22,'Quá hạn thanh toán','2025-04-13 07:06:03'),(1164,23,'Quá hạn thanh toán','2025-04-13 07:06:03'),(1165,22,'Quá hạn thanh toán','2025-04-13 07:07:02'),(1166,23,'Quá hạn thanh toán','2025-04-13 07:07:02'),(1167,22,'Quá hạn thanh toán','2025-04-13 07:08:03'),(1168,23,'Quá hạn thanh toán','2025-04-13 07:08:03'),(1169,22,'Quá hạn thanh toán','2025-04-13 07:09:02'),(1170,23,'Quá hạn thanh toán','2025-04-13 07:09:02'),(1171,22,'Quá hạn thanh toán','2025-04-13 07:10:02'),(1172,23,'Quá hạn thanh toán','2025-04-13 07:10:02'),(1173,22,'Quá hạn thanh toán','2025-04-13 07:11:03'),(1174,23,'Quá hạn thanh toán','2025-04-13 07:11:03'),(1175,22,'Quá hạn thanh toán','2025-04-13 07:12:02'),(1176,23,'Quá hạn thanh toán','2025-04-13 07:12:02'),(1177,22,'Quá hạn thanh toán','2025-04-13 07:13:03'),(1178,23,'Quá hạn thanh toán','2025-04-13 07:13:03'),(1179,22,'Quá hạn thanh toán','2025-04-13 07:14:03'),(1180,23,'Quá hạn thanh toán','2025-04-13 07:14:03'),(1181,22,'Quá hạn thanh toán','2025-04-13 07:15:02'),(1182,23,'Quá hạn thanh toán','2025-04-13 07:15:02'),(1183,22,'Quá hạn thanh toán','2025-04-13 07:16:03'),(1184,23,'Quá hạn thanh toán','2025-04-13 07:16:03'),(1185,22,'Quá hạn thanh toán','2025-04-13 07:17:03'),(1186,23,'Quá hạn thanh toán','2025-04-13 07:17:03'),(1187,22,'Quá hạn thanh toán','2025-04-13 07:18:02'),(1188,23,'Quá hạn thanh toán','2025-04-13 07:18:02'),(1189,22,'Quá hạn thanh toán','2025-04-13 07:19:03'),(1190,23,'Quá hạn thanh toán','2025-04-13 07:19:03'),(1191,22,'Quá hạn thanh toán','2025-04-13 07:20:02'),(1192,23,'Quá hạn thanh toán','2025-04-13 07:20:02'),(1193,22,'Quá hạn thanh toán','2025-04-13 07:21:03'),(1194,23,'Quá hạn thanh toán','2025-04-13 07:21:03'),(1195,22,'Quá hạn thanh toán','2025-04-13 07:22:02'),(1196,23,'Quá hạn thanh toán','2025-04-13 07:22:02'),(1197,22,'Quá hạn thanh toán','2025-04-13 07:23:03'),(1198,23,'Quá hạn thanh toán','2025-04-13 07:23:03'),(1199,22,'Quá hạn thanh toán','2025-04-13 07:24:03'),(1200,23,'Quá hạn thanh toán','2025-04-13 07:24:03'),(1201,22,'Quá hạn thanh toán','2025-04-13 07:25:03'),(1202,23,'Quá hạn thanh toán','2025-04-13 07:25:03'),(1203,22,'Quá hạn thanh toán','2025-04-13 07:26:03'),(1204,23,'Quá hạn thanh toán','2025-04-13 07:26:03'),(1205,22,'Quá hạn thanh toán','2025-04-13 07:27:02'),(1206,23,'Quá hạn thanh toán','2025-04-13 07:27:02'),(1207,22,'Quá hạn thanh toán','2025-04-13 07:28:03'),(1208,23,'Quá hạn thanh toán','2025-04-13 07:28:03'),(1209,22,'Quá hạn thanh toán','2025-04-13 07:29:02'),(1210,23,'Quá hạn thanh toán','2025-04-13 07:29:02'),(1211,22,'Quá hạn thanh toán','2025-04-13 07:30:04'),(1212,23,'Quá hạn thanh toán','2025-04-13 07:30:04'),(1213,22,'Quá hạn thanh toán','2025-04-13 07:31:06'),(1214,23,'Quá hạn thanh toán','2025-04-13 07:31:06'),(1215,22,'Quá hạn thanh toán','2025-04-13 07:32:03'),(1216,23,'Quá hạn thanh toán','2025-04-13 07:32:03'),(1217,22,'Quá hạn thanh toán','2025-04-13 07:33:03'),(1218,23,'Quá hạn thanh toán','2025-04-13 07:33:03'),(1219,22,'Quá hạn thanh toán','2025-04-13 07:34:03'),(1220,23,'Quá hạn thanh toán','2025-04-13 07:34:03'),(1221,22,'Quá hạn thanh toán','2025-04-13 07:36:03'),(1222,23,'Quá hạn thanh toán','2025-04-13 07:36:03'),(1223,22,'Quá hạn thanh toán','2025-04-13 07:37:02'),(1224,23,'Quá hạn thanh toán','2025-04-13 07:37:02'),(1225,22,'Quá hạn thanh toán','2025-04-13 07:38:03'),(1226,23,'Quá hạn thanh toán','2025-04-13 07:38:03'),(1227,22,'Quá hạn thanh toán','2025-04-13 07:40:02'),(1228,23,'Quá hạn thanh toán','2025-04-13 07:40:02'),(1229,22,'Quá hạn thanh toán','2025-04-13 07:41:02'),(1230,23,'Quá hạn thanh toán','2025-04-13 07:41:02'),(1231,22,'Quá hạn thanh toán','2025-04-13 07:46:02'),(1232,23,'Quá hạn thanh toán','2025-04-13 07:46:02'),(1233,22,'Quá hạn thanh toán','2025-04-13 07:47:03'),(1234,23,'Quá hạn thanh toán','2025-04-13 07:47:03'),(1235,22,'Quá hạn thanh toán','2025-04-13 07:48:03'),(1236,23,'Quá hạn thanh toán','2025-04-13 07:48:03'),(1237,21,'Chuẩn bị hàng','2025-04-13 07:48:18'),(1238,21,'Đang vận chuyển','2025-04-13 07:48:49'),(1239,22,'Quá hạn thanh toán','2025-04-13 07:49:02'),(1240,23,'Quá hạn thanh toán','2025-04-13 07:49:02'),(1241,22,'Quá hạn thanh toán','2025-04-13 07:50:02'),(1242,23,'Quá hạn thanh toán','2025-04-13 07:50:02'),(1243,22,'Quá hạn thanh toán','2025-04-13 07:51:02'),(1244,23,'Quá hạn thanh toán','2025-04-13 07:51:02'),(1245,21,'Hủy','2025-04-13 07:52:30'),(1246,22,'Quá hạn thanh toán','2025-04-13 07:53:03'),(1247,23,'Quá hạn thanh toán','2025-04-13 07:53:03'),(1248,22,'Quá hạn thanh toán','2025-04-13 07:54:03'),(1249,23,'Quá hạn thanh toán','2025-04-13 07:54:03'),(1250,22,'Quá hạn thanh toán','2025-04-13 07:55:03'),(1251,23,'Quá hạn thanh toán','2025-04-13 07:55:03'),(1252,22,'Quá hạn thanh toán','2025-04-13 07:56:02'),(1253,23,'Quá hạn thanh toán','2025-04-13 07:56:02'),(1254,22,'Quá hạn thanh toán','2025-04-13 07:57:02'),(1255,23,'Quá hạn thanh toán','2025-04-13 07:57:02'),(1256,22,'Quá hạn thanh toán','2025-04-13 07:58:02'),(1257,23,'Quá hạn thanh toán','2025-04-13 07:58:02'),(1258,22,'Quá hạn thanh toán','2025-04-13 07:59:02'),(1259,23,'Quá hạn thanh toán','2025-04-13 07:59:02'),(1260,25,'Chờ duyệt','2025-04-13 07:59:10'),(1261,22,'Quá hạn thanh toán','2025-04-13 08:00:02'),(1262,23,'Quá hạn thanh toán','2025-04-13 08:00:02'),(1263,22,'Quá hạn thanh toán','2025-04-13 08:01:03'),(1264,23,'Quá hạn thanh toán','2025-04-13 08:01:03'),(1265,22,'Quá hạn thanh toán','2025-04-13 08:02:02'),(1266,23,'Quá hạn thanh toán','2025-04-13 08:02:02'),(1267,22,'Quá hạn thanh toán','2025-04-13 08:03:03'),(1268,23,'Quá hạn thanh toán','2025-04-13 08:03:03'),(1269,22,'Quá hạn thanh toán','2025-04-13 08:04:03'),(1270,23,'Quá hạn thanh toán','2025-04-13 08:04:03'),(1271,22,'Quá hạn thanh toán','2025-04-13 08:05:02'),(1272,23,'Quá hạn thanh toán','2025-04-13 08:05:02'),(1273,22,'Quá hạn thanh toán','2025-04-13 08:06:02'),(1274,23,'Quá hạn thanh toán','2025-04-13 08:06:02'),(1275,22,'Quá hạn thanh toán','2025-04-13 08:07:02'),(1276,23,'Quá hạn thanh toán','2025-04-13 08:07:02'),(1277,22,'Quá hạn thanh toán','2025-04-13 08:08:03'),(1278,23,'Quá hạn thanh toán','2025-04-13 08:08:03'),(1279,22,'Quá hạn thanh toán','2025-04-13 08:09:03'),(1280,23,'Quá hạn thanh toán','2025-04-13 08:09:03'),(1281,22,'Quá hạn thanh toán','2025-04-13 08:10:02'),(1282,23,'Quá hạn thanh toán','2025-04-13 08:10:02'),(1283,22,'Quá hạn thanh toán','2025-04-13 08:11:02'),(1284,23,'Quá hạn thanh toán','2025-04-13 08:11:02'),(1285,22,'Quá hạn thanh toán','2025-04-13 08:12:03'),(1286,23,'Quá hạn thanh toán','2025-04-13 08:12:03'),(1287,22,'Quá hạn thanh toán','2025-04-13 08:13:02'),(1288,23,'Quá hạn thanh toán','2025-04-13 08:13:02'),(1289,22,'Quá hạn thanh toán','2025-04-13 08:14:02'),(1290,23,'Quá hạn thanh toán','2025-04-13 08:14:02'),(1291,22,'Quá hạn thanh toán','2025-04-13 08:15:02'),(1292,23,'Quá hạn thanh toán','2025-04-13 08:15:02'),(1293,22,'Quá hạn thanh toán','2025-04-13 08:16:02'),(1294,23,'Quá hạn thanh toán','2025-04-13 08:16:02'),(1295,22,'Quá hạn thanh toán','2025-04-13 08:17:02'),(1296,23,'Quá hạn thanh toán','2025-04-13 08:17:02'),(1297,22,'Quá hạn thanh toán','2025-04-13 08:18:03'),(1298,23,'Quá hạn thanh toán','2025-04-13 08:18:03'),(1299,22,'Quá hạn thanh toán','2025-04-13 08:19:04'),(1300,23,'Quá hạn thanh toán','2025-04-13 08:19:04'),(1301,22,'Quá hạn thanh toán','2025-04-13 08:20:03'),(1302,23,'Quá hạn thanh toán','2025-04-13 08:20:03'),(1303,22,'Quá hạn thanh toán','2025-04-13 08:21:03'),(1304,23,'Quá hạn thanh toán','2025-04-13 08:21:03'),(1305,22,'Quá hạn thanh toán','2025-04-13 08:22:03'),(1306,23,'Quá hạn thanh toán','2025-04-13 08:22:03'),(1307,22,'Quá hạn thanh toán','2025-04-13 08:23:03'),(1308,23,'Quá hạn thanh toán','2025-04-13 08:23:03'),(1309,22,'Quá hạn thanh toán','2025-04-13 08:24:02'),(1310,23,'Quá hạn thanh toán','2025-04-13 08:24:02'),(1311,22,'Quá hạn thanh toán','2025-04-13 08:25:02'),(1312,23,'Quá hạn thanh toán','2025-04-13 08:25:02'),(1313,25,'Hủy','2025-04-13 08:25:09'),(1314,22,'Quá hạn thanh toán','2025-04-13 08:26:02'),(1315,23,'Quá hạn thanh toán','2025-04-13 08:26:02'),(1316,22,'Quá hạn thanh toán','2025-04-13 08:27:03'),(1317,23,'Quá hạn thanh toán','2025-04-13 08:27:03'),(1318,26,'Chờ duyệt','2025-04-13 08:27:37'),(1319,22,'Quá hạn thanh toán','2025-04-13 08:28:02'),(1320,23,'Quá hạn thanh toán','2025-04-13 08:28:02'),(1321,27,'Chờ duyệt','2025-04-13 08:28:11'),(1322,22,'Quá hạn thanh toán','2025-04-13 08:29:03'),(1323,23,'Quá hạn thanh toán','2025-04-13 08:29:03'),(1324,22,'Quá hạn thanh toán','2025-04-13 08:30:03'),(1325,23,'Quá hạn thanh toán','2025-04-13 08:30:03'),(1326,22,'Quá hạn thanh toán','2025-04-13 08:31:02'),(1327,23,'Quá hạn thanh toán','2025-04-13 08:31:02'),(1328,28,'Chờ duyệt','2025-04-13 08:31:57'),(1329,22,'Quá hạn thanh toán','2025-04-13 08:32:03'),(1330,23,'Quá hạn thanh toán','2025-04-13 08:32:03'),(1331,29,'Chờ duyệt','2025-04-13 08:32:55'),(1332,30,'Chờ duyệt','2025-04-13 08:33:03'),(1333,22,'Quá hạn thanh toán','2025-04-13 08:33:19'),(1334,23,'Quá hạn thanh toán','2025-04-13 08:33:19'),(1335,30,'Hủy','2025-04-13 08:33:32'),(1336,29,'Hủy','2025-04-13 08:33:55'),(1337,22,'Quá hạn thanh toán','2025-04-13 08:34:03'),(1338,23,'Quá hạn thanh toán','2025-04-13 08:34:03'),(1339,28,'Hủy','2025-04-13 08:34:06'),(1340,27,'Hủy','2025-04-13 08:34:07'),(1341,26,'Hủy','2025-04-13 08:34:10'),(1342,22,'Quá hạn thanh toán','2025-04-13 08:35:02'),(1343,23,'Quá hạn thanh toán','2025-04-13 08:35:02'),(1344,31,'Chờ duyệt','2025-04-13 08:36:28'),(1345,32,'Chờ duyệt','2025-04-13 08:36:54'),(1346,22,'Quá hạn thanh toán','2025-04-13 08:37:03'),(1347,23,'Quá hạn thanh toán','2025-04-13 08:37:03'),(1348,31,'Hủy','2025-04-13 08:37:19'),(1349,32,'Hủy','2025-04-13 08:37:20'),(1350,33,'Chờ duyệt','2025-04-13 08:38:33'),(1351,33,'Hủy','2025-04-13 08:38:52'),(1352,22,'Quá hạn thanh toán','2025-04-13 08:39:04'),(1353,23,'Quá hạn thanh toán','2025-04-13 08:39:04'),(1354,34,'Chờ duyệt','2025-04-13 08:39:11'),(1355,22,'Quá hạn thanh toán','2025-04-13 08:40:04'),(1356,23,'Quá hạn thanh toán','2025-04-13 08:40:04'),(1357,34,'Chuẩn bị hàng','2025-04-13 08:40:16'),(1358,34,'Đang vận chuyển','2025-04-13 08:40:18'),(1359,34,'Đã giao','2025-04-13 08:40:25'),(1360,35,'Chờ duyệt','2025-04-13 08:41:29'),(1361,36,'Chờ duyệt','2025-04-13 08:41:41'),(1362,35,'Hủy','2025-04-13 08:41:59'),(1363,22,'Quá hạn thanh toán','2025-04-13 08:42:02'),(1364,23,'Quá hạn thanh toán','2025-04-13 08:42:02'),(1365,36,'Hủy','2025-04-13 08:42:59'),(1366,22,'Quá hạn thanh toán','2025-04-13 08:43:03'),(1367,23,'Quá hạn thanh toán','2025-04-13 08:43:03'),(1368,37,'Chờ duyệt','2025-04-13 08:43:11'),(1369,37,'Chuẩn bị hàng','2025-04-13 08:43:16'),(1370,37,'Đang vận chuyển','2025-04-13 08:43:17'),(1371,37,'Đã giao','2025-04-13 08:43:22'),(1372,22,'Quá hạn thanh toán','2025-04-13 08:44:03'),(1373,23,'Quá hạn thanh toán','2025-04-13 08:44:03'),(1374,22,'Quá hạn thanh toán','2025-04-13 08:45:03'),(1375,23,'Quá hạn thanh toán','2025-04-13 08:45:03'),(1376,38,'Chờ duyệt','2025-04-13 08:45:14'),(1377,39,'Chờ duyệt','2025-04-13 08:45:43'),(1378,22,'Quá hạn thanh toán','2025-04-13 08:46:02'),(1379,23,'Quá hạn thanh toán','2025-04-13 08:46:02'),(1380,22,'Quá hạn thanh toán','2025-04-13 08:47:04'),(1381,23,'Quá hạn thanh toán','2025-04-13 08:47:04'),(1382,22,'Quá hạn thanh toán','2025-04-13 08:48:02'),(1383,23,'Quá hạn thanh toán','2025-04-13 08:48:02'),(1384,22,'Quá hạn thanh toán','2025-04-13 08:49:03'),(1385,23,'Quá hạn thanh toán','2025-04-13 08:49:03'),(1386,22,'Quá hạn thanh toán','2025-04-13 08:51:04'),(1387,23,'Quá hạn thanh toán','2025-04-13 08:51:04'),(1388,22,'Quá hạn thanh toán','2025-04-13 08:52:03'),(1389,23,'Quá hạn thanh toán','2025-04-13 08:52:03'),(1390,40,'Chờ duyệt','2025-04-13 08:52:07'),(1391,41,'Chờ duyệt','2025-04-13 08:52:44'),(1392,22,'Quá hạn thanh toán','2025-04-13 08:53:03'),(1393,23,'Quá hạn thanh toán','2025-04-13 08:53:03'),(1394,38,'Hủy','2025-04-13 08:53:09'),(1395,41,'Hủy','2025-04-13 08:53:10'),(1396,40,'Hủy','2025-04-13 08:53:12'),(1397,39,'Hủy','2025-04-13 08:53:13'),(1398,42,'Chờ duyệt','2025-04-13 08:53:30'),(1399,43,'Chờ duyệt','2025-04-13 08:53:36'),(1400,44,'Chờ duyệt','2025-04-13 08:53:44'),(1401,45,'Chờ duyệt','2025-04-13 08:53:56'),(1402,22,'Quá hạn thanh toán','2025-04-13 08:54:02'),(1403,23,'Quá hạn thanh toán','2025-04-13 08:54:02'),(1404,22,'Quá hạn thanh toán','2025-04-13 08:55:03'),(1405,23,'Quá hạn thanh toán','2025-04-13 08:55:03'),(1406,22,'Quá hạn thanh toán','2025-04-13 08:56:03'),(1407,23,'Quá hạn thanh toán','2025-04-13 08:56:03'),(1408,22,'Quá hạn thanh toán','2025-04-13 08:57:03'),(1409,23,'Quá hạn thanh toán','2025-04-13 08:57:03'),(1410,22,'Quá hạn thanh toán','2025-04-13 08:58:03'),(1411,23,'Quá hạn thanh toán','2025-04-13 08:58:03'),(1412,22,'Quá hạn thanh toán','2025-04-13 08:59:04'),(1413,23,'Quá hạn thanh toán','2025-04-13 08:59:04'),(1414,45,'Hủy','2025-04-13 09:00:23'),(1415,44,'Hủy','2025-04-13 09:00:24'),(1416,43,'Hủy','2025-04-13 09:00:25'),(1417,42,'Hủy','2025-04-13 09:00:26'),(1418,46,'Chờ duyệt','2025-04-13 09:01:18'),(1419,46,'Hủy','2025-04-13 09:01:31'),(1420,47,'Chờ duyệt','2025-04-13 09:01:44'),(1421,47,'Chuẩn bị hàng','2025-04-13 09:01:59'),(1422,47,'Đang vận chuyển','2025-04-13 09:01:59'),(1423,47,'Đã giao','2025-04-13 09:02:01'),(1424,24,'Đang vận chuyển','2025-04-13 09:02:30'),(1425,24,'Đã giao','2025-04-13 09:02:33'),(1426,20,'Đang vận chuyển','2025-04-13 09:02:34'),(1427,20,'Đã giao','2025-04-13 09:02:35'),(1428,19,'Đang vận chuyển','2025-04-13 09:02:36'),(1429,19,'Đã giao','2025-04-13 09:02:36'),(1430,48,'Chờ duyệt','2025-04-13 09:02:57'),(1431,49,'Chờ duyệt','2025-04-13 09:03:26'),(1432,49,'Chuẩn bị hàng','2025-04-13 09:05:03'),(1433,48,'Quá hạn thanh toán','2025-04-13 14:28:03'),(1434,50,'Chờ duyệt','2025-04-15 14:29:01'),(1435,51,'Chờ duyệt','2025-04-15 14:32:35'),(1436,51,'Chuẩn bị hàng','2025-04-15 14:33:05'),(1437,50,'Quá hạn thanh toán','2025-04-15 14:59:06'),(1438,52,'Chờ duyệt','2025-04-15 17:17:40'),(1439,52,'Chuẩn bị hàng','2025-04-15 17:21:03'),(1440,53,'Chờ duyệt','2025-04-15 17:24:52'),(1441,53,'Hủy','2025-04-15 17:25:06'),(1442,54,'Chờ duyệt','2025-04-16 13:05:02'),(1443,54,'Hủy','2025-04-16 13:05:58'),(1444,55,'Chờ duyệt','2025-05-16 08:11:58');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `OrderDetailID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `Product_Item_ID` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderDetailID`),
  KEY `OrderID` (`OrderID`),
  KEY `fk_product_item_orderdeatails_idx` (`Product_Item_ID`),
  CONSTRAINT `fk_product_item_orderdeatails` FOREIGN KEY (`Product_Item_ID`) REFERENCES `product_item` (`id`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (15,19,12,1,2000.00),(16,20,12,1,2000.00),(17,21,12,1,2000.00),(18,22,12,1,2000.00),(19,23,12,1,2000.00),(20,24,12,5,10000.00),(21,25,2,3,5685000.00),(22,25,12,8,16000.00),(23,26,2,3,5685000.00),(24,26,12,8,16000.00),(25,27,2,3,5685000.00),(26,27,12,8,16000.00),(27,28,2,3,5685000.00),(28,28,12,8,16000.00),(29,29,12,8,16000.00),(30,30,12,8,16000.00),(31,31,12,8,16000.00),(32,32,12,8,16000.00),(33,33,12,8,16000.00),(34,34,12,8,16000.00),(35,35,12,8,16000.00),(36,36,12,8,16000.00),(37,37,12,8,16000.00),(38,38,12,8,16000.00),(39,39,12,8,16000.00),(40,40,12,8,16000.00),(41,41,12,8,16000.00),(42,42,12,8,16000.00),(43,43,12,8,16000.00),(44,44,12,8,16000.00),(45,45,12,8,16000.00),(46,46,12,8,16000.00),(47,47,12,8,16000.00),(48,48,12,8,16000.00),(49,49,12,8,16000.00),(50,50,27,1,2200.00),(51,51,27,5,11000.00),(52,52,27,5,11000.00),(53,53,27,6,13200.00),(54,54,28,1,2200.00),(55,54,37,11,1452000.00),(56,54,29,6,13200.00),(57,54,35,5,7150.00),(58,54,27,6,13200.00),(59,54,20,7,14000.00),(60,55,27,7,15400.00),(61,55,37,9,1188000.00);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdiscounts`
--

DROP TABLE IF EXISTS `orderdiscounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdiscounts` (
  `OrderID` int NOT NULL,
  `DiscountID` int NOT NULL,
  PRIMARY KEY (`OrderID`,`DiscountID`),
  KEY `DiscountID` (`DiscountID`),
  CONSTRAINT `orderdiscounts_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE,
  CONSTRAINT `orderdiscounts_ibfk_2` FOREIGN KEY (`DiscountID`) REFERENCES `discounts` (`DiscountID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdiscounts`
--

LOCK TABLES `orderdiscounts` WRITE;
/*!40000 ALTER TABLE `orderdiscounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdiscounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `OrderDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `TotalAmount` decimal(10,2) NOT NULL,
  `Status` enum('Chờ duyệt','Chuẩn bị hàng','Đang vận chuyển','Đã giao','Hủy','Quá hạn thanh toán') COLLATE utf8mb4_general_ci DEFAULT 'Chờ duyệt',
  `name` text COLLATE utf8mb4_general_ci NOT NULL,
  `phonenumber` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `address` text COLLATE utf8mb4_general_ci NOT NULL,
  `payment_method` enum('cod','bank') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_status` enum('Chưa thanh toán','Đã thanh toán') COLLATE utf8mb4_general_ci DEFAULT 'Chưa thanh toán',
  PRIMARY KEY (`OrderID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `fk_user_order` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (19,4,'2025-04-10 04:48:54',2000.00,'Đã giao','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Đã thanh toán'),(20,4,'2025-04-10 04:50:58',2000.00,'Đã giao','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Đã thanh toán'),(21,4,'2025-04-10 12:35:43',2000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(22,4,'2025-04-10 12:35:57',2000.00,'Quá hạn thanh toán','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Chưa thanh toán'),(23,4,'2025-04-10 12:36:05',2000.00,'Quá hạn thanh toán','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Chưa thanh toán'),(24,4,'2025-04-10 12:39:23',10000.00,'Đã giao','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Đã thanh toán'),(25,4,'2025-04-13 07:59:10',5701000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(26,4,'2025-04-13 08:27:37',5701000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(27,4,'2025-04-13 08:28:11',5701000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(28,4,'2025-04-13 08:31:57',5701000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(29,4,'2025-04-13 08:32:55',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(30,4,'2025-04-13 08:33:03',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(31,4,'2025-04-13 08:36:28',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(32,4,'2025-04-13 08:36:54',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(33,4,'2025-04-13 08:38:33',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(34,4,'2025-04-13 08:39:11',16000.00,'Đã giao','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Đã thanh toán'),(35,4,'2025-04-13 08:41:29',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(36,4,'2025-04-13 08:41:41',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(37,4,'2025-04-13 08:43:11',16000.00,'Đã giao','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Đã thanh toán'),(38,4,'2025-04-13 08:45:14',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(39,4,'2025-04-13 08:45:43',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(40,4,'2025-04-13 08:52:07',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(41,4,'2025-04-13 08:52:44',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(42,4,'2025-04-13 08:53:30',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(43,4,'2025-04-13 08:53:36',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(44,4,'2025-04-13 08:53:44',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(45,4,'2025-04-13 08:53:56',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(46,4,'2025-04-13 09:01:18',16000.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(47,4,'2025-04-13 09:01:44',16000.00,'Đã giao','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Đã thanh toán'),(48,4,'2025-04-13 09:02:57',16000.00,'Quá hạn thanh toán','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Chưa thanh toán'),(49,4,'2025-04-13 09:03:26',16000.00,'Chuẩn bị hàng','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Đã thanh toán'),(50,4,'2025-04-15 14:29:01',2200.00,'Quá hạn thanh toán','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Chưa thanh toán'),(51,4,'2025-04-15 14:32:35',11000.00,'Chuẩn bị hàng','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Đã thanh toán'),(52,4,'2025-04-15 17:17:40',11000.00,'Chuẩn bị hàng','Nguyễn Công Trung','0966421165','huyện bình chánh','bank','Đã thanh toán'),(53,4,'2025-04-15 17:24:52',13200.00,'Hủy','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán'),(54,5,'2025-04-16 13:05:02',1501750.00,'Hủy','Nguyễn Công Trung','0912345678','huyện Bình Chánh','cod','Chưa thanh toán'),(55,4,'2025-05-16 08:11:58',1203400.00,'Chờ duyệt','Nguyễn Công Trung','0966421165','huyện bình chánh','cod','Chưa thanh toán');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `PaymentMethod` enum('credit_card','paypal','cash_on_delivery') COLLATE utf8mb4_general_ci NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `PaymentDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` enum('pending','completed','failed') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  PRIMARY KEY (`PaymentID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_configuration`
--

DROP TABLE IF EXISTS `product_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_configuration` (
  `product_item_id` int NOT NULL,
  `variation_option_id` int NOT NULL,
  PRIMARY KEY (`product_item_id`,`variation_option_id`),
  KEY `fk_variation_opt_idx` (`variation_option_id`),
  CONSTRAINT `fk_product_item` FOREIGN KEY (`product_item_id`) REFERENCES `product_item` (`id`),
  CONSTRAINT `fk_variation_opt` FOREIGN KEY (`variation_option_id`) REFERENCES `variation_opt` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_configuration`
--

LOCK TABLES `product_configuration` WRITE;
/*!40000 ALTER TABLE `product_configuration` DISABLE KEYS */;
INSERT INTO `product_configuration` VALUES (1,5),(2,5),(11,5),(1,6),(2,6),(1,7),(2,7),(1,8),(2,8),(1,9),(2,9),(1,10),(2,10),(1,11),(24,11),(25,11),(26,11),(27,11),(1,12),(2,12),(1,13),(2,13),(1,14),(2,14),(1,15),(2,15),(1,16),(2,16),(1,17),(2,17),(1,18),(2,18),(2,19),(11,24),(11,25),(12,26),(13,27),(14,28),(15,28),(16,28),(17,28),(18,28),(19,28),(14,29),(15,29),(16,29),(17,29),(18,29),(19,29),(14,30),(15,30),(16,30),(17,30),(18,30),(19,30),(14,31),(15,31),(16,31),(17,31),(18,31),(19,31),(14,32),(15,32),(16,32),(17,32),(18,32),(19,32),(14,33),(15,33),(16,33),(17,33),(18,33),(19,33),(14,34),(15,34),(16,34),(17,34),(18,34),(19,34),(14,35),(15,35),(16,35),(17,35),(18,35),(19,35),(14,36),(15,36),(16,36),(26,36),(27,36),(14,37),(15,37),(16,37),(17,37),(18,37),(19,37),(14,38),(15,38),(16,38),(17,38),(18,38),(19,38),(14,39),(15,39),(16,39),(17,39),(18,39),(19,39),(14,40),(15,40),(16,40),(17,40),(18,40),(19,40),(14,41),(15,42),(18,42),(19,42),(28,42),(16,43),(17,43),(17,44),(18,44),(24,44),(25,44),(28,44),(29,44),(19,45),(20,46),(20,47),(20,48),(39,48),(40,48),(41,48),(21,49),(22,50),(24,52),(27,52),(25,53),(26,53),(24,54),(25,54),(26,54),(27,54),(28,55),(29,55),(29,56),(28,57),(29,57),(31,59),(33,61),(35,63),(37,65),(42,66),(43,67),(44,68),(45,68),(47,68),(44,69),(45,70),(46,71);
/*!40000 ALTER TABLE `product_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_import_details`
--

DROP TABLE IF EXISTS `product_import_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_import_details` (
  `idproduct_import` int NOT NULL,
  `idproduct_item` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  KEY `fk_product_item_import_idx` (`idproduct_item`),
  KEY `fk_product_import_1_idx` (`idproduct_import`),
  CONSTRAINT `fk_product_import_1` FOREIGN KEY (`idproduct_import`) REFERENCES `product_imports` (`idproduct_imports`),
  CONSTRAINT `fk_product_item_import` FOREIGN KEY (`idproduct_item`) REFERENCES `product_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_import_details`
--

LOCK TABLES `product_import_details` WRITE;
/*!40000 ALTER TABLE `product_import_details` DISABLE KEYS */;
INSERT INTO `product_import_details` VALUES (2,11,11,2.00),(3,11,11,2.00),(4,11,11,2.00),(5,11,11,2.00),(6,11,11,2.00),(7,11,11,2.00),(8,11,11,2.00),(9,11,11,2.00),(10,11,11,2.00),(10,12,11,22.00),(11,11,11,2.00),(11,12,11,22.00),(12,11,11,2.00),(12,12,11,22.00),(12,13,1111,2000.00),(13,12,1000,2000.00),(14,20,111,2000.00),(15,22,10,2000.00),(16,22,10,2000.00),(16,21,10,2000.00),(15,21,10,2000.00),(18,27,100,2000.00),(18,26,100,2000.00),(18,25,50,2000.00),(18,24,10,2000.00),(20,29,10,2000.00),(20,28,10,2000.00),(21,31,10,2000.00),(22,31,10,2000.00),(25,33,20,1500.00),(26,35,15,1300.00),(27,37,15,120000.00),(28,39,25,10000.00),(29,40,23,2200.00),(30,41,4,11000.00),(31,42,100,1100.00),(32,43,33,10000.00),(33,45,11,1234.00),(33,44,23,1234.00),(34,47,20,10000.00),(34,46,11,40000.00);
/*!40000 ALTER TABLE `product_import_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_imports`
--

DROP TABLE IF EXISTS `product_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_imports` (
  `idproduct_imports` int NOT NULL AUTO_INCREMENT,
  `idsupplier` int NOT NULL,
  `import_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idproduct_imports`),
  KEY `fk_supplier_idx` (`idsupplier`),
  CONSTRAINT `fk_supplier_import` FOREIGN KEY (`idsupplier`) REFERENCES `suppliers` (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_imports`
--

LOCK TABLES `product_imports` WRITE;
/*!40000 ALTER TABLE `product_imports` DISABLE KEYS */;
INSERT INTO `product_imports` VALUES (1,1,'2025-03-26 02:30:04',22.00),(2,1,'2025-03-26 02:31:56',22.00),(3,1,'2025-03-26 02:31:57',22.00),(4,1,'2025-03-26 02:32:04',22.00),(5,1,'2025-03-26 02:32:05',22.00),(6,1,'2025-03-26 02:32:06',22.00),(7,1,'2025-03-26 02:32:07',22.00),(8,1,'2025-03-26 02:36:08',22.00),(9,1,'2025-03-26 02:37:05',22.00),(10,1,'2025-03-26 02:38:40',264.00),(11,1,'2025-03-26 02:39:48',264.00),(12,1,'2025-03-26 02:40:37',2222264.00),(13,1,'2025-04-08 01:34:29',2000000.00),(14,1,'2025-04-13 17:27:56',222000.00),(15,1,'2025-04-13 18:23:17',40000.00),(16,1,'2025-04-13 18:23:21',40000.00),(18,1,'2025-04-15 14:14:08',520000.00),(20,1,'2025-04-16 03:45:43',40000.00),(21,1,'2025-04-16 04:08:50',20000.00),(22,1,'2025-04-16 04:08:51',20000.00),(23,1,'2025-04-16 04:17:39',30000.00),(25,1,'2025-04-16 04:22:37',30000.00),(26,1,'2025-04-16 06:26:21',19500.00),(27,1,'2025-04-16 06:56:54',1800000.00),(28,1,'2025-04-16 07:13:08',250000.00),(29,2,'2025-04-16 07:31:17',50600.00),(30,1,'2025-04-16 13:03:19',44000.00),(31,2,'2025-04-17 01:48:49',110000.00),(32,1,'2025-04-17 01:52:03',330000.00),(33,1,'2025-04-17 02:15:43',41956.00),(34,1,'2025-04-17 02:35:00',640000.00);
/*!40000 ALTER TABLE `product_imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_item`
--

DROP TABLE IF EXISTS `product_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `SKU` text NOT NULL,
  `qty_in_stock` int NOT NULL,
  `product_image` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text,
  `status` int NOT NULL DEFAULT '1',
  `profit_margin` float NOT NULL,
  `reserved_stock` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_product_idx` (`product_id`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_item`
--

LOCK TABLES `product_item` WRITE;
/*!40000 ALTER TABLE `product_item` DISABLE KEYS */;
INSERT INTO `product_item` VALUES (1,61,'XM-RN12-8-128-YLW ',10,'/products/100005.jpg',4290000.00,'tỏa sáng với diện mạo viền vuông cực thời thượng cùng hiệu suất mạnh mẽ nhờ sở hữu con chip Snapdragon 685 ấn tượng. Chất lượng hiển thị hình ảnh của Redmi Note 12 Vàng cũng khá sắc nét thông qua tấm nền AMOLED 120Hz hiện đại. Chưa hết, máy còn sở hữu cụm 3 camera với độ rõ nét lên tới 50MP cùng viên pin 5000mAh và s ạc nhanh 33W giúp đáp ứng được mọi nhu cầu sử dụng của người dùng.',1,30.2,0),(2,61,'XM-RN12-4-128-YLW ',10,'/products/100006.jpg',3790000.00,'ấn tượng với màn hình DotDisplay AMOLED kích thước lớn 6,67 inch cùng với tần số làm mới 120Hz cũng như độ sáng 450 nit. Điện thoại còn sở hữu một cấu hình với chip Snapdragon® 685 8 nhân cùng CPU Adreno 610. Máy với cụm camera, trong đó ống kính chính 50MP sử dụng cảm biến Samsung JN1 độ phân giải đến 50MP cùng ống kính góc rộng 8MP.',1,0,0),(11,61,'adsfff',121,'/products/1742261222454-3122410432.png',2.00,'adsf',0,0,0),(12,62,'aaaa',960,'/products/1742265595152-c5ff6d56-879d-42f3-bb27-1ed8693ca9e9.jpg',2000.00,'adf',0,0,0),(13,61,'fzfds',1111,'/products/1742907901293-50sm_vol3in1.webp',2020.00,'ad',0,1,0),(14,64,'SS-S25U-12-256-XD',0,'/products/1743731096548-dien-thoai-samsung-galaxy-s25-ultra_2__3.webp',0.00,'',2,7,0),(15,64,'SS-S25U-12-256-DEN',0,'/products/1743731240641-dien-thoai-samsung-galaxy-s25-ultra_3__3.webp',0.00,'',2,7,0),(16,64,'SS-S25U-12-256-XAM',0,'/products/1743731303215-dien-thoai-samsung-galaxy-s25-ultra_1__6.webp',0.00,'',2,7,0),(17,64,'SS-S25U-12-512-XAM',0,'/products/1743731411542-dien-thoai-samsung-galaxy-s25-ultra_1__6.webp',0.00,'',2,7,0),(18,64,'SS-S25U-12-512-DEN',0,'/products/1743731452697-dien-thoai-samsung-galaxy-s25-ultra_3__3.webp',0.00,'',2,7,0),(19,64,'SS-S25U-12-1TB-DEN',0,'/products/1743731514356-dien-thoai-samsung-galaxy-s25-ultra_3__3.webp',0.00,'',2,7,0),(20,65,'ctc-2m-dr-t11',111,'/products/1744564489186-cap-type-c-type-c-2m-xmobile-dr-t11-1-750x500.jpg',2000.00,'',1,0,0),(21,66,'etc-xam',10,'/products/1744568362722-tai-nghe-co-day-ep-type-c-xiaomi-den-1-638630299770505716-750x500.jpg',2000.00,'',1,0,0),(22,67,'pwb-Lite-P16ZM',10,'/products/1744568557113-pin-sac-du-phong-10000mah-type-c-pd-qc-3-0-22-5w-xiaomi-lite-p16zm-1-638730564092808008-750x500.jpg',2000.00,'',1,0,0),(24,68,'ip-15-prm-512-white',10,'/products/1744725808429-iphone-15-pro-max-titan-trang-2-638629415562660838-750x500.jpg',2200.00,'',1,10,0),(25,68,'ip-15-prm-512-black',50,'/products/1744725858252-iphone-15-pro-max-titan-den-2-638629415736483700-750x500.jpg',2200.00,'',1,10,0),(26,68,'ip-15-prm-256-black',100,'/products/1744725957486-iphone-15-pro-max-titan-den-2-638629415736483700-750x500.jpg',2200.00,'',1,10,0),(27,68,'ip-15-prm-256-white',90,'/products/1744725999467-iphone-15-pro-max-titan-trang-2-638629415562660838-750x500.jpg',2200.00,'',1,10,7),(28,69,'op-find-N55g-16-512-black',10,'/products/1744774404473-oppo-find-n5-black-1-638797292350129698-750x500.jpg',2200.00,'',1,10,0),(29,69,'op-find-N55g-16-512-white',10,'/products/1744774424879-oppo-find-n5-white-1-638797263337721585-750x500.jpg',2200.00,'',1,10,0),(31,70,'ep-ap-MTJY3',20,'/products/1744776512859-tai-nghe-co-day-apple-mtjy3-11-700x467.jpg',2200.00,'',1,10,0),(33,71,'ep-ss-IA500',20,'/products/1744777339035-nhet-tai-samsung-ia500-den-thumb-600x600.jpg',1650.00,'',1,10,0),(35,72,'ep-op-MH320',15,'/products/1744784758618-co-day-ep-oppo-mh320-11-600x600.jpg',1430.00,'',1,10,0),(37,73,'ep-sony-MDR-G300',15,'/products/1744786281243-tai-nghe-chup-tai-gaming-sony-inzone-h3-mdr-g300-thumb-600x600.jpg',132000.00,'',1,10,9),(39,74,'ctc-Xmobile-DR-T10',25,'/products/1744787188867-cap-type-c-1m-xmobile-dr-t10-thumb-600x600.jpg',10200.00,'',1,2,0),(40,75,'ctc-Xmobile-DS09CP-WB',23,'/products/1744788654157-cap-type-c-1m-xmobile-ds09cp-wb-thumb1-600x600.jpeg',2310.00,'',1,5,0),(41,76,'ctc-Xmobile-DR003',4,'/products/1744808570149-cap-da-nang-4-in-1-lightning-type-c-1m-xmobile-dr003-thumb-2-600x600.jpg',11550.00,'',1,5,0),(42,77,'apt--Xmobile-DS051A',100,'/products/1744854501710-adapter-sac-type-c-pd-gan-30w-xmobile-ds051a-1-638690766888110870-750x500.jpg',1122.00,'',1,2,0),(43,78,'ctc-Anker-322-A81F5',33,'/products/1744854706976-cap-type-c-type-c-0-9m-anker-322-a81f5-trang-1-638678923981766495-750x500.jpg',10200.00,'',1,2,0),(44,79,'pwb-Baseus-Lipow-PPJP312-black',23,'/products/1744855932882-pin-sac-du-phong-20000mah-type-c-pd-22-5w-baseus-lipow-ppjp312-den-1-638754755512908676-750x500.jpg',1271.02,'',1,3,0),(45,79,'pwb-Baseus-Lipow-PPJP312-white',11,'/products/1744855951735-pin-sac-du-phong-20000mah-type-c-pd-22-5w-baseus-lipow-ppjp312-trang-1-638754755742026031-750x500.jpg',1271.02,'',1,3,0),(46,80,'pwb-Xmobile-YM-672',11,'/products/1744857121102-pin-sac-du-phong-20000mah-type-c-pd-qc-3-0-22-5w-xmobile-ym-672-den-1-638671751950565343-750x500.jpg',41200.00,'',1,3,0),(47,81,'pwb-Baseus PicoGo-PPPG-1W45C',20,'/products/1744857272688-pin-sac-du-phong-10000mah-type-c-pd-qc-3-0-45w-baseus-picogo-pppg-1w45c-1-638677175230697544-750x500.jpg',10500.00,'',1,5,0);
/*!40000 ALTER TABLE `product_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productanswers`
--

DROP TABLE IF EXISTS `productanswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productanswers` (
  `AnswerID` int NOT NULL AUTO_INCREMENT,
  `QuestionID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Answer` text COLLATE utf8mb4_general_ci NOT NULL,
  `AnsweredDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AnswerID`),
  KEY `QuestionID` (`QuestionID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `productanswers_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `productquestions` (`QuestionID`) ON DELETE CASCADE,
  CONSTRAINT `productanswers_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productanswers`
--

LOCK TABLES `productanswers` WRITE;
/*!40000 ALTER TABLE `productanswers` DISABLE KEYS */;
/*!40000 ALTER TABLE `productanswers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productattributes`
--

DROP TABLE IF EXISTS `productattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productattributes` (
  `AttributeID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `AttributeName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `AttributeValue` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`AttributeID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `productattributes_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productattributes`
--

LOCK TABLES `productattributes` WRITE;
/*!40000 ALTER TABLE `productattributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `productattributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productcart`
--

DROP TABLE IF EXISTS `productcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productcart` (
  `CartID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  `AddedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CartID`),
  KEY `UserID` (`UserID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `productcart_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `productcart_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productcart`
--

LOCK TABLES `productcart` WRITE;
/*!40000 ALTER TABLE `productcart` DISABLE KEYS */;
/*!40000 ALTER TABLE `productcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productcategories`
--

DROP TABLE IF EXISTS `productcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productcategories` (
  `ProductID` int NOT NULL,
  `CategoryID` int NOT NULL,
  PRIMARY KEY (`ProductID`,`CategoryID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `productcategories_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productcategories_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productcategories`
--

LOCK TABLES `productcategories` WRITE;
/*!40000 ALTER TABLE `productcategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `productcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productlogs`
--

DROP TABLE IF EXISTS `productlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productlogs` (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `Action` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ActionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UserID` int DEFAULT NULL,
  PRIMARY KEY (`LogID`),
  KEY `ProductID` (`ProductID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `productlogs_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productlogs_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productlogs`
--

LOCK TABLES `productlogs` WRITE;
/*!40000 ALTER TABLE `productlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `productlogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productnotifications`
--

DROP TABLE IF EXISTS `productnotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productnotifications` (
  `NotificationID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Message` text COLLATE utf8mb4_general_ci NOT NULL,
  `IsRead` tinyint(1) DEFAULT '0',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NotificationID`),
  KEY `ProductID` (`ProductID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `productnotifications_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productnotifications_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productnotifications`
--

LOCK TABLES `productnotifications` WRITE;
/*!40000 ALTER TABLE `productnotifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `productnotifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productpromotions`
--

DROP TABLE IF EXISTS `productpromotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productpromotions` (
  `ProductID` int NOT NULL,
  `PromotionID` int NOT NULL,
  KEY `PromotionID` (`PromotionID`),
  KEY `fk_product_promotion_idx` (`ProductID`),
  CONSTRAINT `fk_product_promotion` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productpromotions_ibfk_2` FOREIGN KEY (`PromotionID`) REFERENCES `promotions` (`PromotionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productpromotions`
--

LOCK TABLES `productpromotions` WRITE;
/*!40000 ALTER TABLE `productpromotions` DISABLE KEYS */;
INSERT INTO `productpromotions` VALUES (61,1);
/*!40000 ALTER TABLE `productpromotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productquestions`
--

DROP TABLE IF EXISTS `productquestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productquestions` (
  `QuestionID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Question` text COLLATE utf8mb4_general_ci NOT NULL,
  `Answer` text COLLATE utf8mb4_general_ci,
  `AskedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `AnsweredDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`QuestionID`),
  KEY `ProductID` (`ProductID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `productquestions_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productquestions_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productquestions`
--

LOCK TABLES `productquestions` WRITE;
/*!40000 ALTER TABLE `productquestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `productquestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productrecommendations`
--

DROP TABLE IF EXISTS `productrecommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productrecommendations` (
  `RecommendationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `RecommendationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RecommendationID`),
  KEY `UserID` (`UserID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `productrecommendations_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `productrecommendations_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productrecommendations`
--

LOCK TABLES `productrecommendations` WRITE;
/*!40000 ALTER TABLE `productrecommendations` DISABLE KEYS */;
/*!40000 ALTER TABLE `productrecommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productreviews`
--

DROP TABLE IF EXISTS `productreviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productreviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Comment` text COLLATE utf8mb4_general_ci,
  `ReviewDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReviewID`),
  KEY `ProductID` (`ProductID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `productreviews_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productreviews_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `productreviews_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productreviews`
--

LOCK TABLES `productreviews` WRITE;
/*!40000 ALTER TABLE `productreviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `productreviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `ProductName` text COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text COLLATE utf8mb4_general_ci,
  `category_id` int NOT NULL,
  `product_image` text COLLATE utf8mb4_general_ci,
  `status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`ProductID`),
  KEY `fk_product_category_idx` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (61,'Xiaomi Redmi Note 12','ấn tượng với màn hình DotDisplay AMOLED kích thước lớn 6,67 inch cùng với tần số làm mới 120Hz cũng như độ sáng 450 nit. Điện thoại còn sở hữu một cấu hình với chip Snapdragon® 685 8 nhân cùng CPU Adreno 610. Máy với cụm camera, trong đó ống kính chính 50MP sử dụng cảm biến Samsung JN1 độ phân giải đến 50MP cùng ống kính góc rộng 8MP.',1,'/products/100005.jpg',1),(62,'atesst','adsfsd',1,'/products/1742265334016-tkb1.jpeg',0),(63,'Samsung Galaxy S23 Ultra','',1,'/products/1743728992470-100001.jpg',1),(64,'Samsung Galaxy S25 Ultra','',1,'/products/1743729657152-dien-thoai-samsung-galaxy-s25-ultra_3__3.webp',1),(65,'Cáp Type C - Type C 2m Xmobile DR-T11','',3,'/products/1744564355996-cap-type-c-type-c-2m-xmobile-dr-t11-1-750x500.jpg',1),(66,'Tai nghe Có dây Type C Xiaomi','',2,'/products/1744568303472-tai-nghe-co-day-ep-type-c-xiaomi-den-1-638630299770505716-750x500.jpg',1),(67,'Pin sạc dự phòng 10000mAh Type C PD QC 3.0 22.5W Xiaomi Lite P16ZM','',4,'/products/1744568488111-pin-sac-du-phong-10000mah-type-c-pd-qc-3-0-22-5w-xiaomi-lite-p16zm-1-638730564092808008-750x500.jpg',1),(68,'IPhone 15 Pro Max','',1,'/products/1744725474685-iphone-15-pro-max-titan-trang-2-638629415562660838-750x500.jpg',1),(69,'OPPO Find N5 5G','',1,'/products/1744773174751-oppo-find-n5-black-1-638797292350129698-750x500.jpg',1),(70,'Tai nghe Có Dây Apple MTJY3','',2,'/products/1744776118894-tai-nghe-co-day-apple-mtjy3-11-700x467.jpg',1),(71,'Tai nghe Có Dây Samsung IA500','',2,'/products/1744777013567-nhet-tai-samsung-ia500-den-thumb-600x600.jpg',1),(72,'Tai nghe Có Dây OPPO MH320','',2,'/products/1744784675610-co-day-ep-oppo-mh320-11-600x600.jpg',1),(73,'Tai nghe Chụp Tai Gaming Sony INZONE H3 MDR-G300','',2,'/products/1744786064356-tai-nghe-chup-tai-gaming-sony-inzone-h3-mdr-g300-thumb-600x600.jpg',1),(74,'Cáp Type C 1m Xmobile DR-T10','',3,'/products/1744787082334-cap-type-c-1m-xmobile-dr-t10-thumb-600x600.jpg',1),(75,'Cáp Type C 1m Xmobile DS09CP-WB','',3,'/products/1744788625846-cap-type-c-1m-xmobile-ds09cp-wb-thumb1-600x600.jpeg',1),(76,'Cáp Đa Năng 4 in 1 Lightning Type C 1m Xmobile DR003','',3,'/products/1744808540387-cap-da-nang-4-in-1-lightning-type-c-1m-xmobile-dr003-thumb-2-600x600.jpg',1),(77,'Adapter Sạc Type C PD GaN 30W Xmobile DS051A','',5,'/products/1744854460045-adapter-sac-type-c-pd-gan-30w-xmobile-ds051a-1-638690766888110870-750x500.jpg',1),(78,'Cáp Type C - Type C 0.9m Anker 322 A81F5','',3,'/products/1744854663352-cap-type-c-type-c-0-9m-anker-322-a81f5-trang-1-638678923981766495-750x500.jpg',1),(79,'Pin sạc dự phòng 20000mAh Type C PD 22.5W Baseus Lipow PPJP312 kèm Cáp Lightning và Type C','',4,'/products/1744855781933-pin-sac-du-phong-20000mah-type-c-pd-22-5w-baseus-lipow-ppjp312-den-1-638754755512908676-750x500.jpg',1),(80,'Pin sạc dự phòng 20000mAh Type C PD QC 3.0 22.5W Xmobile YM-672','',4,'/products/1744857068368-pin-sac-du-phong-20000mah-type-c-pd-qc-3-0-22-5w-xmobile-ym-672-den-1-638671751950565343-750x500.jpg',1),(81,'Pin sạc dự phòng 10000mAh Type C PD QC 3.0 45W Baseus PicoGo PPPG-1W45C kèm Cáp Type C','',4,'/products/1744857220933-pin-sac-du-phong-10000mah-type-c-pd-qc-3-0-45w-baseus-picogo-pppg-1w45c-1-638677175230697544-750x500.jpg',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productsettings`
--

DROP TABLE IF EXISTS `productsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsettings` (
  `SettingID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `SettingKey` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `SettingValue` text COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text COLLATE utf8mb4_general_ci,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SettingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productsettings`
--

LOCK TABLES `productsettings` WRITE;
/*!40000 ALTER TABLE `productsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `productsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productsuppliers`
--

DROP TABLE IF EXISTS `productsuppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsuppliers` (
  `ProductID` int NOT NULL,
  `SupplierID` int NOT NULL,
  PRIMARY KEY (`ProductID`,`SupplierID`),
  KEY `SupplierID` (`SupplierID`),
  CONSTRAINT `productsuppliers_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productsuppliers_ibfk_2` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productsuppliers`
--

LOCK TABLES `productsuppliers` WRITE;
/*!40000 ALTER TABLE `productsuppliers` DISABLE KEYS */;
/*!40000 ALTER TABLE `productsuppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producttagassignments`
--

DROP TABLE IF EXISTS `producttagassignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producttagassignments` (
  `ProductID` int NOT NULL,
  `TagID` int NOT NULL,
  PRIMARY KEY (`ProductID`,`TagID`),
  KEY `TagID` (`TagID`),
  CONSTRAINT `producttagassignments_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `producttagassignments_ibfk_2` FOREIGN KEY (`TagID`) REFERENCES `producttags` (`TagID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producttagassignments`
--

LOCK TABLES `producttagassignments` WRITE;
/*!40000 ALTER TABLE `producttagassignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `producttagassignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producttags`
--

DROP TABLE IF EXISTS `producttags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producttags` (
  `TagID` int NOT NULL AUTO_INCREMENT,
  `TagName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`TagID`),
  UNIQUE KEY `TagName` (`TagName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producttags`
--

LOCK TABLES `producttags` WRITE;
/*!40000 ALTER TABLE `producttags` DISABLE KEYS */;
/*!40000 ALTER TABLE `producttags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productviews`
--

DROP TABLE IF EXISTS `productviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productviews` (
  `ViewID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `ViewDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ViewID`),
  KEY `ProductID` (`ProductID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `productviews_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `productviews_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productviews`
--

LOCK TABLES `productviews` WRITE;
/*!40000 ALTER TABLE `productviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `productviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productwishlist`
--

DROP TABLE IF EXISTS `productwishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productwishlist` (
  `WishlistID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `AddedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`WishlistID`),
  KEY `UserID` (`UserID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `productwishlist_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `productwishlist_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productwishlist`
--

LOCK TABLES `productwishlist` WRITE;
/*!40000 ALTER TABLE `productwishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `productwishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `PromotionID` int NOT NULL AUTO_INCREMENT,
  `PromotionName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text COLLATE utf8mb4_general_ci,
  `DiscountRate` decimal(5,2) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PromotionID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
INSERT INTO `promotions` VALUES (1,'a','test',50.00,'2025-03-02','2029-06-27','2025-03-26 08:26:02');
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `returndetails`
--

DROP TABLE IF EXISTS `returndetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `returndetails` (
  `ReturnDetailID` int NOT NULL AUTO_INCREMENT,
  `ReturnID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  `Reason` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`ReturnDetailID`),
  KEY `ReturnID` (`ReturnID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `returndetails_ibfk_1` FOREIGN KEY (`ReturnID`) REFERENCES `returns` (`ReturnID`) ON DELETE CASCADE,
  CONSTRAINT `returndetails_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `returndetails`
--

LOCK TABLES `returndetails` WRITE;
/*!40000 ALTER TABLE `returndetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `returndetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `returns`
--

DROP TABLE IF EXISTS `returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `returns` (
  `ReturnID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `ReturnReason` text COLLATE utf8mb4_general_ci NOT NULL,
  `ReturnDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` enum('pending','approved','rejected','completed') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  PRIMARY KEY (`ReturnID`),
  KEY `OrderID` (`OrderID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `returns_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE,
  CONSTRAINT `returns_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `returns`
--

LOCK TABLES `returns` WRITE;
/*!40000 ALTER TABLE `returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Comment` text COLLATE utf8mb4_general_ci,
  `ReviewDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReviewID`),
  KEY `ProductID` (`ProductID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `SessionID` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `UserID` int DEFAULT NULL,
  `LoginTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastActivity` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IPAddress` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `UserAgent` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`SessionID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `SettingID` int NOT NULL AUTO_INCREMENT,
  `SettingKey` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `SettingValue` text COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text COLLATE utf8mb4_general_ci,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SettingID`),
  UNIQUE KEY `SettingKey` (`SettingKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping`
--

DROP TABLE IF EXISTS `shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping` (
  `ShippingID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `ShippingMethod` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `ShippingAddress` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ShippingDate` date DEFAULT NULL,
  `EstimatedDeliveryDate` date DEFAULT NULL,
  `Status` enum('pending','shipped','delivered') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  PRIMARY KEY (`ShippingID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping`
--

LOCK TABLES `shipping` WRITE;
/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `SupplierID` int NOT NULL AUTO_INCREMENT,
  `SupplierName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ContactName` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ContactEmail` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ContactPhone` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'tets','adf','adf','adsf','adf','2025-03-24 04:10:44',1),(2,'adsf','adsf','adsf','adsf','adsf','2025-03-24 04:11:02',1);
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_address`
--

DROP TABLE IF EXISTS `user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_address` (
  `iduser_address` int NOT NULL AUTO_INCREMENT,
  `iduser` int NOT NULL,
  `name` text NOT NULL,
  `phonenumber` varchar(10) NOT NULL,
  `address` text NOT NULL,
  `setDefault` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`iduser_address`),
  KEY `fk_user_address_idx` (`iduser`),
  CONSTRAINT `fk_user_address` FOREIGN KEY (`iduser`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_address`
--

LOCK TABLES `user_address` WRITE;
/*!40000 ALTER TABLE `user_address` DISABLE KEYS */;
INSERT INTO `user_address` VALUES (1,4,'Nguyễn Công Trung','0966421165','huyện bình chánh',1),(2,4,'Nguyễn Công Trung','0912345678','ds',0);
/*!40000 ALTER TABLE `user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `PasswordHash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `FullName` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PhoneNumber` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Role` enum('admin','customer') COLLATE utf8mb4_general_ci DEFAULT 'customer',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('1','0') COLLATE utf8mb4_general_ci DEFAULT '1',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'$2b$10$eHlewU7sl2OIxJYGosC8SuiBdb0jvBznQqVrxZ8syjyTi50DHkocC','admin0966@gmail.com','Nguyễn Công Trung','0966421165','admin','2025-02-16 11:23:09','1'),(4,'$2b$10$HKN.LP6aTtLxMo.uqGER4.ZqobZq4J0lDwRvbSS5OOuZkf/sfBwie','test0966@gmail.com','Nguyễn Công Trung','0966421111','customer','2025-02-17 02:29:37','1'),(5,'$2b$10$rlnY9mT1FxoAWt4kYgRdxuHUtrIYEre0a2L8.hbmKOzl2Y/Kni3De','test@gmail.com','Nguyễn Công Trung','0912345678','customer','2025-04-16 02:40:01','1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation`
--

DROP TABLE IF EXISTS `variation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation` (
  `VariantID` int NOT NULL AUTO_INCREMENT,
  `CategoryID` int NOT NULL,
  `VariantName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`VariantID`),
  KEY `ProductID` (`CategoryID`),
  CONSTRAINT `fk_variant_category` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation`
--

LOCK TABLES `variation` WRITE;
/*!40000 ALTER TABLE `variation` DISABLE KEYS */;
INSERT INTO `variation` VALUES (27,1,'Hãng'),(28,1,'Kích thước màn hình'),(29,1,'Công nghệ màn hình'),(30,1,'Camera sau'),(31,1,'Camera trước'),(32,1,'Chipset'),(33,1,'Dung lượng RAM'),(34,1,'Bộ nhớ trong'),(35,1,'Pin'),(36,1,'Thẻ SIM'),(37,1,'Hệ điều hành'),(38,1,'Độ phân giải màn hình'),(39,1,'Tính năng màn hình'),(40,1,'Màu'),(41,1,'dsaf'),(42,1,'ádsd'),(43,1,'Công nghệ NFC'),(44,3,'Đầu vào'),(45,3,'Đầu ra'),(46,3,'Hãng'),(47,2,'Hãng'),(48,4,'Hãng'),(49,5,'Hãng'),(50,4,'Màu');
/*!40000 ALTER TABLE `variation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_opt`
--

DROP TABLE IF EXISTS `variation_opt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation_opt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `variationID` int NOT NULL,
  `value` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `AttributeID` (`variationID`),
  CONSTRAINT `fk_opt_variation` FOREIGN KEY (`variationID`) REFERENCES `variation` (`VariantID`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_opt`
--

LOCK TABLES `variation_opt` WRITE;
/*!40000 ALTER TABLE `variation_opt` DISABLE KEYS */;
INSERT INTO `variation_opt` VALUES (5,27,'Xiaomi'),(6,28,'6.67 inches'),(7,29,'AMOLED'),(8,30,'Camera chính: 50MP, f/1.8 <br> Camera góc rộng: 8MP, f/2.2, 120° <br> Camera Macro: 2MP, f/2.4'),(9,31,'13MP, f/2.45'),(10,32,'Qualcomm Snapdragon 685'),(11,33,'8 GB'),(12,34,'128 GB'),(13,35,'5000mAh'),(14,36,'2 SIM (Nano-SIM)'),(15,37,'Android 12'),(16,38,'1080 x 2400 pixels (FullHD+)'),(17,39,'Tần số quét 120Hz, độ sáng 1200nits  <br> Corning® Gorilla® Glass 3'),(18,40,'Vàng'),(19,33,'4 GB'),(23,34,'ádf'),(24,29,'adsfsd'),(25,33,'đá'),(26,32,'a'),(27,39,'dsaf'),(28,28,'6.9 inches'),(29,29,'Dynamic AMOLED 2X'),(30,30,'Camera siêu rộng 50MP Camera góc rộng 200 MP Camera Tele (5x) 50MP Camera Tele (3x) 10MP'),(31,31,'12 MP'),(32,32,'Snapdragon 8 Elite dành cho Galaxy (3nm)'),(33,43,'Có'),(34,35,'5000 mAH'),(35,33,'12 GB'),(36,34,'256 GB'),(37,36,'2 Nano-SIM + eSIM'),(38,37,'Android 17'),(39,38,'3120 x 1440 pixels (Quad HD+)'),(40,39,'120Hz 2600 nits Corning® Gorilla® Armor 2'),(41,40,'Xanh dương'),(42,40,'Đen'),(43,40,'Xám'),(44,34,'512 GB'),(45,34,'1 TB'),(46,44,'USB Type-C'),(47,45,'Type C: 5V - 3A, 9V - 2A, 12V - 3A, 15V - 3A, 20V - 3A (Max 60 W)'),(48,46,'Xmobile'),(49,47,'Xiaomi'),(50,48,'Xiaomi'),(52,40,'Titan trắng'),(53,40,'Titan đen'),(54,27,'Apple'),(55,33,'16 GB'),(56,40,'Trắng'),(57,27,'Oppo'),(59,47,'Apple'),(61,47,'Samsung'),(63,47,'Oppo'),(65,47,'Sony'),(66,49,'Xmobile'),(67,46,'Anker'),(68,48,'Baseus'),(69,50,'Đen'),(70,50,'Trắng'),(71,48,'Xmobile');
/*!40000 ALTER TABLE `variation_opt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `WishlistID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `AddedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`WishlistID`),
  KEY `UserID` (`UserID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-08 17:34:55
