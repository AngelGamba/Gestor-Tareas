import { useState, useEffect, useRef } from "react";
import api from "../api/axios";
import { useNavigate, useLocation } from "react-router-dom";
import Layout from "../components/Layout";
import { Edit, Trash2, XCircle } from "lucide-react";

function Tareas() {
  const [tareas, setTareas] = useState([]);
  const [titulo, setTitulo] = useState("");
  const [descripcion, setDescripcion] = useState("");
  const [fechaVencimiento, setFechaVencimiento] = useState("");
  const [usuarios, setUsuarios] = useState([]);

  const navigate = useNavigate();
  const location = useLocation();

  const token = localStorage.getItem("token");
  const idUsuario = parseInt(localStorage.getItem("id_usuario"));
  const headers = { Authorization: `Bearer ${token}` };

  const taskRefs = useRef({});
  const scrolledRef = useRef(false);
  const clearTimerRef = useRef(null);

  // Estado del highlight
  const [highlightTarget, setHighlightTarget] = useState(null); // id de tarea
  const [highlightActive, setHighlightActive] = useState(false); // si está encendido

  // Lee ?highlight= cuando cambia la URL
  useEffect(() => {
    const q = new URLSearchParams(location.search);
    const h = q.get("highlight");
    if (h) {
      setHighlightTarget(Number(h));
      setHighlightActive(true);   // 🔥 enciende highlight
      scrolledRef.current = false; // permitir scroll una sola vez para este highlight
    }
  }, [location.search]);

  // Efecto: hacer scroll y apagar a los 2s
  useEffect(() => {
    if (!highlightTarget || !highlightActive) return;

    const el = taskRefs.current[highlightTarget];
    if (!el) return; // aún no renderiza la lista

    if (!scrolledRef.current) {
      scrolledRef.current = true;
      el.scrollIntoView({ behavior: "smooth", block: "center" });
    }

    // Apagar highlight a los 2s SIEMPRE (vengas de donde vengas)
    if (clearTimerRef.current) clearTimeout(clearTimerRef.current);
    clearTimerRef.current = setTimeout(() => {
      setHighlightActive(false);                // quita clases (deja de titilar y quita anillo)
      setHighlightTarget(null);                 // limpia id por si acaso
      navigate("/tareas", { replace: true });   // limpia el query param
    }, 2000);

    return () => {
      if (clearTimerRef.current) clearTimeout(clearTimerRef.current);
    };
  }, [highlightTarget, highlightActive, navigate, tareas]);

  // ------- Data -------
  const fetchTareas = async () => {
    try {
      const res = await api.get("/tareas", { headers });
      setTareas(res.data);
    } catch (err) {
      if (err.response?.status === 401) navigate("/login");
      else console.error(err);
    }
  };

  const fetchUsuarios = async () => {
    try {
      const res = await api.get("/usuarios", { headers });
      setUsuarios(res.data);
    } catch (err) {
      console.error("Error al traer usuarios", err);
    }
  };

  useEffect(() => {
    fetchTareas();
    fetchUsuarios();
  }, []);

  // ------- Acciones -------
  const crearTarea = async (e) => {
    e.preventDefault();
    try {
      const payload = { titulo, descripcion };
      if (fechaVencimiento) payload.fecha_vencimiento = fechaVencimiento;
      await api.post("/tareas", payload, { headers });
      setTitulo(""); setDescripcion(""); setFechaVencimiento("");
      fetchTareas();
    } catch (e) {
      alert(e.response?.data?.error || "No se pudo crear la tarea");
    }
  };

  const editarTarea = async (id_tarea) => {
    const nuevoTitulo = prompt("Nuevo título:");
    const nuevaDescripcion = prompt("Nueva descripción:");
    const nuevaFecha = prompt("Nueva fecha (YYYY-MM-DD) o deja vacío para quitar:");
    try {
      await api.put(`/tareas/${id_tarea}`, {
        titulo: nuevoTitulo, descripcion: nuevaDescripcion, fecha_vencimiento: nuevaFecha || null
      }, { headers });
      fetchTareas();
    } catch (e) {
      alert(e.response?.data?.error || "No se pudo editar la tarea");
    }
  };

  const eliminarTarea = async (id_tarea) => {
    if (!window.confirm("¿Seguro que deseas eliminar/salir de esta tarea?")) return;
    try {
      await api.delete(`/tareas/${id_tarea}`, { headers });
      fetchTareas();
    } catch (e) {
      alert(e.response?.data?.error || "No se pudo eliminar la tarea");
    }
  };

  const asignarTarea = async (id_tarea, id_usuario_asignado) => {
    const idNum = Number(id_usuario_asignado);
    if (!idNum) return;
    try {
      await api.put(`/tareas/${id_tarea}/asignar`, { id_usuario_asignado: idNum }, { headers });
      fetchTareas();
    } catch (e) {
      alert("No se pudo asignar la tarea");
    }
  };

  const cambiarEstado = async (id_tarea, estado) => {
    try {
      await api.put(`/tareas/${id_tarea}/estado`, { estado }, { headers });
      fetchTareas();
    } catch (e) {
      alert("No se pudo cambiar el estado");
    }
  };

  const todayISO = new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
    .toISOString().slice(0, 10);

  return (
    <Layout>
      <div className="min-h-screen pt-20 p-20 bg-gradient-to-br from-blue-500 to-purple-200">
        <h2 className="text-3xl font-bold p-10 text-center text-black mb-2">📌 Gestor de Tareas</h2>

        {/* Crear tarea */}
        <div className="bg-white p-6 rounded-xl shadow-lg mb-8">
          <h3 className="text-xl font-semibold text-black mb-4">➕ Crear nueva tarea</h3>
          <form onSubmit={crearTarea} className="flex flex-col md:flex-row gap-4">
            <input type="text" placeholder="Título" value={titulo} onChange={(e) => setTitulo(e.target.value)}
              className="flex-1 px-4 py-2 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white" required />
            <input type="text" placeholder="Descripción" value={descripcion} onChange={(e) => setDescripcion(e.target.value)}
              className="flex-1 px-4 py-2 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white" required />
            <input type="date" value={fechaVencimiento} onChange={(e) => setFechaVencimiento(e.target.value)}
              min={todayISO} className="px-4 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white" />
            <button type="submit" className="bg-blue-600 hover:bg-purple-500 text-white px-6 py-2 rounded-lg font-medium transition">
              Crear
            </button>
          </form>
        </div>

        {/* Listado tareas */}
        <h3 className="text-2xl font-semibold text-black mb-4">📋 Mis tareas</h3>
        <ul className="space-y-4">
          {tareas.map((t) => {
            const isHighlighted = highlightActive && highlightTarget === t.id_tarea;
            return (
              <li
                key={t.id_tarea}
                ref={(el) => (taskRefs.current[t.id_tarea] = el)}
                tabIndex={-1}
                className={`bg-white shadow-md rounded-xl p-5 border hover:shadow-xl transition ${
                  isHighlighted ? "ring-4 ring-purple-700 animate-[pulse_2s_ease-in-out_1]" : ""
                }`}
              >
                <div className="flex justify-between items-center">
                  <div>
                    <h4 className="text-lg font-semibold text-blue-700">{t.titulo}</h4>
                    <p className="text-gray-600">{t.descripcion}</p>
                    <p className="text-sm text-purple-500 mt-1">
                      Creada por: {t.creador?.nombre} | Asignada a: {t.asignado?.nombre || "Nadie"}
                    </p>
                    <p className="text-sm text-red-500 mt-1">
                      Vence: {t.fecha_vencimiento ? new Date(t.fecha_vencimiento).toISOString().split("T")[0] : "Sin fecha"}
                    </p>
                  </div>
                  <span className={`px-3 py-1 rounded-full text-sm font-medium ${
                    t.estado === "pendiente" ? "bg-yellow-100 text-yellow-700"
                      : t.estado === "en progreso" ? "bg-blue-100 text-blue-700"
                      : "bg-green-100 text-green-700"
                  }`}>
                    {t.estado}
                  </span>
                </div>

                <div className="flex gap-2 mt-4">
                  {t.creador?.id_usuario === idUsuario && (
                    <select onChange={(e) => asignarTarea(t.id_tarea, e.target.value)}
                      className="px-2 py-2 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white">
                      <option value="">Asignar a...</option>
                      {usuarios.filter((u) => u.id_usuario !== idUsuario).map((u) => (
                        <option key={u.id_usuario} value={u.id_usuario}>{u.nombre}</option>
                      ))}
                    </select>
                  )}

                  {t.asignado?.id_usuario === idUsuario && (
                    <select onChange={(e) => cambiarEstado(t.id_tarea, e.target.value)} value={t.estado}
                      className="px-2 py-2 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white">
                      <option value="pendiente">Pendiente</option>
                      <option value="en progreso">En progreso</option>
                      <option value="completada">Completada</option>
                    </select>
                  )}

                  {t.creador?.id_usuario === idUsuario && (
                    <button onClick={() => editarTarea(t.id_tarea)}
                      className="flex items-center bg-blue-200 hover:bg-purple-200 text-black px-4 mx-1 ring-2 rounded-lg font-medium transition shadow">
                      <Edit className="w-6 h-4" /> Editar
                    </button>
                  )}

                  <button onClick={() => eliminarTarea(t.id_tarea)}
                    className="flex items-center gap-1 px-4 py-2 rounded-lg font-medium transition shadow bg-gradient-to-br from-blue-600 to-purple-500 text-white">
                    {t.creador?.id_usuario === idUsuario
                      ? (<><Trash2 className="w-4 h-4" /> Eliminar</>)
                      : (<><XCircle className="w-4 h-4" /> Salir</>)}
                  </button>
                </div>
              </li>
            );
          })}
        </ul>
      </div>
    </Layout>
  );
}

export default Tareas;
