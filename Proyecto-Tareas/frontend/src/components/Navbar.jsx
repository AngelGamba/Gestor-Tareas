import { Link, useNavigate } from "react-router-dom";
import { useEffect, useState, useRef } from "react";
import { User, Bell, Check } from "lucide-react";
import api from "../api/axios";

function Navbar() {
  const navigate = useNavigate();
  const [nombre, setNombre] = useState("");
  const [rol, setRol] = useState("");
  const [notifs, setNotifs] = useState([]);
  const [openNotif, setOpenNotif] = useState(false);
  const dropdownRef = useRef(null);

  const token = localStorage.getItem("token");
  const headers = { Authorization: `Bearer ${token}` };

  const fetchNotifs = async () => {
    try {
      const res = await api.get("/notificaciones", { headers });
      setNotifs(res.data);
    } catch (e) {
      console.error("Error al traer notificaciones", e);
    }
  };

  useEffect(() => {
    const nombreGuardado = localStorage.getItem("nombre");
    const rolGuardado = localStorage.getItem("rol");
    if (nombreGuardado) setNombre(nombreGuardado);
    if (rolGuardado) setRol(rolGuardado);
    fetchNotifs();
  }, []);

  useEffect(() => {
    function handleClickOutside(e) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target)) {
        setOpenNotif(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const marcarLeidaYNavegar = async (notif) => {
    try {
      if (!notif.leida) {
        await api.put(`/notificaciones/${notif.id_notificacion}/leida`, {}, { headers });
        setNotifs((prev) =>
          prev.map((n) =>
            n.id_notificacion === notif.id_notificacion ? { ...n, leida: true } : n
          )
        );
      }
      if (notif.id_tarea) {
        navigate(`/tareas?highlight=${notif.id_tarea}`);
        setOpenNotif(false);
      }
    } catch (err) {
      console.error("Error al marcar como leída", err);
    }
  };

  const handleLogout = () => {
    localStorage.removeItem("token");
    navigate("/home");
  };

  return (
    <nav className="bg-gradient-to-br from-blue-700 to-purple-700 text-white py-4 shadow-md fixed top-0 left-0 w-full z-50">
      <div className="flex justify-between items-center max-w-6xl mx-auto">
        <Link to="/tareas" className="text-white text-xl font-bold tracking-wide">🚀 Gestor Tareas</Link>

        <div className="flex gap-6">
          <Link to="/dashboard" className="hover:text-purple-200 transition font-medium">Dashboard</Link>
          <Link to="/tareas" className="hover:text-purple-200 transition font-medium">Tareas</Link>
          <Link to="/reportes" className="hover:text-purple-200 transition font-medium">Reportes</Link>
        </div>

        <div className="flex items-center gap-4 relative" ref={dropdownRef}>
          <div className="relative">
            <button onClick={() => setOpenNotif(!openNotif)} className="relative">
              <Bell size={22} className="text-white" />
              {notifs.some((n) => !n.leida) && (
                <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-4 h-4 flex items-center justify-center rounded-full">
                  {notifs.filter((n) => !n.leida).length}
                </span>
              )}
            </button>

            {openNotif && (
              <div className="absolute right-0 mt-2 w-80 bg-white text-black rounded-xl shadow-lg overflow-hidden z-50">
                <div className="p-3 font-semibold border-b bg-blue-300">Notificaciones</div>
                {notifs.length === 0 ? (
                  <p className="p-3 text-sm text-gray-500">No tienes notificaciones</p>
                ) : (
                  <ul className="max-h-64 overflow-y-auto">
                    {notifs.map((n) => (
                      <li
                        key={n.id_notificacion}
                        className={`flex justify-between items-start p-3 text-sm border-b last:border-none cursor-pointer ${
                          n.leida ? "bg-gray-50" : "bg-indigo-100"
                        }`}
                        onClick={() => marcarLeidaYNavegar(n)}
                      >
                        <div>
                          {n.mensaje}
                          <span className="block text-xs text-purple-800">
                            {new Date(n.fecha).toLocaleString()}
                          </span>
                        </div>
                        {!n.leida && <Check size={16} className="text-green-600 mt-1" />}
                      </li>
                    ))}
                  </ul>
                )}
              </div>
            )}
          </div>

          <div className="flex items-center gap-3 bg-indigo-800 px-3 py-2 rounded-full shadow-md">
            <User size={20} />
            <div className="flex flex-col">
              <span className="font-medium">{nombre || "Invitado"}</span>
              {rol && (
                <span className={`text-xs px-2 py-0.5 rounded-full text-white font-semibold w-fit
                  ${rol === "admin" ? "bg-yellow-500" : "bg-blue-500"}`}>
                  {rol.toUpperCase()}
                </span>
              )}
            </div>
          </div>

          <button onClick={handleLogout} className="text-black bg-blue-400 hover:bg-red-400 px-4 py-2 rounded-lg font-medium transition">
            Logout
          </button>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;
