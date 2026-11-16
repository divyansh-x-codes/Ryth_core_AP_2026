
import { useState } from "react";

import Navbar from "./components/Navbar";
import Home from "./components/Home";
import Stories from "./components/Stories";
import Books from "./components/Books";

import Sidebar from "./Sidebar";
import RightSidebar from "./RightSidebar";

import "./index.css";

function App() {
  const [page, setPage] = useState("HOME");

  return (
    <>
      <Navbar />

      <div className="app-layout">

        <Sidebar page={page} setPage={setPage} />

        <main className="main-content">
          {page === "HOME" && <Home />}
          {page === "STORIES" && <Stories />}
          {page === "BOOKS" && <Books />}
        </main>

        <RightSidebar />

      </div>
    </>
  );
}

export default App;
