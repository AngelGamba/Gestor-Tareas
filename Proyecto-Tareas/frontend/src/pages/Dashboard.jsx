import { useEffect, useState } from "react";
import api from "../api/axios";
import { useNavigate } from "react-router-dom";
import { BarChart, Bar, XAxis,YAxis, Tooltip, ResponsiveContainer, PieChart, Pie, Cell, Legend, } from "recharts";
import Layout from "../components/Layout";

function Dashboard() {
  const [stats, setStats] = useState({
    total: 0,
    pendientes: 0,
    progreso: 0,
    completadas: 0,
  });

  const [desde, setDesde] = useState("");
  const [hasta, setHasta] = useState("");

  const navigate = useNavigate();
  const token = localStorage.getItem("token");
  const headers = { Authorization: `Bearer ${token}` };

  const fetchStats = async () => {
    try {
    let url = "/tareas";
      // si hay fechas, filtramos desde backend
      if (desde && hasta) {
        url = `/tareas/reportes?desde=${desde}&hasta=${hasta}`;
      }

      const res = await api.get("/tareas", { headers });
      const tareas = res.data;

      const total = tareas.length;
      const pendientes = tareas.filter((t) => t.estado === "pendiente").length;
      const progreso = tareas.filter((t) => t.estado === "en progreso").length;
      const completadas = tareas.filter((t) => t.estado === "completada").length;

      setStats({ total, pendientes, progreso, completadas });
    } catch (err) {
      if (err.response?.status === 401) navigate("/login");
    }
  };

  useEffect(() => {
    fetchStats();
  }, [desde, hasta]);

  const dataBar = [
    { name: "Pendientes", value: stats.pendientes },
    { name: "En Progreso", value: stats.progreso },
    { name: "Completadas", value: stats.completadas },
  ];

  const COLORS = ["#f59e0b", "#3b82f6", "#10b981"]; // Amarillo, Azul, Verde

  return (
    <Layout>
      <div className="min-h-screen pt-20 bg-gradient-to-br from-blue-500 to-purple-200">
        <h2 className="text-3xl font-bold p-10 text-center text-black mb-2">
          📊 Panel de Control
        </h2>

        {/* Filtro por fechas */}
        <div className="bg-white p-6 rounded-xl shadow-md mb-10 flex flex-col sm:flex-row items-center gap-4">
            <h3 className="text-xl font-semibold text-black mb-4">Crear nueva tarea</h3>
          <div>
            <label className="block text-sm font-medium text-indigo-700">
              Desde
            </label>
            <input
              type="date"
              value={desde}
              onChange={(e) => setDesde(e.target.value)}
              className="mt-1 border rounded-lg px-3 py-2 text-gray-700 ring-1 focus:ring focus:ring-indigo-300"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-indigo-700">
              Hasta
            </label>
            <input
              type="date"
              value={hasta}
              onChange={(e) => setHasta(e.target.value)}
              className="mt-1 border rounded-lg px-3 py-2 text-gray-700 ring-1 focus:ring focus:ring-indigo-300"
            />
          </div>
          <button
            onClick={fetchStats}
            className="text-white px-4 py-2 rounded-lg bg-blue-600 hover:bg-purple-500 shadow transition"
          >
            Filtrar
          </button>
          <button
            onClick={() => {
              setDesde("");
              setHasta("");
            }}
            className="text-white px-4 py-2 rounded-lg bg-gray-600 hover:bg-gray-500 shadow transition"
          >
            Reset
          </button>
        </div>

        {/* Cards con métricas */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 ">
          <div className="bg-white p-6 rounded-xl shadow-md border-l-4 border-purple-500">
            <h3 className="text-lg font-semibold text-indigo-700">Total Tareas</h3>
            <p className="text-3xl font-bold text-purple-700">{stats.total}</p>
          </div>

          <div className="bg-white p-6 rounded-xl shadow-md border-l-4 border-yellow-500">
            <h3 className="text-lg font-semibold text-indigo-700">Pendientes</h3>
            <p className="text-3xl font-bold text-yellow-600">{stats.pendientes}</p>
          </div>

          <div className="bg-white p-6 rounded-xl shadow-md border-l-4 border-blue-500">
            <h3 className="text-lg font-semibold text-indigo-700">En Progreso</h3>
            <p className="text-3xl font-bold text-blue-600">{stats.progreso}</p>
          </div>

          <div className="bg-white p-6 rounded-xl shadow-md border-l-4 border-green-500">
            <h3 className="text-lg font-semibold text-indigo-700">Completadas</h3>
            <p className="text-3xl font-bold text-green-600">{stats.completadas}</p>
          </div>
        </div>

        {/* Gráficas */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 pt-10">
          {/* Gráfico de barras */}
          <div className="bg-white p-6 rounded-xl shadow-md">
            <h3 className="text-lg font-semibold text-indigo-700">
              Tareas por estado
            </h3>
            <ResponsiveContainer width="100%" height={300}>
              <BarChart data={dataBar}>
                <XAxis dataKey="name" />
                <YAxis allowDecimals={false} />
                <Tooltip />
                <Bar dataKey="value" radius={[8, 8, 0, 0]}>
                  {dataBar.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index]} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>

          {/* Gráfico de pastel */}
          <div className="bg-white p-6 rounded-xl shadow-md">
            <h3 className="text-lg font-semibold text-indigo-700">
              Distribución de tareas
            </h3>
            <ResponsiveContainer width="100%" height={300}>
              <PieChart>
                <Pie
                  data={dataBar}
                  dataKey="value"
                  nameKey="name"
                  outerRadius={100}
                  label
                >
                  {dataBar.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index]} />
                  ))}
                </Pie>
                <Legend />
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>
    </Layout>
  );
}

export default Dashboard;

