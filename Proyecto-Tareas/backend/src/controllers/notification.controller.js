import { Notification } from "../models/Notification.js";

// 📩 Listar notificaciones del usuario logueado
export const getNotificaciones = async (req, res) => {
  try {
    const notifs = await Notification.findAll({
      where: { id_usuario_destino: req.user.id },
      order: [["fecha", "DESC"]],
    });
    res.json(notifs);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener notificaciones" });
  }
};

// ✅ Marcar notificación como leída
export const marcarLeida = async (req, res) => {
  try {
    const { id } = req.params;
    const notif = await Notification.findByPk(id);

    if (!notif || notif.id_usuario_destino !== req.user.id) {
      return res.status(403).json({ error: "No autorizado" });
    }

    notif.leida = true;
    await notif.save();

    res.json({ message: "Notificación marcada como leída" });
  } catch (error) {
    res.status(500).json({ error: "Error al actualizar notificación" });
  }
};
