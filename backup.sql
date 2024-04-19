CREATE DATABASE  IF NOT EXISTS `sistema_academia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sistema_academia`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema_academia
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `aluno_planos`
--

DROP TABLE IF EXISTS `aluno_planos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aluno_planos` (
  `id_aluno_plano` int NOT NULL AUTO_INCREMENT,
  `id_aluno` int DEFAULT NULL,
  `id_plano` int DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `dados_cartao_credito` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_aluno_plano`),
  KEY `id_plano` (`id_plano`),
  KEY `aluno_planos_ibfk_1` (`id_aluno`),
  CONSTRAINT `aluno_planos_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id_aluno`) ON DELETE CASCADE,
  CONSTRAINT `aluno_planos_ibfk_2` FOREIGN KEY (`id_plano`) REFERENCES `planos` (`id_plano`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno_planos`
--

LOCK TABLES `aluno_planos` WRITE;
/*!40000 ALTER TABLE `aluno_planos` DISABLE KEYS */;
/*!40000 ALTER TABLE `aluno_planos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `id_aluno` int NOT NULL AUTO_INCREMENT,
  `cpf` varchar(11) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  PRIMARY KEY (`id_aluno`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (3,'169\'','Lucas Hesse Block','2005-03-16'),(5,'12345','Luan','2000-01-01'),(6,'0349121','Valter Block','1999-02-20'),(7,'02913013031','Brenda Mossatte','2002-03-03'),(8,'02453199056','Lucas Both Steinmetz','2005-02-05'),(9,'01231224','BRENDA LINDA PERFEITA','2000-01-01'),(10,'1','Lukinhas Adora CU','6969-01-01');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alunos_exercicios_info`
--

DROP TABLE IF EXISTS `alunos_exercicios_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos_exercicios_info` (
  `id_alunos_exercicios_info` int NOT NULL AUTO_INCREMENT,
  `id_data` int DEFAULT NULL,
  `id_aluno` int DEFAULT NULL,
  `id_exercicio` int DEFAULT NULL,
  `series` int DEFAULT NULL,
  `repeticoes` int DEFAULT NULL,
  `peso` int DEFAULT NULL,
  `TEMPO_DESCANSO` int DEFAULT NULL,
  `concluido` tinyint DEFAULT '0',
  PRIMARY KEY (`id_alunos_exercicios_info`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos_exercicios_info`
--

LOCK TABLES `alunos_exercicios_info` WRITE;
/*!40000 ALTER TABLE `alunos_exercicios_info` DISABLE KEYS */;
INSERT INTO `alunos_exercicios_info` VALUES (31,25,5,1,3,1,2,NULL,0),(32,25,5,10,3,3,4,NULL,0),(35,27,5,1,3,1,2,NULL,0),(36,27,5,10,3,3,4,NULL,0),(37,28,5,1,3,1,2,NULL,0),(38,28,5,10,3,3,4,NULL,0),(39,29,5,1,3,1,2,NULL,0),(40,29,5,10,3,3,4,NULL,0),(41,30,5,1,3,1,2,NULL,0),(42,30,5,10,3,3,4,NULL,0),(43,31,5,1,3,1,2,NULL,0),(44,31,5,10,3,3,4,NULL,0),(45,32,5,1,3,1,2,NULL,0),(46,32,5,10,3,3,4,NULL,0),(47,33,5,1,3,1,2,NULL,0),(48,33,5,10,3,3,4,NULL,0),(49,34,5,1,3,1,2,NULL,0),(50,34,5,10,3,3,4,NULL,0),(51,35,5,1,3,1,2,NULL,0),(52,35,5,10,3,3,4,NULL,0),(53,36,5,1,3,1,2,NULL,0),(54,36,5,10,69,3,4,0,0),(55,37,5,1,3,1,2,NULL,0),(56,37,5,10,69,3,4,NULL,0),(57,38,5,1,3,1,10,0,0),(58,38,5,10,69,3,4,NULL,0),(59,39,5,1,3,1,10,NULL,0),(60,39,5,10,69,3,4,NULL,0),(61,40,10,1,3,12,20,NULL,0),(62,40,10,10,3,12,15,NULL,0),(63,41,10,1,3,12,20,NULL,0),(64,41,10,10,3,12,15,NULL,0),(65,42,10,1,3,12,20,NULL,0),(66,42,10,10,3,12,10000,0,0),(67,43,10,1,3,12,20,NULL,0),(68,43,10,10,3,12,10000,NULL,0),(69,44,5,1,3,1,10,NULL,0),(70,44,5,10,69,3,4,NULL,0),(71,45,10,1,3,12,20,NULL,0),(72,45,10,10,3,12,10000,NULL,0),(73,46,10,1,3,12,20,NULL,1),(74,46,10,10,3,12,10000,NULL,0),(75,47,10,1,3,12,20,NULL,1),(76,47,10,10,3,12,10000,NULL,0),(77,48,10,1,3,12,20,NULL,1),(78,48,10,10,22,12,10000,0,1);
/*!40000 ALTER TABLE `alunos_exercicios_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercicios`
--

DROP TABLE IF EXISTS `exercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercicios` (
  `id_exercicio` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `repeticoes` int DEFAULT NULL,
  `series` int DEFAULT NULL,
  `peso` int DEFAULT NULL,
  PRIMARY KEY (`id_exercicio`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercicios`
--

LOCK TABLES `exercicios` WRITE;
/*!40000 ALTER TABLE `exercicios` DISABLE KEYS */;
INSERT INTO `exercicios` VALUES (1,'supino',12,3,20),(6,'Agachamento',10,4,40),(7,'Rosquinha',NULL,NULL,NULL),(8,'Desinvolvimento',NULL,NULL,NULL),(9,'Stif',20,NULL,4),(10,'Francis',12,3,15);
/*!40000 ALTER TABLE `exercicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musculos`
--

DROP TABLE IF EXISTS `musculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `musculos` (
  `id_musculo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_musculo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musculos`
--

LOCK TABLES `musculos` WRITE;
/*!40000 ALTER TABLE `musculos` DISABLE KEYS */;
INSERT INTO `musculos` VALUES (1,'peito'),(2,'triceps'),(3,'costas'),(4,'biceps'),(5,'quadriceps'),(6,'gluteo'),(7,'bochecha'),(8,'posterior');
/*!40000 ALTER TABLE `musculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musculos_exercicio`
--

DROP TABLE IF EXISTS `musculos_exercicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `musculos_exercicio` (
  `id_musculo_exercicio` int NOT NULL AUTO_INCREMENT,
  `id_exercicio` int DEFAULT NULL,
  `id_musculo` int DEFAULT NULL,
  PRIMARY KEY (`id_musculo_exercicio`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musculos_exercicio`
--

LOCK TABLES `musculos_exercicio` WRITE;
/*!40000 ALTER TABLE `musculos_exercicio` DISABLE KEYS */;
INSERT INTO `musculos_exercicio` VALUES (1,0,0),(2,0,0),(10,6,6),(12,7,4),(13,8,6),(14,9,5),(15,9,6),(16,10,2);
/*!40000 ALTER TABLE `musculos_exercicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planos`
--

DROP TABLE IF EXISTS `planos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planos` (
  `id_plano` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `valor_mensal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_plano`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planos`
--

LOCK TABLES `planos` WRITE;
/*!40000 ALTER TABLE `planos` DISABLE KEYS */;
INSERT INTO `planos` VALUES (2,'padrao',89.90),(3,'Super plano',10000.00);
/*!40000 ALTER TABLE `planos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treino_exercicios`
--

DROP TABLE IF EXISTS `treino_exercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treino_exercicios` (
  `id_treino_exercicios` int NOT NULL AUTO_INCREMENT,
  `id_treino` int DEFAULT NULL,
  `id_exercicio` int DEFAULT NULL,
  PRIMARY KEY (`id_treino_exercicios`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treino_exercicios`
--

LOCK TABLES `treino_exercicios` WRITE;
/*!40000 ALTER TABLE `treino_exercicios` DISABLE KEYS */;
INSERT INTO `treino_exercicios` VALUES (1,0,1),(2,0,6),(3,0,6),(4,7,1),(5,7,6),(6,9,1),(7,9,10);
/*!40000 ALTER TABLE `treino_exercicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treinos`
--

DROP TABLE IF EXISTS `treinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treinos` (
  `id_treino` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_treino`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treinos`
--

LOCK TABLES `treinos` WRITE;
/*!40000 ALTER TABLE `treinos` DISABLE KEYS */;
INSERT INTO `treinos` VALUES (1,'ABC'),(2,'ABC'),(3,'ABC'),(4,'Costas A'),(5,'Peito'),(6,'A'),(7,'B'),(8,'BOB');
/*!40000 ALTER TABLE `treinos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treinos_data`
--

DROP TABLE IF EXISTS `treinos_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treinos_data` (
  `id_treinos_data` int NOT NULL AUTO_INCREMENT,
  `id_aluno` int DEFAULT NULL,
  `id_treino` int DEFAULT NULL,
  `data_inicio` datetime DEFAULT NULL,
  `data_final` datetime DEFAULT NULL,
  PRIMARY KEY (`id_treinos_data`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treinos_data`
--

LOCK TABLES `treinos_data` WRITE;
/*!40000 ALTER TABLE `treinos_data` DISABLE KEYS */;
INSERT INTO `treinos_data` VALUES (1,5,8,'2021-04-06 20:40:23',NULL),(2,5,8,'2022-04-10 20:05:57',NULL),(3,5,8,'2022-04-10 20:12:24',NULL),(4,5,7,'2024-04-10 20:33:02',NULL),(5,5,1,'2024-04-10 20:37:43',NULL),(6,5,1,'2024-04-10 20:42:41','2024-04-10 20:42:44'),(7,5,8,'2024-04-11 22:47:50','2024-04-11 22:47:59'),(8,5,7,'2024-04-11 22:59:21',NULL),(9,5,7,'2024-04-11 23:01:06',NULL),(10,5,7,'2024-04-11 23:01:53','2024-04-11 23:02:47'),(11,5,7,'2024-04-12 15:50:13','2024-04-12 15:50:44'),(12,5,7,'2024-04-13 19:53:51',NULL),(13,5,7,'2024-04-13 20:16:33',NULL),(14,5,7,'2024-04-14 15:30:37','2024-04-14 15:30:41'),(15,5,7,'2024-04-14 16:35:41','2024-04-14 16:36:02'),(16,5,9,'2024-04-14 16:37:19',NULL),(17,5,9,'2024-04-14 18:30:43',NULL),(18,5,9,'2024-04-14 18:31:38',NULL),(19,5,7,'2024-04-14 18:42:33',NULL),(20,5,9,'2024-04-14 18:45:08',NULL),(21,5,9,'2024-04-14 18:53:14',NULL),(22,5,9,'2024-04-14 18:55:51',NULL),(23,5,9,'2024-04-14 18:59:54',NULL),(24,5,9,'2024-04-15 11:21:30',NULL),(25,5,9,'2024-04-15 11:25:15','2024-04-15 11:25:17'),(26,5,9,'2024-04-15 11:25:52','2024-04-15 11:26:03'),(27,5,9,'2024-04-15 11:33:32',NULL),(28,5,9,'2024-04-15 11:42:29',NULL),(29,5,9,'2024-04-15 11:43:56',NULL),(30,5,9,'2024-04-15 11:45:20',NULL),(31,5,9,'2024-04-15 11:52:09',NULL),(32,5,9,'2024-04-15 11:54:58',NULL),(33,5,9,'2024-04-15 11:57:10',NULL),(34,5,9,'2024-04-15 11:59:21',NULL),(35,5,9,'2024-04-15 12:00:40',NULL),(36,5,9,'2024-04-15 12:20:07','2024-04-15 12:20:27'),(37,5,9,'2024-04-15 12:20:35','2024-04-15 12:20:42'),(38,5,9,'2024-04-15 12:53:26','2024-04-15 12:53:51'),(39,5,9,'2024-04-15 14:24:10','2024-04-15 14:24:12'),(40,10,9,'2024-04-15 15:06:26','2024-04-15 15:06:37'),(41,10,9,'2024-04-15 15:06:50',NULL),(42,10,9,'2024-04-15 15:07:23','2024-04-15 15:07:34'),(43,10,9,'2024-04-15 18:12:42',NULL),(44,5,9,'2024-04-15 18:22:01',NULL),(45,10,9,'2024-04-15 18:32:02',NULL),(46,10,9,'2024-04-15 18:33:58',NULL),(47,10,9,'2024-04-15 23:19:21',NULL),(48,10,9,'2024-04-15 23:21:23','2024-04-15 23:23:03');
/*!40000 ALTER TABLE `treinos_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-16  1:30:29
