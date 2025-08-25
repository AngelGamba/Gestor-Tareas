-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-08-2025 a las 23:55:53
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestor_tareas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `leida` tinyint(1) DEFAULT 0,
  `id_usuario_destino` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20250825174718-create-user.cjs'),
('20250825174815-create-task.cjs');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id_tarea` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` enum('pendiente','en progreso','completada') DEFAULT 'pendiente',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_vencimiento` date DEFAULT NULL,
  `id_usuario_creador` int(11) DEFAULT NULL,
  `id_usuario_asignado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tasks`
--

CREATE TABLE `tasks` (
  `id_tarea` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` enum('pendiente','en progreso','completada') DEFAULT 'pendiente',
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_usuario_creador` int(11) DEFAULT NULL,
  `id_usuario_asignado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tasks`
--

INSERT INTO `tasks` (`id_tarea`, `titulo`, `descripcion`, `estado`, `fecha_creacion`, `fecha_vencimiento`, `createdAt`, `updatedAt`, `id_usuario_creador`, `id_usuario_asignado`) VALUES
(1, 'PrimerTarea', 'Primera', 'pendiente', '2025-08-25 21:10:39', '2025-08-28 00:00:00', '2025-08-25 21:10:39', '2025-08-25 21:10:39', 1, NULL),
(2, 'SegundaTarea', 'Segunda', 'pendiente', '2025-08-25 21:11:16', '2025-08-28 00:00:00', '2025-08-25 21:11:16', '2025-08-25 21:11:16', 1, NULL),
(3, 'TercerTarea', 'Tercera', 'pendiente', '2025-08-25 21:14:19', '2025-08-30 00:00:00', '2025-08-25 21:14:19', '2025-08-25 21:49:15', 1, 2),
(4, 'CuartaTarea', 'Cuarta', 'pendiente', '2025-08-25 21:26:31', '2025-08-29 00:00:00', '2025-08-25 21:26:31', '2025-08-25 21:26:31', 1, NULL),
(5, 'QuintaTarea', 'Quinta', 'en progreso', '2025-08-25 21:31:26', '2025-08-30 00:00:00', '2025-08-25 21:31:26', '2025-08-25 21:50:13', 1, 2),
(6, 'SextaTarea', 'Sexta', 'pendiente', '2025-08-25 21:36:17', NULL, '2025-08-25 21:36:17', '2025-08-25 21:36:17', 1, NULL),
(7, 'SeptimaTarea', 'Septima', 'en progreso', '2025-08-25 21:37:09', '2025-08-30 00:00:00', '2025-08-25 21:37:09', '2025-08-25 21:50:11', 1, 2),
(8, 'OctavaTarea', 'Octava', 'pendiente', '2025-08-25 21:43:15', NULL, '2025-08-25 21:43:15', '2025-08-25 21:43:15', 1, NULL),
(9, 'NovenaTarea', 'Novena', 'completada', '2025-08-25 21:43:35', '2025-08-30 00:00:00', '2025-08-25 21:43:35', '2025-08-25 21:50:09', 1, 2),
(10, 'DecimaTarea', 'Decima', 'pendiente', '2025-08-25 21:48:21', NULL, '2025-08-25 21:48:21', '2025-08-25 21:48:21', 1, NULL),
(11, 'OnceavaTarea', 'Onceava', 'pendiente', '2025-08-25 21:48:40', '2025-08-31 00:00:00', '2025-08-25 21:48:40', '2025-08-25 21:48:40', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `rol` enum('admin','usuario') DEFAULT 'usuario',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id_usuario`, `nombre`, `correo`, `contraseña`, `rol`, `createdAt`, `updatedAt`) VALUES
(1, 'angel', 'angel@gmail.com', '$2b$10$xZcgCfT02GmuZo.FqBWLt.j9eovr7BA54KOFOTMGNj.zkQPY9VxBy', 'usuario', '2025-08-25 18:33:42', '2025-08-25 18:33:42'),
(2, 'cael', 'cael@gmail.com', '$2b$10$ciMRKoksXIKDfnGv6SduxOu.YRVXJpuZ2sE3.6ZQndgAZMBd12TOu', 'usuario', '2025-08-25 18:35:38', '2025-08-25 18:35:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `rol` enum('admin','usuario') DEFAULT 'usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `id_usuario_destino` (`id_usuario_destino`);

--
-- Indices de la tabla `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id_tarea`),
  ADD KEY `id_usuario_creador` (`id_usuario_creador`),
  ADD KEY `id_usuario_asignado` (`id_usuario_asignado`);

--
-- Indices de la tabla `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id_tarea`),
  ADD KEY `id_usuario_creador` (`id_usuario_creador`),
  ADD KEY `id_usuario_asignado` (`id_usuario_asignado`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `correo_2` (`correo`),
  ADD UNIQUE KEY `correo_3` (`correo`),
  ADD UNIQUE KEY `correo_4` (`correo`),
  ADD UNIQUE KEY `correo_5` (`correo`),
  ADD UNIQUE KEY `correo_6` (`correo`),
  ADD UNIQUE KEY `correo_7` (`correo`),
  ADD UNIQUE KEY `correo_8` (`correo`),
  ADD UNIQUE KEY `correo_9` (`correo`),
  ADD UNIQUE KEY `correo_10` (`correo`),
  ADD UNIQUE KEY `correo_11` (`correo`),
  ADD UNIQUE KEY `correo_12` (`correo`),
  ADD UNIQUE KEY `correo_13` (`correo`),
  ADD UNIQUE KEY `correo_14` (`correo`),
  ADD UNIQUE KEY `correo_15` (`correo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario_destino`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`id_usuario_creador`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_10` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_11` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_12` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_13` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_14` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_15` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_16` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_17` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_18` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_19` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_20` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_21` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_22` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_3` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_4` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_5` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_6` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_7` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_8` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_9` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
