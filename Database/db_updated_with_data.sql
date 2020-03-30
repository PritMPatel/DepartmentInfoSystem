CREATE DATABASE  IF NOT EXISTS `finalyearproject` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `finalyearproject`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: finalyearproject
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_master`
--

DROP TABLE IF EXISTS `admin_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `admin_master` (
  `adminID` int(11) NOT NULL AUTO_INCREMENT,
  `adminName` varchar(50) NOT NULL,
  `adminEmail` varchar(100) NOT NULL,
  `adminPassword` varchar(256) NOT NULL,
  `adminDepartment` int(11) NOT NULL,
  PRIMARY KEY (`adminID`),
  UNIQUE KEY `adminUsername_UNIQUE` (`adminEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_master`
--

LOCK TABLES `admin_master` WRITE;
/*!40000 ALTER TABLE `admin_master` DISABLE KEYS */;
INSERT INTO `admin_master` VALUES (1,'Prof. V. D. Patel','adminit@gmail.com','f3e79bfac8805b8c637d0f66b39b186e',16);
/*!40000 ALTER TABLE `admin_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attainment_co`
--

DROP TABLE IF EXISTS `attainment_co`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `attainment_co` (
  `attainCoID` int(11) NOT NULL AUTO_INCREMENT,
  `weighMarksPercent` float NOT NULL,
  `coAttainmentLevel` int(11) NOT NULL,
  `enrollmentno` varchar(12) NOT NULL,
  `subjectID` int(11) NOT NULL,
  `coID` int(11) NOT NULL,
  PRIMARY KEY (`attainCoID`),
  UNIQUE KEY `uc_e_co_sub` (`enrollmentno`,`subjectID`,`coID`),
  KEY `enrollmentno` (`enrollmentno`),
  KEY `subjectID` (`subjectID`),
  KEY `coID` (`coID`),
  CONSTRAINT `attainment_co_ibfk_1` FOREIGN KEY (`enrollmentno`) REFERENCES `student_master` (`enrollmentno`),
  CONSTRAINT `attainment_co_ibfk_2` FOREIGN KEY (`subjectID`) REFERENCES `subject_master` (`subjectID`),
  CONSTRAINT `attainment_co_ibfk_3` FOREIGN KEY (`coID`) REFERENCES `co_master` (`coID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attainment_co`
--

LOCK TABLES `attainment_co` WRITE;
/*!40000 ALTER TABLE `attainment_co` DISABLE KEYS */;
/*!40000 ALTER TABLE `attainment_co` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attainment_overall`
--

DROP TABLE IF EXISTS `attainment_overall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `attainment_overall` (
  `attainOverallID` int(11) NOT NULL AUTO_INCREMENT,
  `attainmentOverall` float NOT NULL,
  `enrollmentno` varchar(12) NOT NULL,
  `subjectID` int(11) NOT NULL,
  PRIMARY KEY (`attainOverallID`),
  UNIQUE KEY `uc_en_sub` (`enrollmentno`,`subjectID`),
  KEY `enrollmentno` (`enrollmentno`),
  KEY `subjectID` (`subjectID`),
  CONSTRAINT `attainment_overall_ibfk_1` FOREIGN KEY (`enrollmentno`) REFERENCES `student_master` (`enrollmentno`),
  CONSTRAINT `attainment_overall_ibfk_2` FOREIGN KEY (`subjectID`) REFERENCES `subject_master` (`subjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attainment_overall`
--

LOCK TABLES `attainment_overall` WRITE;
/*!40000 ALTER TABLE `attainment_overall` DISABLE KEYS */;
/*!40000 ALTER TABLE `attainment_overall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_master`
--

DROP TABLE IF EXISTS `co_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `co_master` (
  `coID` int(11) NOT NULL AUTO_INCREMENT,
  `coSrNo` int(2) NOT NULL DEFAULT '0',
  `coStatement` varchar(512) NOT NULL,
  `subjectID` int(11) NOT NULL,
  `facultyID` int(11) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`coID`),
  UNIQUE KEY `u_sr_sub_batch` (`coSrNo`,`subjectID`,`batch`),
  KEY `subjectID` (`subjectID`),
  KEY `co_master_ibfk_2_idx` (`facultyID`),
  CONSTRAINT `co_master_ibfk_1` FOREIGN KEY (`subjectID`) REFERENCES `subject_master` (`subjectID`),
  CONSTRAINT `co_master_ibfk_2` FOREIGN KEY (`facultyID`) REFERENCES `faculty_master` (`facultyID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_master`
--

LOCK TABLES `co_master` WRITE;
/*!40000 ALTER TABLE `co_master` DISABLE KEYS */;
INSERT INTO `co_master` VALUES (1,1,'This is CO1',1,1,2017),(2,2,'This is CO2',1,1,2017),(3,3,'This is CO3',1,1,2017),(4,4,'This is CO4',1,1,2017),(5,5,'This is CO5',1,1,2017);
/*!40000 ALTER TABLE `co_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_master`
--

DROP TABLE IF EXISTS `exam_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `exam_master` (
  `examID` int(11) NOT NULL AUTO_INCREMENT,
  `examName` varchar(128) NOT NULL DEFAULT 'Exam',
  `batch` int(11) NOT NULL,
  `totalMaxMarks` float NOT NULL,
  `weightage` float NOT NULL,
  `subjectID` int(11) NOT NULL,
  `examTypeID` int(11) NOT NULL,
  `facultyID` int(11) NOT NULL,
  PRIMARY KEY (`examID`),
  UNIQUE KEY `u_exam_sub_batch` (`examName`,`subjectID`,`batch`),
  KEY `subjectID` (`subjectID`),
  KEY `examTypeID` (`examTypeID`),
  KEY `exam_master_ibfk_3_idx` (`facultyID`),
  CONSTRAINT `exam_master_ibfk_1` FOREIGN KEY (`subjectID`) REFERENCES `subject_master` (`subjectID`),
  CONSTRAINT `exam_master_ibfk_2` FOREIGN KEY (`examTypeID`) REFERENCES `examtype_master` (`examTypeID`),
  CONSTRAINT `exam_master_ibfk_3` FOREIGN KEY (`facultyID`) REFERENCES `faculty_master` (`facultyID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_master`
--

LOCK TABLES `exam_master` WRITE;
/*!40000 ALTER TABLE `exam_master` DISABLE KEYS */;
INSERT INTO `exam_master` VALUES (1,'MSE CT2',2017,15,50,1,2,1),(2,'ASSIG-1',2017,10,50,1,2,1),(3,'ESE',2017,70,100,1,1,1),(4,'Practical',2017,100,100,1,4,1),(5,'CT1',2017,20,100,1,3,1);
/*!40000 ALTER TABLE `exam_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examtype_master`
--

DROP TABLE IF EXISTS `examtype_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `examtype_master` (
  `examTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `typeDescription` varchar(128) NOT NULL,
  `percentWeight` float NOT NULL,
  `subjectID` int(11) NOT NULL,
  `componentTotal` int(3) NOT NULL,
  PRIMARY KEY (`examTypeID`),
  KEY `subjectID` (`subjectID`),
  CONSTRAINT `examtype_master_ibfk_1` FOREIGN KEY (`subjectID`) REFERENCES `subject_master` (`subjectID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examtype_master`
--

LOCK TABLES `examtype_master` WRITE;
/*!40000 ALTER TABLE `examtype_master` DISABLE KEYS */;
INSERT INTO `examtype_master` VALUES (1,'ESE',0.45,1,70),(2,'PA(M)',0.2,1,30),(3,'PA(I)',0.15,1,20),(4,'ESE(V)-PR',0.2,1,30);
/*!40000 ALTER TABLE `examtype_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_master`
--

DROP TABLE IF EXISTS `faculty_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `faculty_master` (
  `facultyID` int(11) NOT NULL AUTO_INCREMENT,
  `facultyName` varchar(25) NOT NULL,
  `facultyEmail` varchar(50) NOT NULL,
  `facultyPassword` varchar(256) NOT NULL,
  `facultyDepartment` int(11) NOT NULL,
  PRIMARY KEY (`facultyID`),
  UNIQUE KEY `facultyEmail_UNIQUE` (`facultyEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_master`
--

LOCK TABLES `faculty_master` WRITE;
/*!40000 ALTER TABLE `faculty_master` DISABLE KEYS */;
INSERT INTO `faculty_master` VALUES (1,'SJM','sjm@gmail.com','2431dd378df9c754e0245efd8fbf2aab',16);
/*!40000 ALTER TABLE `faculty_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marks_obtained_master`
--

DROP TABLE IF EXISTS `marks_obtained_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `marks_obtained_master` (
  `marksID` int(11) NOT NULL AUTO_INCREMENT,
  `obtainedMarks` int(11) NOT NULL,
  `calcObtainedMarks` float NOT NULL,
  `nCalcObtainedMarks` float NOT NULL DEFAULT '0',
  `enrollmentno` varchar(12) NOT NULL,
  `questionID` int(11) NOT NULL,
  PRIMARY KEY (`marksID`),
  KEY `enrollmentno` (`enrollmentno`),
  KEY `marks_obtained_master_ibfk_1_idx` (`questionID`),
  CONSTRAINT `marks_obtained_master_ibfk_1` FOREIGN KEY (`questionID`) REFERENCES `question_master` (`questionID`),
  CONSTRAINT `marks_obtained_master_ibfk_2` FOREIGN KEY (`enrollmentno`) REFERENCES `student_master` (`enrollmentno`)
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marks_obtained_master`
--

LOCK TABLES `marks_obtained_master` WRITE;
/*!40000 ALTER TABLE `marks_obtained_master` DISABLE KEYS */;
INSERT INTO `marks_obtained_master` VALUES (1,3,10,2,'170170116001',1),(2,2,7.5,1.5,'170170116001',2),(3,2,7.5,1.5,'170170116001',3),(4,2,7.5,1.5,'170170116001',4),(5,2,7.5,1.5,'170170116002',1),(6,2,5,1,'170170116002',2),(7,3,10,2,'170170116002',3),(8,5,15,3,'170170116002',4),(9,2,7.5,1.5,'170170116003',1),(10,2,5,1,'170170116003',2),(11,3,10,2,'170170116003',3),(12,4,12.5,2.5,'170170116003',4),(13,1,2.5,0.5,'170170116004',1),(14,1,2.5,0.5,'170170116004',2),(15,3,10,2,'170170116004',3),(16,1,2.5,0.5,'170170116004',4),(17,1,2.5,0.5,'170170116005',1),(18,1,2.5,0.5,'170170116005',2),(19,1,2.5,0.5,'170170116005',3),(20,0,0,0,'170170116005',4),(21,3,10,2,'170170116007',1),(22,3,10,2,'170170116007',2),(23,0,0,0,'170170116007',3),(24,3,10,2,'170170116007',4),(25,3,10,2,'170170116008',1),(26,2,5,1,'170170116008',2),(27,3,10,2,'170170116008',3),(28,5,17.5,3.5,'170170116008',4),(29,2,5,1,'170170116009',1),(30,1,2.5,0.5,'170170116009',2),(31,3,10,2,'170170116009',3),(32,3,10,2,'170170116009',4),(33,2,7.5,1.5,'170170116010',1),(34,2,5,1,'170170116010',2),(35,2,7.5,1.5,'170170116010',3),(36,2,7.5,1.5,'170170116010',4),(37,2,7.5,1.5,'170170116011',1),(38,2,7.5,1.5,'170170116011',2),(39,3,10,2,'170170116011',3),(40,5,17.5,3.5,'170170116011',4),(41,4,20,4,'170170116001',5),(42,4,20,4,'170170116001',6),(43,3,15,3,'170170116002',5),(44,3,15,3,'170170116002',6),(45,5,22.5,4.5,'170170116003',5),(46,5,22.5,4.5,'170170116003',6),(47,4,17.5,3.5,'170170116004',5),(48,4,17.5,3.5,'170170116004',6),(49,3,15,3,'170170116005',5),(50,3,15,3,'170170116005',6),(51,5,25,5,'170170116007',5),(52,5,25,5,'170170116007',6),(53,5,25,5,'170170116008',5),(54,5,25,5,'170170116008',6),(55,4,20,4,'170170116009',5),(56,4,20,4,'170170116009',6),(57,2,10,2,'170170116010',5),(58,2,10,2,'170170116010',6),(59,5,25,5,'170170116011',5),(60,5,25,5,'170170116011',6),(111,5,5,1,'170170116001',12),(112,6,6,1.2,'170170116001',13),(113,7,7,1.4,'170170116001',14),(114,5,5,1,'170170116001',15),(115,6,6,1.2,'170170116001',16),(116,7,7,1.4,'170170116001',17),(117,7,7,1.4,'170170116001',18),(118,6,6,1.2,'170170116001',19),(119,5,5,1,'170170116001',20),(120,6,3,0.6,'170170116001',21),(121,6,6,1.2,'170170116002',12),(122,7,7,1.4,'170170116002',13),(123,8,8,1.6,'170170116002',14),(124,8,8,1.6,'170170116002',15),(125,7,7,1.4,'170170116002',16),(126,6,6,1.2,'170170116002',17),(127,6,6,1.2,'170170116002',18),(128,7,7,1.4,'170170116002',19),(129,8,8,1.6,'170170116002',20),(130,7,3.5,0.7,'170170116002',21),(131,7,7,1.4,'170170116003',12),(132,6,6,1.2,'170170116003',13),(133,8,8,1.6,'170170116003',14),(134,6,6,1.2,'170170116003',15),(135,7,7,1.4,'170170116003',16),(136,8,8,1.6,'170170116003',17),(137,7,7,1.4,'170170116003',18),(138,7,7,1.4,'170170116003',19),(139,7,7,1.4,'170170116003',20),(140,7,3.5,0.7,'170170116003',21),(141,6,6,1.2,'170170116004',12),(142,6,6,1.2,'170170116004',13),(143,7,7,1.4,'170170116004',14),(144,7,7,1.4,'170170116004',15),(145,8,8,1.6,'170170116004',16),(146,8,8,1.6,'170170116004',17),(147,6,6,1.2,'170170116004',18),(148,7,7,1.4,'170170116004',19),(149,8,8,1.6,'170170116004',20),(150,7,3.5,0.7,'170170116004',21),(151,6,6,1.2,'170170116005',12),(152,5,5,1,'170170116005',13),(153,7,7,1.4,'170170116005',14),(154,7,7,1.4,'170170116005',15),(155,6,6,1.2,'170170116005',16),(156,5,5,1,'170170116005',17),(157,6,6,1.2,'170170116005',18),(158,6,6,1.2,'170170116005',19),(159,7,7,1.4,'170170116005',20),(160,5,2.5,0.5,'170170116005',21),(161,6,6,1.2,'170170116007',12),(162,5,5,1,'170170116007',13),(163,7,7,1.4,'170170116007',14),(164,5,5,1,'170170116007',15),(165,6,6,1.2,'170170116007',16),(166,7,7,1.4,'170170116007',17),(167,7,7,1.4,'170170116007',18),(168,7,7,1.4,'170170116007',19),(169,5,5,1,'170170116007',20),(170,5,2.5,0.5,'170170116007',21),(171,8,8,1.6,'170170116008',12),(172,9,9,1.8,'170170116008',13),(173,10,10,2,'170170116008',14),(174,9,9,1.8,'170170116008',15),(175,9,9,1.8,'170170116008',16),(176,9,9,1.8,'170170116008',17),(177,8,8,1.6,'170170116008',18),(178,8,8,1.6,'170170116008',19),(179,10,10,2,'170170116008',20),(180,10,5,1,'170170116008',21),(181,8,8,1.6,'170170116009',12),(182,8,8,1.6,'170170116009',13),(183,9,9,1.8,'170170116009',14),(184,9,9,1.8,'170170116009',15),(185,7,7,1.4,'170170116009',16),(186,7,7,1.4,'170170116009',17),(187,6,6,1.2,'170170116009',18),(188,6,6,1.2,'170170116009',19),(189,10,10,2,'170170116009',20),(190,10,5,1,'170170116009',21),(191,8,8,1.6,'170170116010',12),(192,9,9,1.8,'170170116010',13),(193,9,9,1.8,'170170116010',14),(194,8,8,1.6,'170170116010',15),(195,7,7,1.4,'170170116010',16),(196,7,7,1.4,'170170116010',17),(197,6,6,1.2,'170170116010',18),(198,10,10,2,'170170116010',19),(199,7,7,1.4,'170170116010',20),(200,9,4.5,0.9,'170170116010',21),(201,7,7,1.4,'170170116011',12),(202,8,8,1.6,'170170116011',13),(203,9,9,1.8,'170170116011',14),(204,10,10,2,'170170116011',15),(205,9,9,1.8,'170170116011',16),(206,9,9,1.8,'170170116011',17),(207,10,10,2,'170170116011',18),(208,9,9,1.8,'170170116011',19),(209,9,9,1.8,'170170116011',20),(210,10,5,1,'170170116011',21),(211,0,0,0,'170170116001',22),(212,3,15,2.25,'170170116001',23),(213,4,20,3,'170170116001',24),(214,2,10,1.5,'170170116002',22),(215,2,10,1.5,'170170116002',23),(216,6,30,4.5,'170170116002',24),(217,2,10,1.5,'170170116003',22),(218,1,5,0.75,'170170116003',23),(219,10,50,7.5,'170170116003',24),(220,2,10,1.5,'170170116004',22),(221,3,15,2.25,'170170116004',23),(222,5,25,3.75,'170170116004',24),(223,0,0,0,'170170116005',22),(224,2,10,1.5,'170170116005',23),(225,5,25,3.75,'170170116005',24),(226,0,0,0,'170170116007',22),(227,2,10,1.5,'170170116007',23),(228,5,25,3.75,'170170116007',24),(229,2,10,1.5,'170170116008',22),(230,3,15,2.25,'170170116008',23),(231,10,50,7.5,'170170116008',24),(232,1,5,0.75,'170170116009',22),(233,3,15,2.25,'170170116009',23),(234,6,30,4.5,'170170116009',24),(235,1,5,0.75,'170170116010',22),(236,0,0,0,'170170116010',23),(237,2,10,1.5,'170170116010',24),(238,2,10,1.5,'170170116011',22),(239,3,15,2.25,'170170116011',23),(240,3,15,2.25,'170170116011',24),(241,8,12,5.4,'170170116001',7),(242,18,25,11.25,'170170116001',8),(243,2,3,1.35,'170170116001',9),(244,13,18,8.09998,'170170116001',10),(245,8,12,5.4,'170170116001',11),(246,4,6.34287,2.85429,'170170116002',7),(247,9,13.2143,5.94642,'170170116002',8),(248,1,1.58571,0.713571,'170170116002',9),(249,7,9.51429,4.28142,'170170116002',10),(250,4,6.34287,2.85429,'170170116002',11),(251,7,10.2857,4.62857,'170170116003',7),(252,15,21.4286,9.64284,'170170116003',8),(253,2,2.57143,1.15714,'170170116003',9),(254,11,15.4286,6.94284,'170170116003',10),(255,7,10.2857,4.62857,'170170116003',11),(256,5,7.20002,3.24,'170170116004',7),(257,11,15,6.74999,'170170116004',8),(258,1,1.8,0.809999,'170170116004',9),(259,8,10.8,4.85999,'170170116004',10),(260,5,7.20002,3.24,'170170116004',11),(261,4,6.34287,2.85429,'170170116005',7),(262,9,13.2143,5.94642,'170170116005',8),(263,1,1.58571,0.713571,'170170116005',9),(264,7,9.51429,4.28142,'170170116005',10),(265,4,6.34287,2.85429,'170170116005',11),(266,7,10.2857,4.62857,'170170116007',7),(267,15,21.4286,9.64284,'170170116007',8),(268,2,2.57143,1.15714,'170170116007',9),(269,11,15.4286,6.94284,'170170116007',10),(270,7,10.2857,4.62857,'170170116007',11),(271,8,12,5.4,'170170116008',7),(272,18,25,11.25,'170170116008',8),(273,2,3,1.35,'170170116008',9),(274,13,18,8.09998,'170170116008',10),(275,8,12,5.4,'170170116008',11),(276,7,10.2857,4.62857,'170170116009',7),(277,15,21.4286,9.64284,'170170116009',8),(278,2,2.57143,1.15714,'170170116009',9),(279,11,15.4286,6.94284,'170170116009',10),(280,7,10.2857,4.62857,'170170116009',11),(281,4,6.34287,2.85429,'170170116010',7),(282,9,13.2143,5.94642,'170170116010',8),(283,1,1.58571,0.713571,'170170116010',9),(284,7,9.51429,4.28142,'170170116010',10),(285,4,6.34287,2.85429,'170170116010',11),(286,4,6.34287,2.85429,'170170116011',7),(287,9,13.2143,5.94642,'170170116011',8),(288,1,1.58571,0.713571,'170170116011',9),(289,7,9.51429,4.28142,'170170116011',10),(290,4,6.34287,2.85429,'170170116011',11);
/*!40000 ALTER TABLE `marks_obtained_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_master`
--

DROP TABLE IF EXISTS `question_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `question_master` (
  `questionID` int(11) NOT NULL AUTO_INCREMENT,
  `queDesc` varchar(128) NOT NULL,
  `queMaxMarks` float NOT NULL,
  `multipleMap` int(2) NOT NULL,
  `calcQuesMaxMarks` float NOT NULL,
  `nCalcQuesMaxMarks` float NOT NULL,
  `examID` int(11) NOT NULL,
  `coID1` int(11) NOT NULL,
  `coID2` int(11) DEFAULT NULL,
  `coID3` int(11) DEFAULT NULL,
  `coID4` int(11) DEFAULT NULL,
  `coID5` int(11) DEFAULT NULL,
  `coID6` int(11) DEFAULT NULL,
  `coID7` int(11) DEFAULT NULL,
  PRIMARY KEY (`questionID`),
  KEY `question_master_ibfk_1_idx` (`examID`),
  KEY `coID` (`coID1`,`coID2`,`coID3`,`coID4`,`coID5`,`coID6`,`coID7`),
  KEY `2_idx` (`coID2`),
  KEY `3_idx` (`coID3`),
  KEY `4_idx` (`coID4`),
  KEY `5_idx` (`coID5`),
  KEY `6_idx` (`coID6`),
  KEY `7_idx` (`coID7`),
  CONSTRAINT `1` FOREIGN KEY (`coID1`) REFERENCES `co_master` (`coID`),
  CONSTRAINT `2` FOREIGN KEY (`coID2`) REFERENCES `co_master` (`coID`),
  CONSTRAINT `3` FOREIGN KEY (`coID3`) REFERENCES `co_master` (`coID`),
  CONSTRAINT `4` FOREIGN KEY (`coID4`) REFERENCES `co_master` (`coID`),
  CONSTRAINT `5` FOREIGN KEY (`coID5`) REFERENCES `co_master` (`coID`),
  CONSTRAINT `6` FOREIGN KEY (`coID6`) REFERENCES `co_master` (`coID`),
  CONSTRAINT `7` FOREIGN KEY (`coID7`) REFERENCES `co_master` (`coID`),
  CONSTRAINT `question_master_ibfk_1` FOREIGN KEY (`examID`) REFERENCES `exam_master` (`examID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_master`
--

LOCK TABLES `question_master` WRITE;
/*!40000 ALTER TABLE `question_master` DISABLE KEYS */;
INSERT INTO `question_master` VALUES (1,'Q1',3,1,10,2,1,2,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Q2',3,1,10,2,1,3,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Q3',3,1,10,2,1,3,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Q4',6,1,20,4,1,4,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Q1',5,1,25,5,2,2,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Q2',5,1,25,5,2,3,NULL,NULL,NULL,NULL,NULL,NULL),(7,'Q1',12,1,17.1429,7.71429,3,1,NULL,NULL,NULL,NULL,NULL,NULL),(8,'Q2',25,1,35.7143,16.0714,3,2,NULL,NULL,NULL,NULL,NULL,NULL),(9,'Q3',3,1,4.28571,1.92857,3,3,NULL,NULL,NULL,NULL,NULL,NULL),(10,'Q4',18,1,25.7143,11.5714,3,4,NULL,NULL,NULL,NULL,NULL,NULL),(11,'Q5',12,1,17.1429,7.71429,3,5,NULL,NULL,NULL,NULL,NULL,NULL),(12,'P1',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(13,'P2',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(14,'P3',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(15,'P4',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(16,'P5',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(17,'P6',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(18,'P7',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(19,'P8',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(20,'P9',10,1,10,2,4,2,NULL,NULL,NULL,NULL,NULL,NULL),(21,'P10',10,2,5,1,4,4,5,NULL,NULL,NULL,NULL,NULL),(22,'Q1',2,1,10,1.5,5,1,NULL,NULL,NULL,NULL,NULL,NULL),(23,'Q2',3,1,15,2.25,5,2,NULL,NULL,NULL,NULL,NULL,NULL),(24,'Q3',15,1,75,11.25,5,2,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `question_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_master`
--

DROP TABLE IF EXISTS `student_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `student_master` (
  `enrollmentno` varchar(12) NOT NULL,
  `batch` int(11) NOT NULL,
  `studentDepartment` int(11) NOT NULL,
  PRIMARY KEY (`enrollmentno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_master`
--

LOCK TABLES `student_master` WRITE;
/*!40000 ALTER TABLE `student_master` DISABLE KEYS */;
INSERT INTO `student_master` VALUES ('170170116001',2017,16),('170170116002',2017,16),('170170116003',2017,16),('170170116004',2017,16),('170170116005',2017,16),('170170116007',2017,16),('170170116008',2017,16),('170170116009',2017,16),('170170116010',2017,16),('170170116011',2017,16);
/*!40000 ALTER TABLE `student_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_master`
--

DROP TABLE IF EXISTS `subject_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `subject_master` (
  `subjectID` int(11) NOT NULL AUTO_INCREMENT,
  `subjectName` varchar(50) NOT NULL,
  `subjectCode` decimal(7,0) NOT NULL,
  `semester` int(11) NOT NULL,
  `subjectDepartment` int(11) NOT NULL,
  PRIMARY KEY (`subjectID`),
  UNIQUE KEY `subjectCode` (`subjectCode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_master`
--

LOCK TABLES `subject_master` WRITE;
/*!40000 ALTER TABLE `subject_master` DISABLE KEYS */;
INSERT INTO `subject_master` VALUES (1,'DBMS',2130703,3,16);
/*!40000 ALTER TABLE `subject_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-30  0:59:47
