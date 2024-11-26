-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: fave_db
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `log_id` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nick` varchar(30) NOT NULL,
  `regimg` int NOT NULL,
  `amounthand` int NOT NULL,
  `living` int NOT NULL,
  `saiosi` int DEFAULT NULL,
  `mainwork` int DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('a','aa','a',0,0,0,-1,0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cate_id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'譛ｪ逋ｻ骭ｲ');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osi`
--

DROP TABLE IF EXISTS `osi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `osi` (
  `osi_id` int NOT NULL AUTO_INCREMENT,
  `img` varchar(255) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `birthday` date DEFAULT NULL,
  `osimemo` varchar(255) DEFAULT NULL,
  `log_id` varchar(30) NOT NULL,
  `cate_id` int NOT NULL,
  PRIMARY KEY (`osi_id`),
  KEY `log_id` (`log_id`),
  KEY `fk_category` (`cate_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`cate_id`) REFERENCES `category` (`cate_id`),
  CONSTRAINT `osi_ibfk_1` FOREIGN KEY (`log_id`) REFERENCES `account` (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osi`
--

LOCK TABLES `osi` WRITE;
/*!40000 ALTER TABLE `osi` DISABLE KEYS */;
/*!40000 ALTER TABLE `osi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osikatu`
--

DROP TABLE IF EXISTS `osikatu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `osikatu` (
  `osikatu_id` int NOT NULL AUTO_INCREMENT,
  `day` date DEFAULT NULL,
  `price` int NOT NULL,
  `item` varchar(50) NOT NULL,
  `purchase` int NOT NULL,
  `osi_id` int NOT NULL,
  `priority` int NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `itemtype` int NOT NULL,
  PRIMARY KEY (`osikatu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osikatu`
--

LOCK TABLES `osikatu` WRITE;
/*!40000 ALTER TABLE `osikatu` DISABLE KEYS */;
/*!40000 ALTER TABLE `osikatu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ositag`
--

DROP TABLE IF EXISTS `ositag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ositag` (
  `ositag_id` int NOT NULL AUTO_INCREMENT,
  `osi_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`ositag_id`),
  KEY `osi_id` (`osi_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `ositag_ibfk_1` FOREIGN KEY (`osi_id`) REFERENCES `osi` (`osi_id`),
  CONSTRAINT `ositag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ositag`
--

LOCK TABLES `ositag` WRITE;
/*!40000 ALTER TABLE `ositag` DISABLE KEYS */;
/*!40000 ALTER TABLE `ositag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shift`
--

DROP TABLE IF EXISTS `shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shift` (
  `shift_id` int NOT NULL AUTO_INCREMENT,
  `startdatetime` datetime NOT NULL,
  `enddatetime` datetime NOT NULL,
  `work_id` varchar(30) NOT NULL,
  `breaktime` int NOT NULL,
  `wage` int NOT NULL,
  PRIMARY KEY (`shift_id`),
  KEY `work_id` (`work_id`),
  CONSTRAINT `shift_ibfk_1` FOREIGN KEY (`work_id`) REFERENCES `work` (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shift`
--

LOCK TABLES `shift` WRITE;
/*!40000 ALTER TABLE `shift` DISABLE KEYS */;
/*!40000 ALTER TABLE `shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `cate_id` int NOT NULL,
  `tag` varchar(50) NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `cate_id` (`cate_id`),
  CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`cate_id`) REFERENCES `category` (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work`
--

DROP TABLE IF EXISTS `work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work` (
  `work_id` int NOT NULL AUTO_INCREMENT,
  `hourlywage` int NOT NULL,
  `work` varchar(50) NOT NULL,
  `log_id` varchar(30) NOT NULL,
  PRIMARY KEY (`work_id`),
  KEY `log_id` (`log_id`),
  CONSTRAINT `work_ibfk_1` FOREIGN KEY (`log_id`) REFERENCES `account` (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work`
--

LOCK TABLES `work` WRITE;
/*!40000 ALTER TABLE `work` DISABLE KEYS */;
/*!40000 ALTER TABLE `work` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-28  9:48:07
