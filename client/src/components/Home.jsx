
import "./Home.css";

function Home() {
  return (
    <div className="home-page">

      {/* Hero Section */}
      <section className="hero">

        <div className="hero-content">

          <div className="hero-tag">
            ✧ IDEAS • PEOPLE • PERSPECTIVES
          </div>

          <h1>
            A place for the
            <br />
            curious <em>mind.</em>
          </h1>

          <div className="hero-buttons">
            <button className="explore-button">
              Explore Stories →
            </button>

            <button className="watch-button">
              ⏵ Watch Intro
            </button>
          </div>

          <div className="hero-footer">
            <div className="hero-avatars">
              <span>D</span>
              <span>R</span>
              <span>S</span>
            </div>

            <p>
              Curious minds & writers sharing perspectives
            </p>
          </div>

        </div>
      </section>

      {/* Categories */}
      <div className="category-bar">

        <div className="categories">
          <button className="selected">For you</button>
          <button>Technology</button>
          <button>Business</button>
          <button>Mindset</button>
          <button>Health</button>
          <button>Culture</button>
          <button>Creativity</button>
          <button>Career</button>
        </div>

        <select className="sort-select">
          <option>Latest</option>
          <option>Popular</option>
          <option>Oldest</option>
        </select>

      </div>

      {/* Stories */}
      <section className="stories-empty">

        <div className="empty-icon">✧</div>

        <h2>No stories published yet</h2>

        <p>
          All demo data has been cleared. Be the first to publish a
          <br />
          new story and share your perspective.
        </p>

        <button className="write-story-button">
          Write a Story →
        </button>

      </section>

    </div>
  );
}

export default Home;
