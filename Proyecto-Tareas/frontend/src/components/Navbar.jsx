import { Link, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { User } from "lucide-react"; // 👈 icono de usuario bonito

function Navbar() {
  const navigate = useNavigate();
  const [nombre, setNombre] = useState("");
  const [rol, setRol] = useState("");

  useEffect(() => {
    const nombreGuardado = localStorage.getItem("nombre");
    const rolGuardado = localStorage.getItem("rol");
    if (nombreGuardado) setNombre(nombreGuardado);
    if (rolGuardado) setRol(rolGuardado);
  }, []);

  const handleLogout = () => {
    localStorage.removeItem("token");
    navigate("/home");
  };

  return (
    <nav className="bg-gradient-to-br from-blue-700 to-purple-700 text-white py-4 shadow-md fixed top-0 left-0 w-full">
      <div className="flex justify-between items-center max-w-6xl mx-auto">
        {/* Logo */}
        <Link to="/tareas" className="text-white text-xl font-bold tracking-wide">
          🚀 Gestor Tareas
        </Link>

        {/* Links */}
        <div className="flex gap-6">
            <Link to="/dashboard" className="text-white hover:text-purple-200 transition font-medium">
                Dashboard
            </Link>
            <Link to="/tareas" className="text-white hover:text-purple-200 transition font-medium">
                Tareas
            </Link>
            <Link to="/reportes" className="text-white hover:text-purple-200 transition font-medium">
                Reportes
            </Link>
        </div>

        {/* Usuario + logout */}
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-3 bg-indigo-800 px-4 py-2 rounded-full shadow-md">
            <User size={20} />
            <div className="flex flex-col">
              <span className="font-medium">{nombre || "Invitado"}</span>
              {rol && (
                <span
                  className={`text-xs px-2 py-0.5 rounded-full text-white font-semibold w-fit
                  ${rol === "admin" ? "bg-yellow-500" : "bg-blue-500"}`}
                >
                  {rol.toUpperCase()}
                </span>
              )}
            </div>
          </div>
        
        {/* Logout */}
        <button
          onClick={handleLogout}
          className="text-black bg-blue-400 hover:bg-red-400 px-4 py-2 rounded-lg font-medium transition"
        >
          Logout
        </button>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;
