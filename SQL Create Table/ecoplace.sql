-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 12-08-2018 a las 16:09:46
-- Versión del servidor: 5.7.21
-- Versión de PHP: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ecoplace`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ecp_data`
--

DROP TABLE IF EXISTS `ecp_data`;
CREATE TABLE IF NOT EXISTS `ecp_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL,
  `Aire` decimal(10,0) NOT NULL,
  `Temperatura` decimal(10,0) NOT NULL,
  `Ruido` decimal(10,0) NOT NULL,
  `longitud` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `latitud` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `Lugar` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `id_device` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ephistoric`
--

DROP TABLE IF EXISTS `ephistoric`;
CREATE TABLE IF NOT EXISTS `ephistoric` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Aire` decimal(10,0) DEFAULT NULL,
  `Temperatura` decimal(10,0) DEFAULT NULL,
  `Ruido` decimal(10,0) DEFAULT NULL,
  `Longitud` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `Latitud` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `Lugar` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `id_dispositivo` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=772 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Disparadores `ephistoric`
--
DROP TRIGGER IF EXISTS `ephistoric`;
DELIMITER $$
CREATE TRIGGER `ephistoric` AFTER INSERT ON `ephistoric` FOR EACH ROW BEGIN
	IF NEW.id_dispositivo = 1 THEN  
        UPDATE `ecp_data` SET `id`= NEW.id,`fecha`= NEW.fecha,`Aire`= NEW.Aire,`Temperatura`= NEW.Temperatura,`Ruido`= NEW.Ruido,`longitud`= NEW.longitud,`latitud`= NEW.latitud,`Lugar`= NEW.Lugar,`id_device`= NEW.id_dispositivo WHERE `id_device`= NEW.id_dispositivo;
	END IF;
    
    IF NEW.id_dispositivo = 2 THEN  
        UPDATE `ecp_data` SET `id`= NEW.id,`fecha`= NEW.fecha,`Aire`= NEW.Aire,`Temperatura`= NEW.Temperatura,`Ruido`= NEW.Ruido,`longitud`= NEW.longitud,`latitud`= NEW.latitud,`Lugar`= NEW.Lugar,`id_device`= NEW.id_dispositivo WHERE `id_device`= NEW.id_dispositivo;
	END IF;
        
END
$$
DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
