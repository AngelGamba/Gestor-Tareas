import { User } from "../models/User.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

export const register = async (req, res) => {
  try {
    const { nombre, correo, contraseña } = req.body;
    
    const regexPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#*!_.¡\-])[A-Za-z\d@$#*!_.¡\-]{8,}$/;
    if (!regexPassword.test(contraseña)) {
      return res.status(400).json({
        error: "La contraseña debe tener mínimo 8 caracteres, al menos 1 mayúscula, 1 minúscula, 1 número y 1 caracter especial (@, $, #, *, !, -, _, ., ¡)."
      });
    }
    
    const existe = await User.findOne({ where: { correo } });
    if (existe) return res.status(400).json({ error: "Correo ya registrado" });

    const hash = await bcrypt.hash(contraseña, 10);
    const user = await User.create({ nombre, correo, contraseña: hash });

    res.json({ message: "Usuario registrado", user });
  } catch (error) {
    res.status(500).json({ error: "Error al registrar usuario" });
  }
};

export const login = async (req, res) => {
  try {
    const { correo, contraseña } = req.body;
    const user = await User.findOne({ where: { correo } });
    if (!user) return res.status(404).json({ error: "Usuario no encontrado" });

    const valid = await bcrypt.compare(contraseña, user.contraseña);
    if (!valid) return res.status(401).json({ error: "Contraseña incorrecta" });

    const token = jwt.sign({ id: user.id_usuario, rol: user.rol }, process.env.JWT_SECRET, { expiresIn: "1h" });
    res.json({ token });
  } catch (error) {
    res.status(500).json({ error: "Error al iniciar sesión" });
  }
};

// ✅ Nuevo: Listar usuarios
export const getUsuarios = async (req, res) => {
  try {
    const usuarios = await User.findAll({
      attributes: ["id_usuario", "nombre", "correo", "rol"], // evita enviar contraseña
    });
    res.json(usuarios);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener usuarios" });
  }
};