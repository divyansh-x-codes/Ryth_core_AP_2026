
import "./Books.css";

function Books() {
  return (
    <div className="books-page">

      {/* Hero Section */}
      <section className="books-hero">

        <div className="books-hero-content">
          <span className="books-tag">✧ CURATED BOOK LIBRARY</span>

          <h1>
            Knowledge for
            <br />
            a better <span>you.</span>
          </h1>

          <div className="books-hero-buttons">
            <button>Explore Books →</button>
            <button className="library-button">▢ My Library</button>
          </div>

          <p>👤 👤 👤 👤 👤 &nbsp; 25K+ readers are learning with RythCore</p>
        </div>

        <div className="books-hero-video">
          <video
            src="/videos/books-hero.mp4"
            autoPlay
            muted
            loop
            playsInline
            controls
          />
        </div>

      </section>

      {/* Categories */}
      <section className="book-categories">
        <button className="category-active">▣<span>All Books</span></button>
        <button>✧<span>Self Improvement</span></button>
        <button>▥<span>Business</span></button>
        <button>▣<span>Technology</span></button>
        <button>♧<span>Mindset</span></button>
        <button>⌁<span>Health</span></button>
        <button>◉<span>Creativity</span></button>
        <button>▣<span>Career</span></button>
        <button>♙<span>Finance</span></button>
      </section>

      {/* Premium Books */}
      <section className="premium-books">

        <div className="premium-heading">
          <div>
            <h2>👑 RYTHCORE PREMIUM MASTERCLASS BOOKS</h2>
            <p>Curated executive breakdowns, high-leverage mental models & private audio summaries.</p>
          </div>

          <button>👑 Unlock with Ryth Club+ →</button>
        </div>

        <div className="premium-grid">

          <div className="premium-book">
            <img src="/images/books/principles.jpg" alt="Principles" />
            <span>🔒 LOCKED</span>
            <h3>Principles: Life and Work</h3>
            <button>🔒 Unlock with Club+</button>
          </div>

          <div className="premium-book">
            <img src="/images/books/high-output.jpg" alt="High Output Management" />
            <span>🔒 LOCKED</span>
            <h3>High Output Management</h3>
            <button>🔒 Unlock with Club+</button>
          </div>

          <div className="premium-book">
            <img src="/images/books/good-to-great.jpg" alt="Good to Great" />
            <span>🔒 LOCKED</span>
            <h3>Good to Great</h3>
            <button>🔒 Unlock with Club+</button>
          </div>

          <div className="premium-book">
            <img src="/images/books/almanack.jpg" alt="The Almanack of Naval Ravikant" />
            <span>🔒 LOCKED</span>
            <h3>The Almanack of Naval Ravikant</h3>
            <button>🔒 Unlock with Club+</button>
          </div>

        </div>
      </section>

      {/* Book Filters */}
      <section className="book-library">

        <div className="book-filter">
          <div className="filter-tabs">
            <button className="filter-active">Recommended</button>
            <button>Bestsellers</button>
            <button>New Arrivals</button>
            <button>Most Saved</button>
            <button>Free Reads</button>
          </div>

          <div className="filter-options">
            <button>Filter ☷</button>
            <select>
              <option>Latest</option>
              <option>Popular</option>
              <option>Oldest</option>
            </select>
          </div>
        </div>

        {/* Book Cards */}
        <div className="book-grid">

          <div className="book-card">
            <img src="/images/books/atomic-habits.jpg" alt="Atomic Habits" />
            <h3>Atomic Habits</h3>
            <p className="book-author">James Clear</p>
            <p>Build better habits and break bad ones with practical strategies.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

          <div className="book-card">
            <img src="/images/books/psychology-of-money.jpg" alt="The Psychology of Money" />
            <h3>The Psychology of Money</h3>
            <p className="book-author">Morgan Housel</p>
            <p>Timeless lessons on wealth, greed and happiness.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

          <div className="book-card">
            <img src="/images/books/zero-to-one.jpg" alt="Zero to One" />
            <h3>Zero to One</h3>
            <p className="book-author">Peter Thiel</p>
            <p>Notes on startups, or how to build the future by creating monopolies.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

          <div className="book-card">
            <img src="/images/books/lean-startup.jpg" alt="The Lean Startup" />
            <h3>The Lean Startup</h3>
            <p className="book-author">Eric Ries</p>
            <p>Build and grow successful startups with lean principles.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

          <div className="book-card">
            <img src="/images/books/startup-books.jpg" alt="Startup books" />
            <h3>Startup Collection</h3>
            <p className="book-author">Various Authors</p>
            <p>Explore ideas and lessons from startup founders.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

          <div className="book-card">
            <img src="/images/books/milk-and-honey.jpg" alt="Milk and Honey" />
            <h3>Milk and Honey</h3>
            <p className="book-author">Rupi Kaur</p>
            <p>A collection of poetry about love, loss and healing.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

          <div className="book-card">
            <img src="/images/books/book-stack.jpg" alt="Book collection" />
            <h3>Reading Collection</h3>
            <p className="book-author">RythCore Picks</p>
            <p>Discover curated books and new perspectives.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

          <div className="book-card">
            <img src="/images/books/mountain.jpg" alt="Mountain landscape" />
            <h3>The Art of Learning</h3>
            <p className="book-author">RythCore Picks</p>
            <p>Learn continuously and develop a growth mindset.</p>
            <div className="book-actions">
              <button>Read</button>
              <button className="save-button">♧</button>
            </div>
          </div>

        </div>
      </section>

    </div>
  );
}

export default Books;
