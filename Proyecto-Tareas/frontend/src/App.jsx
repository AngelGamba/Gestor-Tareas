import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import Login from "./pages/Login";
import Tareas from "./pages/Tareas";
import Reportes from "./pages/Reportes";
import Dashboard from "./pages/Dashboard";
import Register from "./pages/Register";
import Buscar from "./pages/Buscar";
import Usuarios from "./pages/Usuarios";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/home" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/tareas" element={<Tareas />} />
        <Route path="/buscar" element={<Buscar />} />
        <Route path="/reportes" element={<Reportes />} />
        <Route path="/usuarios" element={<Usuarios />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
