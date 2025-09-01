/**
 * @swagger
 * tags:
 *   name: Tareas
 *   description: Endpoints para gestión de tareas
 */

import { Router } from "express";
import {crearTarea, listarTareas, eliminarTarea, asignarTarea, cambiarEstado,  editarTarea} from "../controllers/task.controller.js";
import { authMiddleware } from "../middlewares/auth.js";

const router = Router();

// CRUD tareas

/**
 * @swagger
 * /tareas:
 *   post:
 *     summary: Crear nueva tarea
 *     tags: [Tareas]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               titulo:
 *                 type: string
 *               descripcion:
 *                 type: string
 *               fecha_vencimiento:
 *                 type: string
 *                 format: date
 *     responses:
 *       200:
 *         description: Tarea creada
 */
router.post("/", authMiddleware, crearTarea);

/**
 * @swagger
 * /tareas:
 *   get:
 *     summary: Listar tareas del usuario autenticado
 *     tags: [Tareas]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de tareas
 */
router.get("/", authMiddleware, listarTareas);

/**
 * @swagger
 * /tareas/{id}:
 *   put:
 *     summary: Editar tarea (solo creador)
 *     tags: [Tareas]
 *     security:
 *       - bearerAuth: []
 */
router.put("/:id", authMiddleware, editarTarea);

/**
 * @swagger
 * /tareas/{id}:
 *   delete:
 *     summary: Eliminar tarea (creador elimina o asignado se desasigna)
 *     tags: [Tareas]
 *     security:
 *       - bearerAuth: []
 */

router.delete("/:id", authMiddleware, eliminarTarea);

// Extra

/**
 * @swagger
 * /tareas/{id}/asignar:
 *   put:
 *     summary: Asignar tarea a usuario
 *     tags: [Tareas]
 *     security:
 *       - bearerAuth: []
 */
router.put("/:id/asignar", authMiddleware, asignarTarea);

/**
 * @swagger
 * /tareas/{id}/estado:
 *   put:
 *     summary: Cambiar estado de la tarea
 *     tags: [Tareas]
 *     security:
 *       - bearerAuth: []
 */
router.put("/:id/estado", authMiddleware, cambiarEstado);

export default router;
