-- Crear base de datos
CREATE DATABASE IF NOT EXISTS gestor_tareas CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestor_tareas;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    rol ENUM('admin','usuario') DEFAULT 'usuario'
);

-- Tabla de tareas
CREATE TABLE tareas (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT NOT NULL,
    estado ENUM('pendiente','en progreso','completada') DEFAULT 'pendiente',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATE NULL,
    id_usuario_creador INT,
    id_usuario_asignado INT,
    FOREIGN KEY (id_usuario_creador) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_asignado) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

-- Tabla de notificaciones
CREATE TABLE notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    mensaje VARCHAR(255) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    leida BOOLEAN DEFAULT FALSE,
    id_usuario_destino INT,
    FOREIGN KEY (id_usuario_destino) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);
