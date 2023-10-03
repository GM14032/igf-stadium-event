
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

--
-- Estructura de tabla para la tabla `asientos`
--

CREATE TABLE `asientos` (
  `id` int(11) NOT NULL,
  `codigo` int(11) DEFAULT NULL,
  `fila` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `estado` int(11) DEFAULT 1,
  `id_auditorio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditorio`
--

CREATE TABLE `auditorio` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `ubicacion` varchar(200) NOT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `dui` int(11) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1,
  `leido` tinyint(4) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_boleto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id` int(11) NOT NULL,
  `evento` varchar(200) NOT NULL,
  `fecha` date NOT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `id_auditorio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento_boleto`
--

CREATE TABLE `boleto` (
  `id` int(11) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `precio` decimal(10,0) NOT NULL,
  `fecha` datetime NOT NULL,
  `cantidad` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `usuario` varchar(100) NOT NULL unique ,
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
-- Indices de la tabla `asientos`
--
ALTER TABLE `asientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asientos_auditorio_id_auditorio_fk` (`id_auditorio`);

--
-- Indices de la tabla `auditorio`
--
ALTER TABLE `auditorio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `boleto`
--
ALTER TABLE `boleto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boleto_evento_id:evento_fk` (`id_evento`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evento_auditorio_id_auditorio_fk` (`id_auditorio`);

--
-- Indices de la tabla `reservas`
--

ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservas_boletos_id_boleto_fk` (`id_boleto`),
 ADD KEY `reservas_usuarios_id_usuario_fk` (`id_usuario`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_tipo_usuario_id_tipo_usuario_fk` (`id_tipo_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asientos`
--
ALTER TABLE `asientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auditorio`
--
ALTER TABLE `auditorio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `boleto`
--
ALTER TABLE `boleto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asientos`
--
ALTER TABLE `asientos`
  ADD CONSTRAINT `asientos_auditorio_id_auditorio_fk` FOREIGN KEY (`id_auditorio`) REFERENCES `auditorio` (`id`);

--
-- Filtros para la tabla `boleto`
--
ALTER TABLE `boleto`
  ADD CONSTRAINT `boleto_evento_id_eventos_fk` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`);

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
  ADD CONSTRAINT `evento_auditorio_id_auditorio_fk` FOREIGN KEY (`id_auditorio`) REFERENCES `auditorio` (`id`);

--
-- Filtros para la tabla `reservas`
--

ALTER TABLE `reservas`
ADD CONSTRAINT `reservas_boletos_id_boleto_fk` FOREIGN KEY (`id_boleto`) REFERENCES `boleto` (`id`),
ADD CONSTRAINT `reservas_usuarios_id_usuario_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);
--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_tipo_usuario_id_tipo_usuario_fk` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
