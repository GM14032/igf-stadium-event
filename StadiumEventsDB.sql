
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `StadiumEventsDB`
--
DROP DATABASE IF EXISTS StadiumEventsDB;
CREATE DATABASE StadiumEventsDB;
USE StadiumEventsDB;

-- --------------------------------------------------------

CREATE TABLE `asientos` (
  `id` int(11) NOT NULL,
  `numero` int(11) DEFAULT NULL,
  `fila` int(11) NOT NULL,
  `id_zona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `zonas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `capacidad` varchar(100) NOT NULL,
  `ubicacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `auditorio` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `ubicacion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `formato` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` int(11) NOT NULL,
  `id_auditorio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `zona_formato` (
  `id` int(11) NOT NULL,
  `id_zona` int(11) NOT NULL,
  `id_formato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `evento_zona` (
  `id` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `id_zona_formato` int(11) NOT NULL,
 `precio` decimal NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `dui` int(11) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `leido` tinyint(4) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_boleto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `evento` (
  `id` int(11) NOT NULL,
  `evento` varchar(200) NOT NULL,
  `fecha` date NOT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `id_evento_zona`  int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `boleto` (
  `id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `id_evento_formato` int(11) NOT NULL,
  `id_asiento` int(11) NOT NULL,
  `estado` boolean NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `clave` varchar(200) NOT NULL,
  `dui` varchar(10) DEFAULT NULL unique ,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL unique ,
  `id_tipo_usuario` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--


ALTER TABLE `asientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asientos_zonas_id_zona_fk` (`id_zona`);

ALTER TABLE `zonas`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `auditorio`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `formato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formato_auditorio_id_auditorio_fk` (`id_auditorio`);

ALTER TABLE `zona_formato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `zona_formato_id_zona_fk` (`id_zona`),
  ADD KEY `zona_formato_id_formato_fk` (`id_formato`);

ALTER TABLE `evento_zona`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evento_formato_id_evento_fk` (`id_evento`),
  ADD KEY `evento_formato_id_zona_formato_fk` (`id_zona_formato`);

ALTER TABLE `boleto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boleto_evento_id_evento_fk` (`id_evento_formato`),
     ADD KEY `boleto_asiento_id_evento_fk` (`id_asiento`);

ALTER TABLE `evento`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservas_boletos_id_boleto_fk` (`id_boleto`),
 ADD KEY `reservas_usuarios_id_usuario_fk` (`id_usuario`);

ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_tipo_usuario_id_tipo_usuario_fk` (`id_tipo_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

ALTER TABLE `asientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `zonas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `auditorio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `boleto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `evento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipo_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `formato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `zona_formato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `evento_zona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

ALTER TABLE `asientos`
  ADD CONSTRAINT `asientos_zonas_id_zona_fk` FOREIGN KEY (`id_zona`) REFERENCES `zonas` (`id`);

ALTER TABLE `boleto`
  ADD CONSTRAINT `boleto_evento_id_evento_fk` FOREIGN KEY (`id_evento_formato`) REFERENCES `evento` (`id`),
      ADD CONSTRAINT `boleto_asiento_id_evento_fk` FOREIGN KEY (`id_asiento`) REFERENCES `asientos` (`id`);

ALTER TABLE `reservas`
ADD CONSTRAINT `reservas_boletos_id_boleto_fk` FOREIGN KEY (`id_boleto`) REFERENCES `boleto` (`id`),
ADD CONSTRAINT `reservas_usuarios_id_usuario_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_tipo_usuario_id_tipo_usuario_fk` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuario` (`id`);

ALTER TABLE `formato`
  ADD CONSTRAINT `formato_auditorio_id_auditorio_fk` FOREIGN KEY (`id_auditorio`) REFERENCES `auditorio` (`id`);

ALTER TABLE `zona_formato`
ADD CONSTRAINT `zona_formato_id_formato_fk` FOREIGN KEY (`id_formato`) REFERENCES `formato` (`id`),
ADD CONSTRAINT `zona_formato_id_zona_fk` FOREIGN KEY (`id_zona`) REFERENCES `zonas` (`id`);

ALTER TABLE `evento_zona`
  ADD CONSTRAINT `evento_formato_id_evento_fk` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
    ADD CONSTRAINT `evento_formato_id_zona_formato_fk` FOREIGN KEY (`id_zona_formato`) REFERENCES `zona_formato` (`id`);



COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
