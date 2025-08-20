import { Task } from "../models/Task.js";
import { User } from "../models/User.js";
import { Op } from "sequelize";

// Crear tarea
export const crearTarea = async (req, res) => {
try {
    const { titulo, descripcion, fecha_vencimiento } = req.body;
    const tarea = await Task.create({
        titulo,
        descripcion,
        fecha_vencimiento,
        id_usuario_creador: req.user.id
    });
    res.json(tarea);
} catch (error) {
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
            { id_usuario_asignado: req.user.id }
        ]
    },
    include: [
        { model: User, as: "creador", attributes: ["id_usuario", "nombre"] },
        { model: User, as: "asignado", attributes: ["id_usuario", "nombre"] }
    ]
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
    const { titulo, descripcion } = req.body;
    const tarea = await Task.findByPk(id);

    if (!tarea) return res.status(404).json({ error: "Tarea no encontrada" });

    // Solo creador puede editar título/desc
    if (tarea.id_usuario_creador !== req.user.id)
    return res.status(403).json({ error: "No autorizado" });

    tarea.titulo = titulo;
    tarea.descripcion = descripcion;
    await tarea.save();

    res.json(tarea);
} catch (error) {
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
        fecha_creacion: {
            [Op.between]: [new Date(desde), new Date(hasta)]
        }
    }
});

    res.json(tareas);
} catch (error) {
    res.status(500).json({ error: "Error al generar reporte" });
}
};
