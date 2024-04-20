-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: whepto
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `street1` varchar(45) NOT NULL,
  `street2` varchar(45) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `phone_number1` varchar(10) NOT NULL,
  `phone_number2` varchar(10) DEFAULT NULL,
  `customer` int DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `address_id_UNIQUE` (`address_id`),
  KEY `customer_address_idx` (`customer`),
  CONSTRAINT `customer_address` FOREIGN KEY (`customer`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'123 Main Street','Apt 4B','New Delhi','Delhi','9876543210',NULL,1),(2,'456 Oak Avenue','Suite 202','Mumbai','Maharashtra','8765432109',NULL,2),(3,'789 Pine Road','Unit 301','Bangalore','Karnataka','7654321098',NULL,3),(4,'101 Cedar Lane','Apt 102','Chennai','Tamil Nadu','6543210987',NULL,4),(5,'202 Maple Drive','Unit 502','Hyderabad','Telangana','5432109876',NULL,5),(6,'303 Birch Street','Apt 601','Kolkata','West Bengal','4321098765',NULL,6),(7,'404 Elm Court','Suite 402','Pune','Maharashtra','3210987654',NULL,7),(8,'505 Willow Avenue','Unit 702','Ahmedabad','Gujarat','2109876543',NULL,8),(9,'606 Rose Lane','Apt 802','Jaipur','Rajasthan','1098765432',NULL,9),(10,'707 Lotus Road','Suite 902','Lucknow','Uttar Pradesh','9876543210',NULL,10),(11,'111 Pine Street','Apt 11A','New Delhi','Delhi','8765432101',NULL,3),(12,'222 Cedar Avenue','Suite 22','Mumbai','Maharashtra','7654321092',NULL,5),(13,'333 Oak Road','Unit 33','Bangalore','Karnataka','6543210983',NULL,8),(14,'444 Birch Lane','Apt 44','Chennai','Tamil Nadu','5432109874',NULL,10),(15,'555 Maple Drive','Unit 55','Hyderabad','Telangana','4321098765',NULL,7),(28,'test',NULL,'test','test','1234567891',NULL,18),(29,'hhui',NULL,'hkjiuig','guguib','12345',NULL,12),(30,'hdsxeikih',NULL,'ahjsxhj','axchj','1234',NULL,NULL),(31,'asdfjiom',NULL,'sjfdio','sfdjjio','58342',NULL,12),(32,'Meri gali mein','meri meri gali me','mere shootero ka khaas','meri gali me','2211948',NULL,12);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `cart_id_UNIQUE` (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(18),(19),(20),(21),(22),(25),(26),(27),(28),(30),(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),(41);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `cart` int NOT NULL,
  `item` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart`,`item`),
  KEY `item_id_idx` (`item`),
  CONSTRAINT `cart_id` FOREIGN KEY (`cart`) REFERENCES `cart` (`cart_id`),
  CONSTRAINT `item_id` FOREIGN KEY (`item`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (1,1,2),(1,3,1),(2,2,3),(2,3,1),(2,4,1),(2,9,6),(2,17,1),(3,5,2),(3,7,1),(3,16,1),(3,28,1),(4,9,3),(4,10,1),(5,12,2),(5,14,1),(6,16,3),(6,18,1),(7,20,2),(7,22,1),(8,24,3),(9,26,2),(9,28,1),(10,30,3),(10,32,1),(11,34,2),(11,36,1),(12,38,3),(12,40,1),(13,42,2),(13,44,1),(14,46,3),(14,48,1),(15,50,2),(15,52,1),(22,2,1),(22,3,5),(22,6,4),(28,1,1),(28,8,1),(28,16,1),(30,1,1),(30,6,1),(31,2,1),(31,5,1),(32,1,1),(32,2,1),(33,1,1),(33,5,1),(34,3,1),(34,6,1),(35,2,1),(37,2,1),(37,3,1),(38,8,5),(38,20,10),(39,4,1),(39,5,1),(39,6,5),(40,3,1),(40,4,3),(40,16,1);
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id_UNIQUE` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Electronics'),(2,'Fashion'),(3,'Home and Living'),(4,'Beauty'),(5,'Books'),(6,'Sports');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `coupon_id` int NOT NULL,
  `coupon_code` varchar(45) NOT NULL,
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `coupon_id_UNIQUE` (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (1,'SAVE10OFF'),(2,'FREESHIP'),(3,'FESTIVE20'),(4,'FIRSTPURCHASE'),(5,'LOYALTY50');
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `cart` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_id_UNIQUE` (`customer_id`),
  KEY `cart_id_idx` (`cart`),
  CONSTRAINT `customer_cart` FOREIGN KEY (`cart`) REFERENCES `cart` (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Aarav','Patel','aarav.patel@example.com','hashed_password',11),(2,'Saanvi','Shah','saanvi.shah@example.com','hashed_password',2),(3,'Advait','Kumar','advait.kumar@example.com','hashed_password',3),(4,'Ananya','Verma','ananya.verma@example.com','hashed_password',4),(5,'Aaradhya','Singh','aaradhya.singh@example.com','hashed_password',13),(6,'Vivaan','Gupta','vivaan.gupta@example.com','hashed_password',12),(7,'Aanya','Joshi','aanya.joshi@example.com','hashed_password',7),(8,'Arjun','Malhotra','arjun.malhotra@example.com','hashed_password',8),(9,'Ishita','Sharma','ishita.sharma@example.com','hashed_password',14),(10,'Aryan','Srivastava','aryan.srivastava@example.com','hashed_password',15),(12,'Manan','Aggarwal','mananaggarwa123@gmail.com','manan123',41),(15,'Test',NULL,'test.test@test.com','pass',25),(16,'test','object','test@example.com','test123',26),(17,'Ayush','Singh','ayush5372@gmail.com','ayush1234',27),(18,'devanshi','dibbi','dibbibdia@gmail.com','dibbi',28);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `customer_BEFORE_INSERT` BEFORE INSERT ON `customer` FOR EACH ROW BEGIN
	DECLARE new_cart_id INT;
    INSERT INTO cart () VALUES ();
    SET new_cart_id = LAST_INSERT_ID();
    set NEW.cart = new_cart_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `stock` int NOT NULL,
  `price` float NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `category` int NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`),
  KEY `item_category_idx` (`category`),
  CONSTRAINT `item_category` FOREIGN KEY (`category`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,50,500,'Smartphone','smartphone.jpg',1),(2,100,29.99,'T-Shirt','tshirt.jpg',2),(3,74,149.99,'Sofa','sofa.jpg',3),(4,196,9.99,'Lipstick','lipstick.jpg',4),(5,29,24.99,'Book','book.jpg',5),(6,45,49.99,'Running Shoes','runningshoes.jpg',6),(7,80,199.99,'Laptop','laptop.jpg',1),(8,120,39.99,'Jeans','jeans.jpg',2),(9,60,99.99,'Coffee Table','coffeetable.jpg',3),(10,150,14.99,'Nail Polish','nailpolish.jpg',4),(11,40,29.99,'Notebook','notebook.jpg',5),(12,70,59.99,'Basketball Shoes','basketballshoes.jpg',6),(13,90,299.99,'Tablet','tablet.jpg',1),(14,80,34.99,'Hoodie','hoodie.jpg',2),(15,50,129.99,'Bed','bed.jpg',3),(16,179,12.99,'Mascara','mascara.jpg',4),(17,35,24.99,'Sketchbook','sketchbook.jpg',5),(18,60,69.99,'Soccer Cleats','soccercleats.jpg',6),(19,70,349.99,'Desktop Computer','desktop.jpg',1),(20,40,44.99,'Jacket','jacket.jpg',2),(21,25,199.99,'Dining Table','diningtable.jpg',3),(22,120,16.99,'Lip Gloss','lipgloss.jpg',4),(23,50,34.99,'Art Supplies Set','artsupplies.jpg',5),(24,80,79.99,'Football Cleats','footballcleats.jpg',6),(25,60,599.99,'Ultra HD TV','uhdtv.jpg',1),(26,90,49.99,'Sweater','sweater.jpg',2),(27,40,149.99,'Recliner Chair','reclinerchair.jpg',3),(28,160,11.99,'Eyeliner','eyeliner.jpg',4),(29,45,28.99,'Water Bottle','waterbottle.jpg',5),(30,75,89.99,'Golf Clubs Set','golfclubs.jpg',6),(31,80,799.99,'Gaming Console','gamingconsole.jpg',1),(32,50,39.99,'Polo Shirt','poloshirt.jpg',2),(33,35,169.99,'Couch','couch.jpg',3),(34,140,13.99,'Perfume','perfume.jpg',4),(35,55,26.99,'Backpack','backpack.jpg',5),(36,65,99.99,'Tennis Racket','tennisracket.jpg',6),(37,55,379.99,'Smartwatch','smartwatch.jpg',1),(38,95,19.99,'Polo T-Shirt','polotshirt.jpg',2),(39,45,199.99,'Chaise Lounge','chaiselounge.jpg',3),(40,110,8.99,'Nail File Set','nailfileset.jpg',4),(41,25,22.99,'Desk Organizer','deskorganizer.jpg',5),(42,70,54.99,'Basketball','basketball.jpg',6),(43,65,249.99,'Wireless Earbuds','wirelessearbuds.jpg',1),(44,75,29.99,'Casual Shirt','casualshirt.jpg',2),(45,30,179.99,'Bean Bag Chair','beanbagchair.jpg',3),(46,125,14.99,'Hand Cream','handcream.jpg',4),(47,40,26.99,'Desk Lamp','desklamp.jpg',5),(48,80,64.99,'Volleyball','volleyball.jpg',6),(49,50,449.99,'Bluetooth Speaker','bluetoothspeaker.jpg',1),(50,85,36.99,'Denim Jeans','denimjeans.jpg',2),(51,40,159.99,'Outdoor Swing','outdoorswing.jpg',3),(52,105,12.99,'Hair Brush Set','hairbrushset.jpg',4),(53,30,18.99,'Wall Clock','wallclock.jpg',5),(54,60,74.99,'Golf Balls Set','golfballs.jpg',6);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `status` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int NOT NULL,
  `address_id` int NOT NULL,
  `cart_id` int NOT NULL,
  `coupon_id` int DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `customer_transaction_idx` (`customer_id`),
  KEY `address_transaction_idx` (`address_id`),
  KEY `cart_transaction_idx` (`cart_id`),
  KEY `coupon_transaction_idx` (`coupon_id`),
  CONSTRAINT `address_transaction` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  CONSTRAINT `cart_transaction` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  CONSTRAINT `coupon_transaction` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`coupon_id`),
  CONSTRAINT `customer_transaction` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,1,'2024-02-12 15:01:30',1,1,1,1),(2,1,'2024-02-12 15:01:30',2,2,2,NULL),(3,1,'2024-02-12 15:01:30',3,3,3,2),(4,1,'2024-02-12 15:01:30',4,4,4,NULL),(5,1,'2024-02-12 15:01:30',5,5,5,3),(6,1,'2024-02-12 15:01:30',6,6,6,NULL),(7,1,'2024-02-12 15:01:30',7,7,7,4),(8,1,'2024-02-12 15:01:30',8,8,8,NULL),(9,1,'2024-02-12 15:01:30',9,9,9,5),(10,1,'2024-02-12 15:01:30',10,10,10,NULL),(11,1,'2024-02-12 15:03:30',1,1,1,1),(12,1,'2024-02-12 15:03:30',5,5,5,NULL),(13,1,'2024-02-12 15:03:30',6,6,6,NULL),(14,1,'2024-02-12 15:03:30',9,9,9,NULL),(15,1,'2024-02-12 15:03:30',10,10,10,NULL),(17,-1,'2024-03-31 05:15:21',12,31,22,NULL),(18,-1,'2024-03-31 05:15:56',12,31,30,NULL),(19,-1,'2024-03-31 05:16:33',12,29,31,NULL),(20,-1,'2024-03-31 05:17:00',12,29,32,NULL),(21,1,'2024-03-31 05:17:42',12,31,33,NULL),(22,1,'2024-03-31 05:20:12',12,31,34,1),(23,0,'2024-03-31 05:20:54',12,31,35,NULL),(24,1,'2024-03-31 05:21:08',12,31,36,NULL),(25,0,'2024-03-31 05:21:24',12,31,37,NULL),(26,1,'2024-03-31 13:11:35',12,32,38,NULL),(27,1,'2024-04-18 09:04:19',12,29,39,NULL),(28,1,'2024-04-20 13:41:05',12,31,40,NULL);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `transaction_AFTER_INSERT` AFTER INSERT ON `transaction` FOR EACH ROW BEGIN
	DECLARE new_cart_id INT;
    INSERT INTO cart () VALUES ();
    SET new_cart_id = LAST_INSERT_ID();
    UPDATE customer
		SET cart = new_cart_id
		WHERE customer_id = NEW.customer_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-20 19:19:36
