
import "./Stories.css";

function Stories() {
  return (
    <div className="stories-page">

      {/* Stories for You */}
      <section className="story-section">

        <div className="section-heading">
          <h2>Stories for You</h2>
          <a href="#">See all →</a>
        </div>

        <div className="no-stories">
          No published stories yet.
        </div>

      </section>

      {/* Browse by Format */}
      <section className="story-section">

        <h2 className="section-title">Browse by Format</h2>

        <div className="format-grid">

          <div className="format-card articles">
            <h3>Articles</h3>
            <p>Long-form reading</p>
            <span>→</span>
          </div>

          <div className="format-card videos">
            <h3>Videos</h3>
            <p>Visual essays</p>
            <span>→</span>
          </div>

          <div className="format-card shorts">
            <h3>Shorts</h3>
            <p>Quick insights</p>
            <span>→</span>
          </div>

          <div className="format-card podcasts">
            <h3>Podcasts</h3>
            <p>Audio dialogues</p>
            <span>→</span>
          </div>

          <div className="format-card interviews">
            <h3>Interviews</h3>
            <p>Founder dialogues</p>
            <span>→</span>
          </div>

          <div className="format-card series">
            <h3>Series</h3>
            <p>Curated editions</p>
            <span>→</span>
          </div>

        </div>

      </section>

      {/* Trending Videos */}
      <section className="story-section trending-section">

        <div className="section-heading">
          <h2>Trending Videos</h2>
          <a href="#">See all →</a>
        </div>

        <div className="video-grid">

          <div className="video-card">
            <div className="video-image ai-video">
              <strong>THE AI REVOLUTION</strong>
              <span className="play-button">▶</span>
              <small>12:45</small>
            </div>
            <h3>The AI Revolution Explained Simply</h3>
            <p>Featured editorial • Recent</p>
          </div>

          <div className="video-card">
            <div className="video-image focus-video">
              <span className="play-button">▶</span>
              <small>8:21</small>
            </div>
            <h3>How to Stay Focused in a Distracted World</h3>
            <p>Deep dive • Recent</p>
          </div>

          <div className="video-card">
            <div className="video-image thinking-video">
              <span className="play-button">▶</span>
              <small>10:12</small>
            </div>
            <h3>A New Way of Thinking</h3>
            <p>Perspective • Recent</p>
          </div>

          <div className="video-card">
            <div className="video-image life-video">
              <span className="play-button">▶</span>
              <small>14:36</small>
            </div>
            <h3>Building a Life You're Proud Of</h3>
            <p>Workshop • Recent</p>
          </div>

        </div>

      </section>

    </div>
  );
}

export default Stories;
