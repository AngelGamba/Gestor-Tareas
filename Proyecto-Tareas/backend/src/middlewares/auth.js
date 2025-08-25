import jwt from "jsonwebtoken";

export const authMiddleware = (req, res, next) => {
  try {
    // 1. Revisar si existe cabecera de autorización
    const authHeader = req.headers["authorization"];
    if (!authHeader) {
      return res.status(401).json({ error: "Acceso no autorizado, falta token" });
    }

    // 2. Extraer token (formato: "Bearer xxx")
    const token = authHeader.split(" ")[1];
    if (!token) {
      return res.status(401).json({ error: "Token inválido o malformado" });
    }

    // 3. Verificar token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // 4. Guardar datos del usuario en la request (id y rol)
    req.user = decoded;
    next(); // continuar con la ruta
  } catch (error) {
    return res.status(401).json({ error: "Token inválido o expirado" });
  }
};

// Middleware opcional para rol admin
export const soloAdmin = (req, res, next) => {
  if (req.user?.rol !== "admin") {
    return res.status(403).json({ error: "Acceso denegado, solo admin" });
  }
  next();
};
