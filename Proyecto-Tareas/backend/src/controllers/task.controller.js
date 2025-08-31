import { Task } from "../models/Task.js";
import { User } from "../models/User.js";
import { Op } from "sequelize";
import { Parser } from "json2csv"; // 👈 para CSV
import PDFDocument from "pdfkit";  // 👈 para PDF
import { Notification } from "../models/Notification.js";

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

// Editar tarea
export const editarTarea = async (req, res) => {
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
    res.status(500).json({ error: "Error al editar tarea" });
  }
};

// Eliminar tarea (comportamiento diferente si es creador o asignado)
export const eliminarTarea = async (req, res) => {
  try {
    const { id } = req.params;
    const tarea = await Task.findByPk(id);

    if (!tarea) return res.status(404).json({ error: "Tarea no encontrada" });

    // ✅ Caso 1: el creador la elimina -> se borra de la BD
    if (tarea.id_usuario_creador === req.user.id) {
      await tarea.destroy();
      return res.json({ message: "Tarea eliminada por el creador (ya no existe)" });
    }

    // ✅ Caso 2: el asignado la elimina -> se desasigna y se reinicia a pendiente
    if (tarea.id_usuario_asignado === req.user.id) {
      tarea.id_usuario_asignado = null;
      tarea.estado = "pendiente"; // 👈 resetear estado
      await tarea.save();
      return res.json({
        message: "Te has eliminado de la tarea (sigue existiendo para el creador en estado pendiente)",
        tarea,
      });
    }

    // Si no es creador ni asignado → no tiene permiso
    return res.status(403).json({ error: "No autorizado para eliminar esta tarea" });

  } catch (error) {
    console.error(error);
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
    await Notification.create({
    id_usuario_destino: id_usuario_asignado,
    mensaje: `Se te ha asignado la tarea: ${tarea.titulo}`,
    id_tarea: tarea.id_tarea,
    });
    res.json({ message: "Tarea asignada", tarea });
  } catch (error) {
    res.status(500).json({ error: "Error al asignar tarea" });
  }
};

// ✅ Cambiar estado de tarea
export const cambiarEstado = async (req, res) => {
  try {
    const { id } = req.params;
    const { estado } = req.body;

    const task = await Task.findByPk(id);
    if (!task) {
      return res.status(404).json({ error: "Tarea no encontrada" });
    }

    task.estado = estado;

    // Si se completa → guardar fecha actual
    if (estado === "completada") {
      task.fecha_completada = new Date();
    } else {
      task.fecha_completada = null; // opcional: limpiar si vuelve a otro estado
    }

    await task.save();

    res.json({ message: "Estado actualizado", task });
  } catch (error) {
    console.error("Error en cambiarEstado:", error);
    res.status(500).json({ error: "Error al cambiar estado de la tarea" });
  }
};

// Reporte de tareas completadas
export const generarReporte = async (req, res) => {
  try {
    const { desde, hasta, formato } = req.query;

    if (!desde || !hasta) {
      return res.status(400).json({ error: "Debes enviar fechas 'desde' y 'hasta'." });
    }

    const fechaDesde = new Date(`${desde}T00:00:00.000Z`);
    const fechaHasta = new Date(`${hasta}T23:59:59.999Z`);

    // Normalizar "hoy"
    const hoyUTC = new Date();
    hoyUTC.setUTCHours(23, 59, 59, 999);

    if (fechaDesde > fechaHasta) {
      return res.status(400).json({ error: "El rango de fechas no es válido (desde > hasta)." });
    }
    if (fechaHasta > hoyUTC) {
      return res.status(400).json({ error: "No se pueden generar reportes con fechas futuras." });
    }

    // ✅ Buscar tareas completadas
    const tareas = await Task.findAll({
      where: {
        estado: "completada",
        fecha_completada: {
          [Op.between]: [fechaDesde, fechaHasta],
        },
      },
      attributes: ["id_tarea", "titulo", "descripcion", "fecha_completada"],
      include: [
        { model: User, as: "asignado", attributes: ["id_usuario", "nombre"] },
      ],
    });

    // 📂 CSV
    if (formato === "csv") {
      const parser = new Parser();
      const csv = parser.parse(tareas.map(t => t.toJSON()));
      res.header("Content-Type", "text/csv");
      res.attachment(`reporte_tareas_${desde}_${hasta}.csv`);
      return res.send(csv);
    }

    // 📄 PDF con tabla
    if (formato === "pdf") {
  const doc = new PDFDocument({ margin: 40 });
  res.setHeader("Content-Type", "application/pdf");
  res.setHeader(
    "Content-Disposition",
    `attachment; filename="reporte_tareas_${desde}_${hasta}.pdf"`
  );
  doc.pipe(res);

  // --- Título ---
  doc.font("Helvetica-Bold").fontSize(18).text("Reporte de Tareas Completadas", {
    align: "center",
  });
  doc.moveDown(2);

  // --- Config tabla ---
  const tableTop = doc.y;
  const colX = [50, 200, 350, 450]; // posiciones X de cada columna
  const colW = [150, 150, 100, 120]; // anchos de cada columna
  const headers = ["Título", "Asignado", "Fecha", "Descripción"];

  // Dibujar encabezados
  doc.font("Helvetica-Bold").fontSize(12);
  let headerHeight = 30;

  headers.forEach((header, i) => {
    doc.rect(colX[i], tableTop, colW[i], headerHeight).stroke();
    doc.text(header, colX[i] + 5, tableTop + 8, {
      width: colW[i] - 10,
      align: "center",
    });
  });

  // --- Filas ---
  let y = tableTop + headerHeight;
  doc.font("Helvetica").fontSize(10);

  tareas.forEach((t) => {
    const fecha = new Date(t.fecha_completada).toLocaleDateString();

    const values = [
      t.titulo,
      t.asignado?.nombre || "Nadie",
      fecha,
      t.descripcion || "-",
    ];

    // Calcular altura dinámica de la fila (según texto más alto)
    const heights = values.map((val, i) =>
      doc.heightOfString(val.toString(), { width: colW[i] - 10 })
    );
    const rowHeight = Math.max(...heights) + 15; // 15px de padding

    // Dibujar celdas
    values.forEach((val, i) => {
      doc.rect(colX[i], y, colW[i], rowHeight).stroke(); // borde celda
      doc.text(val, colX[i] + 5, y + 8, {
        width: colW[i] - 10,
        align: "left",
      });
    });

    y += rowHeight;
  });

  doc.end();
  return;
}


    // Por defecto: JSON
    res.json(tareas);

  } catch (err) {
    console.error("Error en generarReporte:", err);
    res.status(500).json({ error: "Error al generar reporte." });
  }
};
