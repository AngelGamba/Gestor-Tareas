import { useState } from "react";
import api from "../api/axios";
import { useNavigate } from "react-router-dom";

function Register() {
  const [nombre, setNombre] = useState("");
  const [correo, setCorreo] = useState("");
  const [contraseña, setContraseña] = useState("");
  const [errores, setErrores] = useState({});
  const navigate = useNavigate();

  const regexPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#*!_.¡\-])[A-Za-z\d@$#*!_.¡\-]{8,}$/;

  const validarPassword = (pass) => {
    const reglas = {
      longitud: pass.length >= 8,
      mayuscula: /[A-Z]/.test(pass),
      minuscula: /[a-z]/.test(pass),
      numero: /\d/.test(pass),
      especial: /[@$#*!_\-\.¡]/.test(pass),
    };
    setErrores(reglas);
    return Object.values(reglas).every(Boolean);
  };

  const handleSubmit = async (e) => {
  e.preventDefault();

  // Validación frontend antes de enviar
  if (!regexPassword.test(contraseña)) {
    alert(
      "La contraseña debe tener mínimo 8 caracteres, al menos 1 mayúscula, 1 minúscula, 1 número y 1 caracter especial."
    );
    return;
  }

  try {
    await api.post("/usuarios/registro", { nombre, correo, contraseña });
    alert("✅ Registro exitoso, ahora inicia sesión");
    navigate("/login");
  } catch (err) {
  console.error("Error de registro:", err.response?.data || err.message);
  alert(err.response?.data?.error || "❌ Error al registrar");
  }
};


  return (
    <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-blue-700 to-purple-100">
      {/* Botón volver al Home */}
      <button
        onClick={() => navigate("/home")}
        className="absolute top-6 left-6 bg-gray-200 hover:bg-gray-300 text-gray-700 px-6 py-2 rounded-lg font-medium transition"
      >
        ⬅️ Volver al Home
      </button>

      {/* Tarjeta de registro */}
      <div className="bg-white shadow-2xl rounded-2xl p-10 pt-6 w-full max-w-md">
        <h2 className="text-3xl font-bold text-center text-indigo-800 mb-6">
          Crear Cuenta
        </h2>

        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            placeholder="Nombre"
            className="w-full px-4 py-3 border rounded-xl focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
            required
          />
          <input
            type="email"
            placeholder="Correo"
            className="w-full px-4 py-3 border rounded-xl focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white"
            value={correo}
            onChange={(e) => setCorreo(e.target.value)}
            required
          />
          <input
            type="password"
            placeholder="Contraseña"
            className="w-full px-4 py-3 border rounded-xl focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white"
            value={contraseña}
            onChange={(e) => {
              setContraseña(e.target.value);
              validarPassword(e.target.value);
            }}
            required
          />

          {/* Indicadores dinámicos */}
          <div className="text-sm text-gray-600 space-y-1">
            <p className={errores.longitud ? "text-green-600" : "text-red-500"}>
              {errores.longitud ? "✅" : "❌"} Al menos 8 caracteres
            </p>
            <p className={errores.mayuscula ? "text-green-600" : "text-red-500"}>
              {errores.mayuscula ? "✅" : "❌"} Una letra mayúscula
            </p>
            <p className={errores.minuscula ? "text-green-600" : "text-red-500"}>
              {errores.minuscula ? "✅" : "❌"} Una letra minúscula
            </p>
            <p className={errores.numero ? "text-green-600" : "text-red-500"}>
              {errores.numero ? "✅" : "❌"} Un número
            </p>
            <p className={errores.especial ? "text-green-600" : "text-red-500"}>
              {errores.especial ? "✅" : "❌"} Un caracter especial (@, $, #, *,
              !, -, _, ., ¡)
            </p>
          </div>

          <button className="w-full bg-blue-600 hover:bg-purple-700 text-white py-3 rounded-xl font-semibold transition">
            Registrarse
          </button>
        </form>

        <p className="text-center text-gray-500 mt-4">
          ¿Ya tienes cuenta?{" "}
          <span
            className="text-purple-600 font-semibold cursor-pointer"
            onClick={() => navigate("/login")}
          >
            Inicia Sesión
          </span>
        </p>
      </div>
    </div>
  );
}

export default Register;
