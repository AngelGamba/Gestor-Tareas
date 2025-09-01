/**
 * @swagger
 * tags:
 *   name: Usuarios
 *   description: Endpoints para gestión de usuarios y autenticación
 */

import { Router } from "express";
import { register, login, getUsuarios, updateRol } from "../controllers/user.controller.js";
import { authMiddleware, soloAdmin } from "../middlewares/auth.js";

const router = Router();

/**
 * @swagger
 * /usuarios/registro:
 *   post:
 *     summary: Registrar un nuevo usuario
 *     tags: [Usuarios]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               nombre:
 *                 type: string
 *               correo:
 *                 type: string
 *               contraseña:
 *                 type: string
 *     responses:
 *       200:
 *         description: Usuario registrado correctamente
 */
router.post("/registro", register);

/**
 * @swagger
 * /usuarios/login:
 *   post:
 *     summary: Iniciar sesión de usuario
 *     tags: [Usuarios]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               correo:
 *                 type: string
 *               contraseña:
 *                 type: string
 *     responses:
 *       200:
 *         description: Login exitoso con token JWT
 */
router.post("/login", login);

/**
 * @swagger
 * /usuarios:
 *   get:
 *     summary: Listar todos los usuarios (requiere login)
 *     tags: [Usuarios]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de usuarios
 */
router.get("/", authMiddleware, getUsuarios);

/**
 * @swagger
 * /usuarios/{id}/rol:
 *   put:
 *     summary: Cambiar rol de usuario (solo Admin)
 *     tags: [Usuarios]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del usuario
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               rol:
 *                 type: string
 *                 enum: [usuario, admin]
 *     responses:
 *       200:
 *         description: Rol actualizado con éxito
 */
router.put("/:id/rol", authMiddleware, soloAdmin, updateRol);

export default router;
