
import "./RightSidebar.css";

function RightSidebar() {
  return (
    <aside className="right-sidebar">

      {/* Today's Thought */}
      <div className="right-card">
        <h3>TODAY'S THOUGHT</h3>

        <div className="thought-content">
          <div className="quote-icon">❞</div>

          <p>
            "Discipline is not about doing what you
            love, but about doing what your future
            self will thank you for."
          </p>

          <strong>— RythCore</strong>
        </div>
      </div>

      {/* Trending */}
      <div className="right-card">
        <h3>TRENDING THIS WEEK</h3>

        <div className="empty-content">
          No trending stories yet.
        </div>
      </div>

      {/* Top Creators */}
      <div className="right-card">
        <h3>TOP CREATORS</h3>

        <div className="empty-content">
          No creators found.
        </div>
      </div>

      {/* RythCore Picks */}
      <div className="right-card">
        <h3>RYTHCORE PICKS</h3>

        <div className="empty-content">
          Curated perspectives coming soon.
        </div>
      </div>

    </aside>
  );
}

export default RightSidebar;
