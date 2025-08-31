-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-08-2025 a las 07:00:56
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
  `fecha` datetime DEFAULT NULL,
  `leida` tinyint(1) DEFAULT 0,
  `id_usuario_destino` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id_notificacion` int(11) NOT NULL,
  `id_tarea` int(11) DEFAULT NULL,
  `mensaje` varchar(255) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `leida` tinyint(1) DEFAULT 0,
  `id_usuario_destino` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notifications`
--

INSERT INTO `notifications` (`id_notificacion`, `id_tarea`, `mensaje`, `fecha`, `leida`, `id_usuario_destino`) VALUES
(1, NULL, 'Se te ha asignado la tarea: PRO', '2025-08-27 17:47:57', 1, 2),
(2, NULL, 'Se te ha asignado la tarea: Hola', '2025-08-27 17:48:02', 1, 2),
(3, 11, 'Se te ha asignado la tarea: OnceavaTarea', '2025-08-27 18:02:46', 1, 2),
(4, 20, 'Se te ha asignado la tarea: ee', '2025-08-27 18:44:01', 1, 1),
(6, 21, 'Se te ha asignado la tarea: nueva', '2025-08-27 20:35:26', 1, 2),
(7, NULL, 'Se te ha asignado la tarea: vieja', '2025-08-27 20:37:24', 1, 2),
(8, 23, 'Se te ha asignado la tarea: queso', '2025-08-27 20:40:26', 1, 1),
(9, 24, 'Se te ha asignado la tarea: ooo', '2025-08-27 20:41:08', 1, 2),
(10, 21, 'Se te ha asignado la tarea: nueva', '2025-08-27 20:45:28', 1, 2),
(11, 26, 'Se te ha asignado la tarea: TestAdmin', '2025-08-28 21:09:05', 1, 1),
(12, 8, 'Se te ha asignado la tarea: OctavaTarea', '2025-08-29 02:38:11', 1, 3),
(13, 27, 'Se te ha asignado la tarea: PruebaReporte', '2025-08-29 19:52:08', 1, 3);

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
  `id_usuario_asignado` int(11) DEFAULT NULL,
  `fecha_completada` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tasks`
--

INSERT INTO `tasks` (`id_tarea`, `titulo`, `descripcion`, `estado`, `fecha_creacion`, `fecha_vencimiento`, `createdAt`, `updatedAt`, `id_usuario_creador`, `id_usuario_asignado`, `fecha_completada`) VALUES
(1, 'PrimerTarea', 'Primera', 'pendiente', '2025-08-25 21:10:39', '2025-08-28 00:00:00', '2025-08-25 21:10:39', '2025-08-25 21:10:39', 1, NULL, NULL),
(2, 'SegundaTarea', 'Segunda', 'pendiente', '2025-08-25 21:11:16', '2025-08-28 00:00:00', '2025-08-25 21:11:16', '2025-08-25 21:11:16', 1, NULL, NULL),
(3, 'TercerTarea', 'En esta tarea veremos cual es la importancia del software por ende se debera realizar de forma correcta y puntual', 'completada', '2025-08-25 21:14:19', NULL, '2025-08-25 21:14:19', '2025-08-31 04:09:39', 1, 2, '2025-08-25 17:08:53'),
(4, 'CuartaTarea', 'Cuarta', 'pendiente', '2025-08-25 21:26:31', '2025-08-29 00:00:00', '2025-08-25 21:26:31', '2025-08-25 21:26:31', 1, NULL, NULL),
(5, 'QuintaTarea', 'Quinta', 'en progreso', '2025-08-25 21:31:26', '2025-08-30 00:00:00', '2025-08-25 21:31:26', '2025-08-25 21:50:13', 1, 2, NULL),
(6, 'SextaTarea', 'Sexta', 'pendiente', '2025-08-25 21:36:17', NULL, '2025-08-25 21:36:17', '2025-08-25 21:36:17', 1, NULL, NULL),
(8, 'OctavaTarea', 'Octava', 'completada', '2025-08-25 21:43:15', NULL, '2025-08-25 21:43:15', '2025-08-29 13:35:54', 1, 3, NULL),
(11, 'OnceavaTarea', 'Onceava', 'pendiente', '2025-08-25 21:48:40', NULL, '2025-08-25 21:48:40', '2025-08-27 18:02:46', 1, 2, NULL),
(13, 'SuperTarea', 'Super', 'completada', '2025-08-26 15:41:39', NULL, '2025-08-26 15:41:39', '2025-08-26 17:06:33', 2, 1, NULL),
(14, 'Hola', 'hola', 'pendiente', '2025-08-26 16:58:31', NULL, '2025-08-26 16:58:31', '2025-08-27 15:08:16', 1, 2, NULL),
(18, 'a', 'a', 'completada', '2025-08-27 15:31:56', NULL, '2025-08-27 15:31:56', '2025-08-27 16:44:39', 2, 1, NULL),
(19, 'PRO', 'pro', 'completada', '2025-08-27 15:43:36', '2025-08-28 00:00:00', '2025-08-27 15:43:36', '2025-08-29 17:10:53', 1, 2, '2025-08-29 17:10:53'),
(20, 'ee', 'eee', 'completada', '2025-08-27 15:58:56', '2025-08-29 00:00:00', '2025-08-27 15:58:56', '2025-08-27 16:18:20', 2, 1, NULL),
(21, 'nueva', 'new', 'pendiente', '2025-08-27 20:35:20', '2025-08-29 05:00:00', '2025-08-27 20:35:20', '2025-08-27 20:45:28', 1, 2, NULL),
(23, 'queso', 'queso', 'pendiente', '2025-08-27 20:40:21', '2025-08-31 00:00:00', '2025-08-27 20:40:21', '2025-08-27 20:40:26', 2, 1, NULL),
(24, 'ooo', 'oooo', 'pendiente', '2025-08-27 20:41:04', NULL, '2025-08-27 20:41:04', '2025-08-27 20:41:08', 1, 2, NULL),
(25, 'PruebaBuscar', 'buscar', 'pendiente', '2025-08-28 14:51:54', '2025-08-31 00:00:00', '2025-08-28 14:51:54', '2025-08-28 14:51:54', 2, NULL, NULL),
(26, 'TestAdmin', 'ADMIN', 'en progreso', '2025-08-28 21:08:39', NULL, '2025-08-28 21:08:39', '2025-08-28 21:09:34', 3, 1, NULL),
(27, 'PruebaReporte', 'reporte', 'completada', '2025-08-29 19:51:27', '2025-08-30 00:00:00', '2025-08-29 19:51:27', '2025-08-29 19:52:35', 1, 3, '2025-08-29 19:52:35'),
(28, 'TESTFECHAVEN', 'vence', 'pendiente', '2025-08-29 21:28:32', '2025-09-06 00:00:00', '2025-08-29 21:28:32', '2025-08-29 21:28:32', 1, NULL, NULL);

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
(1, 'angel', 'angel@gmail.com', '$2b$10$xZcgCfT02GmuZo.FqBWLt.j9eovr7BA54KOFOTMGNj.zkQPY9VxBy', 'admin', '2025-08-25 18:33:42', '2025-08-29 01:44:59'),
(2, 'cael', 'cael@gmail.com', '$2b$10$ciMRKoksXIKDfnGv6SduxOu.YRVXJpuZ2sE3.6ZQndgAZMBd12TOu', 'usuario', '2025-08-25 18:35:38', '2025-08-31 04:47:18'),
(3, 'Administrador', 'admin@tareas.com', '$2b$10$ORP8GZSFc.J6YKpkOfhiHOO7q09nzIDSFmMptpmsAbz0n2o8fnyC6', 'admin', '2025-08-28 20:59:14', '2025-08-29 02:45:35'),
(4, 'Ozuna', 'ozuna@gmail.com', '$2b$10$UzA1oAp1vNWr0bHqg1VAKOJGkq.TEFZGWIocbdFrsajb76YCkM1X2', 'usuario', '2025-08-29 02:46:59', '2025-08-29 02:46:59');

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
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `id_tarea` (`id_tarea`),
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
  ADD UNIQUE KEY `correo_63` (`correo`);

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
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario_destino`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `notificaciones_ibfk_2` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notificaciones_ibfk_3` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notificaciones_ibfk_4` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notificaciones_ibfk_5` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notificaciones_ibfk_6` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_10` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_100` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_101` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_102` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_103` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_104` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_105` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_106` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_107` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_108` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_109` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_11` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_110` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_111` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_112` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_113` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_114` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_115` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_116` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_117` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_118` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_119` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_12` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_120` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_121` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_122` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_123` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_124` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_125` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_126` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_127` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_128` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_129` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_13` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_130` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_131` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_132` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_133` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_134` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_135` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_136` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_137` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_138` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_139` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_14` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_140` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_141` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_142` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_143` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_144` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_15` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_16` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_17` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_18` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_19` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_20` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_21` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_22` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_23` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_24` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_25` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_26` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_27` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_28` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_29` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_30` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_31` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_32` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_33` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_34` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_35` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_36` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_37` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_38` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_39` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_4` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_40` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_41` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_42` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_43` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_44` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_45` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_46` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_47` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_48` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_49` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_5` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_50` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_51` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_52` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_53` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_54` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_55` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_56` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_57` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_58` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_59` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_6` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_60` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_61` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_62` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_63` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_64` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_65` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_66` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_67` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_68` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_69` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_7` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_70` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_71` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_72` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_73` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_74` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_75` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_76` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_77` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_78` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_79` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_8` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_80` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_81` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_82` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_83` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_84` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_85` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_86` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_87` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_88` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_89` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_9` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_90` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_91` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_92` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_93` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_94` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_95` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_96` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_97` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_98` FOREIGN KEY (`id_usuario_destino`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_99` FOREIGN KEY (`id_tarea`) REFERENCES `tasks` (`id_tarea`) ON DELETE SET NULL ON UPDATE CASCADE;

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
  ADD CONSTRAINT `tasks_ibfk_100` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_101` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_102` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_103` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_104` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_105` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_106` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_107` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_108` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_109` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_11` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_110` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_111` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_112` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_113` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_114` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_115` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_116` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_117` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_118` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_119` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_12` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_120` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_121` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_122` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_123` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_124` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_125` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_126` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_127` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_128` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_129` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_13` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_130` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_131` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_132` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_133` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_134` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_135` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_136` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_137` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_138` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_139` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_14` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_140` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_141` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_142` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_143` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_144` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_145` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_146` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_147` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_148` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_149` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_15` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_150` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_151` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_152` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_153` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_154` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_155` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_156` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_157` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_158` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_159` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_16` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_160` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_161` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_162` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_163` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_164` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_165` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_166` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_167` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_168` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_169` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_17` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_170` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_171` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_172` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_173` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_174` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_175` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_176` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_177` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_178` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_179` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_18` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_180` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_181` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_182` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_183` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_184` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_185` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_186` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_187` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_188` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_189` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_19` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_190` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_191` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_192` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_193` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_194` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_195` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_196` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_197` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_198` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_199` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_20` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_200` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_201` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_202` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_203` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_204` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_205` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_206` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_207` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_208` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_209` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_21` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_210` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_211` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_212` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_213` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_214` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_215` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_216` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_217` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_218` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_219` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_22` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_220` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_221` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_222` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_223` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_224` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_225` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_226` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_227` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_228` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_229` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_23` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_230` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_231` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_232` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_233` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_234` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_24` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_25` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_26` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_27` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_28` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_29` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_3` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_30` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_31` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_32` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_33` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_34` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_35` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_36` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_37` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_38` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_39` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_4` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_40` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_41` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_42` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_43` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_44` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_45` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_46` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_47` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_48` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_49` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_5` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_50` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_51` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_52` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_53` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_54` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_55` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_56` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_57` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_58` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_59` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_6` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_60` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_61` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_62` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_63` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_64` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_65` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_66` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_67` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_68` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_69` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_7` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_70` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_71` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_72` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_73` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_74` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_75` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_76` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_77` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_78` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_79` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_8` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_80` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_81` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_82` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_83` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_84` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_85` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_86` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_87` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_88` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_89` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_9` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_90` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_91` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_92` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_93` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_94` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_95` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_96` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_97` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_98` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_99` FOREIGN KEY (`id_usuario_creador`) REFERENCES `users` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
