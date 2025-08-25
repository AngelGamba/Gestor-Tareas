import { Task } from "../models/Task.js";
import { User } from "../models/User.js";
import { Op } from "sequelize";

// Crear tarea
export const crearTarea = async (req, res) => {
  try {
    let { titulo, descripcion, fecha_vencimiento } = req.body;

    // Normalizar vacío -> null
    if (fecha_vencimiento === "" || fecha_vencimiento === undefined) {
      fecha_vencimiento = null;
    }

    // ✅ Validar fecha de vencimiento si viene
    if (fecha_vencimiento) {
      const hoy = new Date();
      hoy.setHours(0, 0, 0, 0);

      // Usar T00:00:00 para evitar desfase por zona horaria
      const fecha = new Date(`${fecha_vencimiento}T00:00:00`);

      if (fecha < hoy) {
        return res.status(400).json({
          error: "La fecha de vencimiento no puede ser anterior a hoy.",
        });
      }
    }

    const tarea = await Task.create({
      titulo,
      descripcion,
      fecha_vencimiento, // puede ser null
      id_usuario_creador: req.user.id,
    });
    res.json(tarea);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al crear tarea" });
  }
};

// Listar tareas del usuario
export const listarTareas = async (req, res) => {
  try {
    const tareas = await Task.findAll({
      where: {
        [Op.or]: [
          { id_usuario_creador: req.user.id },
          { id_usuario_asignado: req.user.id },
        ],
      },
      include: [
        { model: User, as: "creador", attributes: ["id_usuario", "nombre"] },
        { model: User, as: "asignado", attributes: ["id_usuario", "nombre"] },
      ],
    });
    res.json(tareas);
  } catch (error) {
    res.status(500).json({ error: "Error al listar tareas" });
  }
};

// Actualizar tarea
export const actualizarTarea = async (req, res) => {
  try {
    const { id } = req.params;
    let { titulo, descripcion, fecha_vencimiento } = req.body;
    const tarea = await Task.findByPk(id);

    if (!tarea) return res.status(404).json({ error: "Tarea no encontrada" });

    // Solo creador puede editar título/desc/fecha
    if (tarea.id_usuario_creador !== req.user.id)
      return res.status(403).json({ error: "No autorizado" });

    // Normalizar vacío -> null
    if (fecha_vencimiento === "") fecha_vencimiento = null;

    // ✅ Validar fecha si viene
    if (fecha_vencimiento) {
      const hoy = new Date();
      hoy.setHours(0, 0, 0, 0);

      const fecha = new Date(`${fecha_vencimiento}T00:00:00`);

      if (fecha < hoy) {
        return res.status(400).json({
          error: "La fecha de vencimiento no puede ser anterior a hoy.",
        });
      }
    }

    tarea.titulo = titulo ?? tarea.titulo;
    tarea.descripcion = descripcion ?? tarea.descripcion;
    if (fecha_vencimiento !== undefined) {
      // Permite setear null para quitar fecha
      tarea.fecha_vencimiento = fecha_vencimiento;
    }

    await tarea.save();
    res.json(tarea);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al actualizar tarea" });
  }
};

// Eliminar tarea
export const eliminarTarea = async (req, res) => {
  try {
    const { id } = req.params;
    const tarea = await Task.findByPk(id);

    if (!tarea) return res.status(404).json({ error: "Tarea no encontrada" });
    if (tarea.id_usuario_creador !== req.user.id)
      return res.status(403).json({ error: "No autorizado" });

    await tarea.destroy();
    res.json({ message: "Tarea eliminada" });
  } catch (error) {
    res.status(500).json({ error: "Error al eliminar tarea" });
  }
};

// Asignar tarea
export const asignarTarea = async (req, res) => {
  try {
    const { id } = req.params;
    const { id_usuario_asignado } = req.body;
    const tarea = await Task.findByPk(id);

    if (!tarea) return res.status(404).json({ error: "Tarea no encontrada" });
    if (tarea.id_usuario_creador !== req.user.id)
      return res.status(403).json({ error: "No autorizado" });

    tarea.id_usuario_asignado = id_usuario_asignado;
    await tarea.save();

    res.json({ message: "Tarea asignada", tarea });
  } catch (error) {
    res.status(500).json({ error: "Error al asignar tarea" });
  }
};

// Cambiar estado
export const cambiarEstado = async (req, res) => {
  try {
    const { id } = req.params;
    const { estado } = req.body;
    const tarea = await Task.findByPk(id);

    if (!tarea) return res.status(404).json({ error: "Tarea no encontrada" });

    // Solo el asignado puede cambiar estado
    if (tarea.id_usuario_asignado !== req.user.id)
      return res.status(403).json({ error: "No autorizado" });

    tarea.estado = estado;
    await tarea.save();

    res.json(tarea);
  } catch (error) {
    res.status(500).json({ error: "Error al cambiar estado" });
  }
};

// Reporte de tareas completadas
export const generarReporte = async (req, res) => {
  try {
    if (req.user.rol !== "admin")
      return res.status(403).json({ error: "Solo admin puede generar reportes" });

    const { desde, hasta } = req.query;
    const tareas = await Task.findAll({
      where: {
        estado: "completada",
        createdAt: {
          [Op.between]: [new Date(desde), new Date(hasta)],
        },
      },
    });

    res.json(tareas);
  } catch (error) {
    res.status(500).json({ error: "Error al generar reporte" });
  }
};
