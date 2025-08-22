import { useState } from "react";
import api from "../api/axios";
import { useNavigate } from "react-router-dom";

function Login() {
  const [correo, setCorreo] = useState("");
  const [contraseña, setContraseña] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await api.post("/usuarios/login", { correo, contraseña });
      localStorage.setItem("token", res.data.token);
      navigate("/dashboard");
    } catch {
      alert("Credenciales incorrectas");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-blue-700 to-purple-100">
      <div className="bg-white shadow-2xl rounded-2xl p-10 w-full max-w-md">
        <h2 className="text-3xl font-bold text-center text-indigo-800 mb-6">Iniciar Sesión</h2>
        <form onSubmit={handleSubmit} className="space-y-4">
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
            Entrar
          </button>
        </form>
        <p className="text-center text-gray-500 mt-4">
          ¿No tienes cuenta?{" "}
          <span className="text-purple-600 font-semibold cursor-pointer" onClick={() => navigate("/register")}>
            Regístrate
          </span>
        </p>
      </div>
    </div>
  );
}

export default Login;
