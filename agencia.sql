-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: agencia
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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `rut` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  PRIMARY KEY (`rut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadoasiento`
--

DROP TABLE IF EXISTS `estadoasiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadoasiento` (
  `id_estadoasiento` int NOT NULL,
  `situacion1` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_estadoasiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoasiento`
--

LOCK TABLES `estadoasiento` WRITE;
/*!40000 ALTER TABLE `estadoasiento` DISABLE KEYS */;
INSERT INTO `estadoasiento` VALUES (1,'Disponible'),(2,'Ocupado (Por Pagar)'),(3,'Ocupado (Pagado)');
/*!40000 ALTER TABLE `estadoasiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadoreserva`
--

DROP TABLE IF EXISTS `estadoreserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadoreserva` (
  `id_estadoreserva` int NOT NULL,
  `situacion2` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_estadoreserva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoreserva`
--

LOCK TABLES `estadoreserva` WRITE;
/*!40000 ALTER TABLE `estadoreserva` DISABLE KEYS */;
INSERT INTO `estadoreserva` VALUES (1,'Disponible'),(2,'Ocupado (Por Pagar)'),(3,'Ocupado (Pagado)');
/*!40000 ALTER TABLE `estadoreserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `id_reserva` int NOT NULL,
  `id_estadoasiento` int DEFAULT NULL,
  `id_estadoreserva` int DEFAULT NULL,
  `rut_cliente` int DEFAULT NULL,
  `id_vuelo` int DEFAULT NULL,
  `valor` int DEFAULT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `reserva_fk` (`rut_cliente`),
  KEY `reserva_fk2` (`id_vuelo`),
  KEY `reserva_fk3` (`id_estadoasiento`),
  KEY `reserva_fk4` (`id_estadoreserva`),
  CONSTRAINT `reserva_fk` FOREIGN KEY (`rut_cliente`) REFERENCES `cliente` (`rut`),
  CONSTRAINT `reserva_fk2` FOREIGN KEY (`id_vuelo`) REFERENCES `vuelo` (`id_vuelo`),
  CONSTRAINT `reserva_fk3` FOREIGN KEY (`id_estadoasiento`) REFERENCES `estadoasiento` (`id_estadoasiento`),
  CONSTRAINT `reserva_fk4` FOREIGN KEY (`id_estadoreserva`) REFERENCES `estadoreserva` (`id_estadoreserva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuelo`
--

DROP TABLE IF EXISTS `vuelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuelo` (
  `id_vuelo` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `ciudad_origen` varchar(50) DEFAULT NULL,
  `ciudad_destino` varchar(50) DEFAULT NULL,
  `hora` time DEFAULT NULL,
  PRIMARY KEY (`id_vuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuelo`
--

LOCK TABLES `vuelo` WRITE;
/*!40000 ALTER TABLE `vuelo` DISABLE KEYS */;
/*!40000 ALTER TABLE `vuelo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 22:37:38
