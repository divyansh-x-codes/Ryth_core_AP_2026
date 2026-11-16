
import "./Sidebar.css";

function Sidebar({ page, setPage }) {
  return (
    <aside className="sidebar">

      <div className="sidebar-menu">

        <button
          className={`sidebar-item ${page === "HOME" ? "active" : ""}`}
          onClick={() => setPage("HOME")}
        >
          <span className="sidebar-icon">⌂</span>
          HOME
        </button>

        <button
          className={`sidebar-item ${page === "STORIES" ? "active" : ""}`}
          onClick={() => setPage("STORIES")}
        >
          <span className="sidebar-icon">▤</span>
          STORIES
        </button>

        <button className="sidebar-item">
          <span className="sidebar-icon">♧</span>
          LEARN
          <span className="sidebar-badge">SOON</span>
        </button>

        <button
          className={`sidebar-item ${page === "BOOKS" ? "active" : ""}`}
          onClick={() => setPage("BOOKS")}
        >
          <span className="sidebar-icon">▣</span>
          BOOKS
        </button>

        <button className="sidebar-item">
          <span className="sidebar-icon">♛</span>
          RYTH CLUB
        </button>

        <button className="sidebar-item">
          <span className="sidebar-icon">▢</span>
          MESSAGES
        </button>

        <button className="sidebar-item">
          <span className="sidebar-icon">♙</span>
          PROFILE
        </button>

      </div>

      <div className="club-card">
        <h3>♛ RYTH CLUB+</h3>

        <p>
          Unlock exclusive groups, live sessions,
          events and premium community.
        </p>

        <button className="club-button">
          JOIN NOW →
        </button>
      </div>

    </aside>
  );
}

export default Sidebar;
