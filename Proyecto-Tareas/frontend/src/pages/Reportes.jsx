import { useState } from "react";
import api from "../api/axios";
import { useNavigate } from "react-router-dom";
import Layout from "../components/Layout";

function Reportes() {
  const [desde, setDesde] = useState("");
  const [hasta, setHasta] = useState("");
  const [reporte, setReporte] = useState([]);

  const navigate = useNavigate();
  const token = localStorage.getItem("token");
  const headers = { Authorization: `Bearer ${token}` };

  const generarReporte = async (e) => {
    e.preventDefault();
    try {
      const res = await api.get(
        `/tareas/reportes?desde=${desde}&hasta=${hasta}`,
        { headers }
      );
      setReporte(res.data);
    } catch (err) {
      alert("Solo administradores pueden generar reportes");
      navigate("/dashboard");
    }
  };

  return (
    <Layout>
      <div className="min-h-screen pt-20 bg-gradient-to-br from-blue-500 to-purple-200">
        <h2 className="text-3xl font-bold p-10 text-center text-black mb-2">
          📊 Reportes de Tareas
        </h2>

        <form
          onSubmit={generarReporte}
          className="bg-white p-6 rounded-xl shadow-md mb-6 flex gap-4 items-end"
        >
          <div>
            <label className="block text-gray-600 text-sm mb-1">Desde</label>
            <input
              type="date"
              value={desde}
              onChange={(e) => setDesde(e.target.value)}
              required
              className="border ring-1 rounded-lg p-2 w-full"
            />
          </div>
          <div>
            <label className="block text-gray-600 text-sm mb-1">Hasta</label>
            <input
              type="date"
              value={hasta}
              onChange={(e) => setHasta(e.target.value)}
              required
              className="border ring-1 rounded-lg p-2 w-full"
            />
          </div>
          <button
            type="submit"
            className="bg-blue-600 hover:bg-purple-500 text-white px-4 py-2 rounded-lg transition"
          >
            Generar
          </button>
        </form>

        {reporte.length > 0 && (
          <div className="bg-white p-6 rounded-xl shadow-md">
            <h4 className="text-lg font-semibold mb-4">Resultados</h4>
            <ul className="space-y-3">
              {reporte.map((r) => (
                <li
                  key={r.id_tarea}
                  className="p-4 bg-gray-50 rounded-lg border border-gray-200"
                >
                  <b>{r.titulo}</b> - {r.descripcion}{" "}
                  <span className="text-sm text-gray-600">({r.estado})</span>
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>
      </Layout>
  );
}

export default Reportes;
