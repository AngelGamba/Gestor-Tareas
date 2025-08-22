import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "./pages/Login";
import Tareas from "./pages/Tareas";
import Reportes from "./pages/Reportes";
import Dashboard from "./pages/Dashboard";
import Register from "./pages/Register";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/tareas" element={<Tareas />} />
        <Route path="/reportes" element={<Reportes />} />

      </Routes>
    </BrowserRouter>
  );
}

export default App;
