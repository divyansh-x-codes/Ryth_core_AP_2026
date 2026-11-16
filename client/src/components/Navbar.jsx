
import "./Navbar.css";

function Navbar() {
  return (
    <nav className="navbar">

      {/* Logo */}
      <div className="navbar-logo">
        <div className="logo-icon">R</div>
        <h2>
          Ryth<span>Core</span>
        </h2>
      </div>

      {/* Search */}
      <div className="navbar-search">
        <span>⌕</span>
        <input
          type="text"
          placeholder="Search stories, topics, or writers..."
        />
        <kbd>⌘ K</kbd>
      </div>

      {/* Editorial */}
      <div className="navbar-editorial">
        <div className="editorial-icon">✧</div>
        <div>
          <strong>Ryth Editorial</strong>
          <small>Perspective Network</small>
        </div>
      </div>

      {/* Write */}
      <button className="navbar-write">
        <span>✎</span>
        Write
      </button>

      {/* Profile */}
      <div className="navbar-profile">
        <div className="profile-avatar">S</div>
        <strong>Simply</strong>
        <span>⌄</span>
      </div>

    </nav>
  );
}

export default Navbar;
