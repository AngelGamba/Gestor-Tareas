import { useState } from "react";
import api from "../api/axios";
import { useNavigate } from "react-router-dom";

function Register() {
  const [nombre, setNombre] = useState("");
  const [correo, setCorreo] = useState("");
  const [contraseña, setContraseña] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.post("/usuarios/registro", { nombre, correo, contraseña });
      alert("Registro exitoso, ahora inicia sesión");
      navigate("/login");
    } catch {
      alert("Error al registrar");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-blue-700 to-purple-100">
      <div className="bg-white shadow-2xl rounded-2xl p-10 w-full max-w-md">
        <h2 className="text-3xl font-bold text-center text-indigo-800 mb-6">Crear Cuenta</h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            placeholder="Nombre"
            className="w-full px-4 py-3 border rounded-xl focus:ring-2 focus:ring-indigo-500"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
            required
          />
          <input
            type="email"
            placeholder="Correo"
            className="w-full px-4 py-3 border rounded-xl focus:ring-2 focus:ring-indigo-500"
            value={correo}
            onChange={(e) => setCorreo(e.target.value)}
            required
          />
          <input
            type="password"
            placeholder="Contraseña"
            className="w-full px-4 py-3 border rounded-xl focus:ring-2 focus:ring-indigo-500"
            value={contraseña}
            onChange={(e) => setContraseña(e.target.value)}
            required
          />
          <button className="w-full bg-blue-600 hover:bg-purple-700 text-white py-3 rounded-xl font-semibold transition">
            Registrarse
          </button>
        </form>
        <p className="text-center text-gray-500 mt-4">
          ¿Ya tienes cuenta?{" "}
          <span className="text-purple-600 font-semibold cursor-pointer" onClick={() => navigate("/login")}>
            Inicia Sesión
          </span>
        </p>
      </div>
    </div>
  );
}

export default Register;
