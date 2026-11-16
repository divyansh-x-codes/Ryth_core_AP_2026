# RythCore – Database Normalization Project (1NF, 2NF, 3NF & BCNF)

**Course:** Database Management Systems (DBMS)  
**Case Study Platform:** RythCore (Digital Publishing & Creator Platform)  
**Document:** Academic Project Documentation & Schema Analysis  

---

## Table of Contents
1. [Introduction](#1-introduction)
2. [Project Objective](#2-project-objective)
3. [Database Overview](#3-database-overview)
4. [Functional Dependencies](#4-functional-dependencies)
5. [First Normal Form (1NF)](#5-first-normal-form-1nf)
6. [Second Normal Form (2NF)](#6-second-normal-form-2nf)
7. [Third Normal Form (3NF)](#7-third-normal-form-3nf)
8. [Boyce-Codd Normal Form (BCNF)](#8-boyce-codd-normal-form-bcnf)
9. [Final Conclusion](#9-final-conclusion)

---

## 1. Introduction

A **Database Management System (DBMS)** is specialized software designed to define, manipulate, retrieve, and manage data systematically in a computer database. The primary goal of a relational DBMS is to provide an environment that is both convenient and efficient for handling structured data while guaranteeing data integrity, security, and concurrency.

### RythCore: Case Study Overview
**RythCore** is a modern digital publishing, reading, and content discovery platform. On RythCore:
- Readers discover and consume curated articles, stories, and editorial perspectives.
- Writers publish original literary pieces and essays.
- Community members interact by liking stories, saving bookmarks, and writing constructive comments.
- Readers subscribe to premium membership plans (Ryth Club+) and complete digital payments to unlock exclusive essays and summaries.

Managing high volumes of concurrent read and write transactions in a publishing network requires an architecturally sound relational schema. If a publishing database is unorganized, simple operations like updating an author's profile or categorizing a story can duplicate data, slow down queries, and corrupt database state. Normalization provides the formal mathematical framework to structure RythCore's relational tables.

---

## 2. Project Objective

The objective of this project is to apply formal **Database Normalization Theory** to the RythCore relational database design. Specifically, this documentation demonstrates:

1. How an unnormalized publishing log containing multi-valued fields is converted into **First Normal Form (1NF)**.
2. How composite-key interaction tables (such as likes and bookmarks) are verified and decomposed to achieve **Second Normal Form (2NF)** by eliminating partial functional dependencies.
3. How entity groupings (such as stories, categories, and subscription plans) are refined into **Third Normal Form (3NF)** by eliminating transitive dependencies.
4. How overlapping candidate keys in editorial assignments are evaluated against **Boyce-Codd Normal Form (BCNF)** to eliminate anomalies where non-superkeys act as determinants.

### Why Normalization Matters for RythCore
- **Eliminating Redundancy:** Preventing author bios, category descriptions, and subscription pricing from being duplicated across thousands of story and payment records.
- **Preventing Anomalies:**
  - *Insertion Anomaly:* Ensuring new categories or subscription tiers can exist before any story or user is attached to them.
  - *Update Anomaly:* Modifying a user's email or a category name in one single record without leaving conflicting copies across the database.
  - *Deletion Anomaly:* Ensuring that removing a story does not accidentally delete the author's user account or the entire genre category.
- **Ensuring Data Consistency:** Guaranteeing a single source of truth for transactional records like payments and subscriptions.

---

## 3. Database Overview

The core architecture of RythCore is modeled around eight relational tables:

```
┌─────────────┐       ┌──────────────┐       ┌────────────────┐
│    Users    │──────<│   Stories    │>──────│   Categories   │
└─────────────┘       └──────────────┘       └────────────────┘
   │     │                │   │   │
   │     │       ┌────────┘   │   └────────┐
   │     │       │            │            │
   │     ▼       ▼            ▼            ▼
   │  ┌─────────────┐   ┌───────────┐   ┌──────────────┐
   │  │    Likes    │   │ Bookmarks │   │   Comments   │
   │  └─────────────┘   └───────────┘   └──────────────┘
   │
   ▼
┌─────────────┐       ┌──────────────┐
│Subscriptions│──────<│   Payments   │
└─────────────┘       └──────────────┘
```

### Table 1: `Users`
Stores authentication, identification, and permission profiles for all platform participants (readers, authors, editors, administrators).
- `user_id` **(Primary Key)**: Unique identifier for each registered user.
- `name`: Full display name of the user.
- `email`: Unique email address used for login and notifications.
- `role`: Access level (`reader`, `author`, `editor`, `admin`).

### Table 2: `Categories`
Classifies stories into discoverable genres and editorial themes (e.g., Technology, Philosophy, Business).
- `category_id` **(Primary Key)**: Unique identifier for the genre.
- `category_name`: Name of the genre/category.

### Table 3: `Stories`
The central content repository containing published articles and essays.
- `story_id` **(Primary Key)**: Unique identifier for each story.
- `title`: Headline of the article.
- `content`: Full text body of the story.
- `author_id` **(Foreign Key)**: References `Users(user_id)`.
- `category_id` **(Foreign Key)**: References `Categories(category_id)`.
- `visibility`: Publication state (`draft`, `public`, `members_only`).

### Table 4: `Likes`
Records reader appreciation and engagement for stories.
- `like_id` **(Primary Key)**: Unique identifier for the like interaction record.
- `user_id` **(Foreign Key)**: References `Users(user_id)`.
- `story_id` **(Foreign Key)**: References `Stories(story_id)`.

### Table 5: `Bookmarks`
Stores a user's personal reading list for offline or future reading.
- `bookmark_id` **(Primary Key)**: Unique identifier for the bookmark record.
- `user_id` **(Foreign Key)**: References `Users(user_id)`.
- `story_id` **(Foreign Key)**: References `Stories(story_id)`.

### Table 6: `Comments`
Enables discussion and feedback on published stories.
- `comment_id` **(Primary Key)**: Unique identifier for the comment.
- `user_id` **(Foreign Key)**: References `Users(user_id)`.
- `story_id` **(Foreign Key)**: References `Stories(story_id)`.
- `comment_text`: Content of the reader's comment.

### Table 7: `Subscriptions`
Tracks premium memberships (Ryth Club+) purchased by readers.
- `subscription_id` **(Primary Key)**: Unique identifier for the subscription.
- `user_id` **(Foreign Key)**: References `Users(user_id)`.
- `plan_name`: Tier name (e.g., `Club Monthly`, `Club Annual`).
- `status`: Current state (`active`, `cancelled`, `expired`).
- `start_date`: Date the membership began.
- `end_date`: Date the membership lapses or renews.

### Table 8: `Payments`
Records financial transactions associated with subscription billing.
- `payment_id` **(Primary Key)**: Unique identifier for the financial transaction.
- `subscription_id` **(Foreign Key)**: References `Subscriptions(subscription_id)`.
- `amount`: Monetary value billed in decimal currency.
- `payment_status`: Outcome (`succeeded`, `pending`, `failed`).
- `payment_date`: Timestamp of the transaction.

---

## 4. Functional Dependencies

A **Functional Dependency (FD)** is a relationship between attributes in a relation. For attribute sets X and Y, the notation **X → Y** means that the value of X uniquely determines the value of Y. If two rows share the same value for X, they must share the same value for Y.

### Functional Dependencies in RythCore Tables

#### 1. `Users`
- `user_id → name, email, role`
- `email → user_id, name, role`
- **Candidate Keys:** `{user_id}`, `{email}`
- **Primary Key:** `user_id`

#### 2. `Categories`
- `category_id → category_name`
- **Candidate Key:** `{category_id}`, `{category_name}`
- **Primary Key:** `category_id`

#### 3. `Stories`
- `story_id → title, content, author_id, category_id, visibility`
- **Candidate Key:** `{story_id}`
- **Primary Key:** `story_id`
- **Foreign Keys:** `author_id` references `Users(user_id)`, `category_id` references `Categories(category_id)`

#### 4. `Likes`
- `like_id → user_id, story_id`
- `(user_id, story_id) → like_id` *(A user can like a specific story at most once)*
- **Candidate Keys:** `{like_id}`, `{(user_id, story_id)}`
- **Composite Candidate Key:** `(user_id, story_id)`

#### 5. `Bookmarks`
- `bookmark_id → user_id, story_id`
- `(user_id, story_id) → bookmark_id` *(A user bookmarks a specific story once)*
- **Candidate Keys:** `{bookmark_id}`, `{(user_id, story_id)}`
- **Composite Candidate Key:** `(user_id, story_id)`

#### 6. `Comments`
- `comment_id → user_id, story_id, comment_text`
- **Candidate Key:** `{comment_id}`
- **Primary Key:** `comment_id`

#### 7. `Subscriptions`
- `subscription_id → user_id, plan_name, status, start_date, end_date`
- **Candidate Key:** `{subscription_id}`
- **Primary Key:** `subscription_id`

#### 8. `Payments`
- `payment_id → subscription_id, amount, payment_status, payment_date`
- **Candidate Key:** `{payment_id}`
- **Primary Key:** `payment_id`

---

## 5. First Normal Form (1NF)

### 5.1 Definition & Rules of 1NF
A relation R is in **First Normal Form (1NF)** if and only if:
1. Every attribute value is strictly **atomic (indivisible)**.
2. There are **no repeating groups**, arrays, or multi-valued lists stored in a single cell.
3. Every column has a unique attribute name.
4. Each record is uniquely identifiable by a designated Primary Key.

### 5.2 Explanation Using RythCore
In an early design of RythCore, an editor might attempt to record a story along with its multiple tags/topics in a single unnormalized spreadsheet:

```text
Story_Publishing_Log (
    story_id, title, author_name, tags
)
```

Here, an author assigns multiple tags to a story (such as `"Technology, AI, Philosophy"`). Storing these tags as a comma-separated string directly violates 1NF because the `tags` column contains multiple values within a single tuple.

### 5.3 Before-Normalization Table (Violates 1NF)

#### Table: `Story_Publishing_Log`

| story_id | title | author_name | tags (Violates 1NF) |
| :--- | :--- | :--- | :--- |
| ST01 | The Future of AI Writing | Aarav Sharma | Technology, Artificial Intelligence, Future |
| ST02 | Stoic Leadership in Startups | Priya Nair | Philosophy, Leadership |
| ST03 | Clean Code Architecture | Rohan Mehta | Engineering, Software |

#### Operational Problems:
- Searching for stories tagged with `"Technology"` requires slow wild-card string operations (`LIKE '%Technology%'`), ignoring database index lookups.
- Cannot establish foreign key constraints on individual tags.
- Counting the number of stories under `"Artificial Intelligence"` cannot be done with standard SQL `COUNT()` without custom string splitting.

---

### 5.4 After-Normalization Table (1NF Compliant)
To achieve 1NF, every multi-valued attribute is flattened into distinct atomic tuples.

#### Table: `Story_Tag_Atomic`
- **Composite Primary Key:** `(story_id, tag_name)`

| story_id [PK] | title | author_name | tag_name [PK] |
| :--- | :--- | :--- | :--- |
| ST01 | The Future of AI Writing | Aarav Sharma | Technology |
| ST01 | The Future of AI Writing | Aarav Sharma | Artificial Intelligence |
| ST01 | The Future of AI Writing | Aarav Sharma | Future |
| ST02 | Stoic Leadership in Startups | Priya Nair | Philosophy |
| ST02 | Stoic Leadership in Startups | Priya Nair | Leadership |
| ST03 | Clean Code Architecture | Rohan Mehta | Engineering |
| ST03 | Clean Code Architecture | Rohan Mehta | Software |

---

### 5.5 Step-by-Step Explanation
1. **Identify Multi-Valued Attributes:** Notice that `tags` contains comma-separated values in individual rows.
2. **Flatten into Discrete Tuples:** Decompose the list so that each tag occupies its own row, paired with the identifying `story_id`.
3. **Establish a Composite Primary Key:** Because `story_id` now repeats for multiple tags, `story_id` alone is no longer unique. The composite pair `(story_id, tag_name)` uniquely identifies each tuple.

### 5.6 Result
The relation is now in **1NF**. All attribute domains consist purely of atomic scalar values, allowing SQL indexes to function and relational queries to execute cleanly.

---

## 6. Second Normal Form (2NF)

### 6.1 Definition & Rules of 2NF
A relation R is in **Second Normal Form (2NF)** if and only if:
1. It is already in **First Normal Form (1NF)**.
2. **No non-prime attribute is partially functionally dependent on any candidate key.** Every non-key attribute must be fully functionally dependent on the entire primary key.

### 6.2 Understanding Partial Functional Dependency
A **Partial Dependency** occurs when a relation has a **composite candidate key** (A, B), and a non-key column C depends on only a proper subset of that key (A → C or B → C) rather than the full key (A, B) → C.

> 💡 **Key DBMS Rule:** If a table's primary key consists of a **single column**, the table is **automatically in 2NF** because a single column has no proper subsets to form a partial dependency!

### 6.3 Example Using a RythCore Composite Key Relationship
In RythCore, consider reader interactions. Suppose an engineer designs a combined `User_Story_Engagement` table using the natural composite key `(user_id, story_id)` to track likes, reading status, user names, and story titles:

- **Composite Primary Key:** `(user_id, story_id)`
- **Attributes:** `user_id`, `story_id`, `user_name`, `story_title`, `interaction_type`, `liked_at`

### 6.4 Before-Normalization Table (Violates 2NF)

#### Table: `User_Story_Engagement`

| user_id [PK] | story_id [PK] | user_name (Partial) | story_title (Partial) | interaction_type | liked_at |
| :--- | :--- | :--- | :--- | :--- | :--- |
| U101 | ST01 | Aarav | The Future of AI Writing | LIKE | 2026-11-10 10:00 |
| U101 | ST02 | Aarav | Stoic Leadership in Startups | BOOKMARK | 2026-11-11 11:30 |
| U102 | ST01 | Priya | The Future of AI Writing | LIKE | 2026-11-12 09:15 |
| U103 | ST01 | Rohan | The Future of AI Writing | LIKE | 2026-11-12 14:20 |

#### Dependency Breakdown:
- `(user_id, story_id) → interaction_type, liked_at` ⟹ **Full Functional Dependency** (Both user and story are required to determine when and how the interaction happened).
- `user_id → user_name` ⟹ **Partial Dependency** (`user_name` depends only on `user_id`, regardless of what story is liked).
- `story_id → story_title` ⟹ **Partial Dependency** (`story_title` depends only on `story_id`, regardless of who liked it).

#### Operational Anomalies:
- **Redundancy:** Every time 1,000 users like story `ST01`, the title `"The Future of AI Writing"` is duplicated 1,000 times.
- **Update Anomaly:** If the author updates the story title, every single like and bookmark row across the database must be updated.
- **Insertion Anomaly:** A new registered user who hasn't liked any stories yet cannot have their name recorded in this table because `story_id` would be `NULL`, violating the Entity Integrity Rule.

---

### 6.5 After-Normalization Tables (2NF Compliant)
We isolate the partial determinants into their own entity tables:

#### Table 1: `Users` (2NF)
- **Primary Key:** `user_id`

| user_id [PK] | name |
| :--- | :--- |
| U101 | Aarav |
| U102 | Priya |
| U103 | Rohan |

#### Table 2: `Stories` (2NF)
- **Primary Key:** `story_id`

| story_id [PK] | title |
| :--- | :--- |
| ST01 | The Future of AI Writing |
| ST02 | Stoic Leadership in Startups |

#### Table 3: `Likes` (2NF)
- **Composite Primary Key / Candidate Key:** `(user_id, story_id)`
- **Foreign Keys:** `user_id` references `Users(user_id)`, `story_id` references `Stories(story_id)`

| user_id [PK, FK] | story_id [PK, FK] | liked_at |
| :--- | :--- | :--- |
| U101 | ST01 | 2026-11-10 10:00 |
| U102 | ST01 | 2026-11-12 09:15 |
| U103 | ST01 | 2026-11-12 14:20 |

---

### 6.6 Step-by-Step Decomposition Process
1. **Identify the Composite Candidate Key:** Locate `(user_id, story_id)`.
2. **Identify Partial Dependencies:** Observe that `user_name` relies strictly on `user_id`, and `story_title` relies strictly on `story_id`.
3. **Decompose into Entity Relations:**
   - Move `(user_id, user_name)` into `Users`.
   - Move `(story_id, story_title)` into `Stories`.
4. **Preserve Full Dependencies in the Junction Table:** Retain `(user_id, story_id, liked_at)` in `Likes`.
5. **Enforce Referential Integrity:** Add foreign keys from `Likes` pointing back to `Users` and `Stories`.

### 6.7 Result
The database satisfies **2NF**. No non-prime attribute depends on a partial key. Titles and user names exist in exactly one location, eliminating update and insertion anomalies.

---

## 7. Third Normal Form (3NF)

### 7.1 Definition & Rules of 3NF
A relation R is in **Third Normal Form (3NF)** if and only if:
1. It is already in **Second Normal Form (2NF)**.
2. **No non-prime attribute is transitively dependent on the primary key.**
3. Formally: For every non-trivial functional dependency **X → Y**, at least one of the following conditions holds:
   - **X is a Super Key** of R, OR
   - **Y is a Prime Attribute** (a member of some candidate key) of R.

### 7.2 Understanding Transitive Dependency
A **Transitive Dependency** occurs when an indirect dependency exists among non-prime attributes:
```text
Primary Key (X) → Non-Key (Y)   and   Non-Key (Y) → Non-Key (Z)
  ⟹ X → Z (Transitively)
```

In simple terms: **A non-key column must never determine another non-key column.** Every non-key attribute must depend directly on the primary key, and only on the primary key.

### 7.3 Relevant RythCore Example
Consider a consolidated `Stories_With_Category` table where category details are stored alongside story content:

- **Primary Key:** `story_id`
- **Functional Dependencies:**
  1. `story_id → title, content, author_id, category_id` *(Valid: `story_id` is a Super Key)*
  2. `category_id → category_name` *(Violates 3NF: `category_id` is NOT a Super Key, and `category_name` is NOT a prime attribute!)*
  3. Consequently, `story_id → category_name` transitively through `category_id`.

---

### 7.4 Before-Normalization Table (Violates 3NF)

#### Table: `Stories_With_Category`

| story_id [PK] | title | author_id | category_id | category_name (Transitive) |
| :--- | :--- | :--- | :--- | :--- |
| ST01 | The Future of AI Writing | U101 | CAT01 | Technology |
| ST02 | Stoic Leadership in Startups | U102 | CAT02 | Philosophy |
| ST03 | Neural Networks Simplified | U101 | CAT01 | Technology |
| ST04 | Modern Quantum Computing | U103 | CAT01 | Technology |

#### Operational Problems:
- **Redundancy:** The name `"Technology"` is stored repeatedly for every single story categorized under `CAT01`.
- **Update Anomaly:** If the editorial team renames `"Technology"` to `"Technology & Computing"`, every story row associated with `CAT01` must be updated. If an update query misses rows, the category name becomes inconsistent.
- **Insertion Anomaly:** If editors create a new category `"Economics (CAT03)"` for upcoming stories, the platform cannot record the category until an author writes a story in it, because `story_id` cannot be `NULL`.
- **Deletion Anomaly:** If story `ST02` is deleted and it is the only story in `"Philosophy"`, all record of the existence of the `"Philosophy"` category is permanently erased!

---

### 7.5 After-Normalization Tables (3NF Compliant)
We decompose the relation by extracting the transitive determinant into a dedicated table:

#### Table 1: `Stories` (3NF)
- **Primary Key:** `story_id`
- **Foreign Key:** `category_id` references `Categories(category_id)`

| story_id [PK] | title | author_id | category_id [FK] |
| :--- | :--- | :--- | :--- |
| ST01 | The Future of AI Writing | U101 | CAT01 |
| ST02 | Stoic Leadership in Startups | U102 | CAT02 |
| ST03 | Neural Networks Simplified | U101 | CAT01 |
| ST04 | Modern Quantum Computing | U103 | CAT01 |

#### Table 2: `Categories` (3NF)
- **Primary Key:** `category_id`

| category_id [PK] | category_name |
| :--- | :--- |
| CAT01 | Technology |
| CAT02 | Philosophy |
| CAT03 | Economics |

---

### 7.6 Step-by-Step Decomposition Process
1. **Identify the Transitive Dependency:** Locate `category_id → category_name` where `category_id` is a non-key attribute.
2. **Create a Dedicated Relation for the Determinant:** Extract `(category_id [PK], category_name)` into `Categories`.
3. **Retain the Determinant as a Foreign Key:** Leave `category_id` in the `Stories` table as a Foreign Key referencing `Categories(category_id)`.
4. **Remove Transitive Columns from the Original Table:** Drop `category_name` from `Stories`.

### 7.7 Result
Both tables satisfy **3NF**. New categories like `"Economics"` can be added freely without needing an associated story. Editing a category name requires updating exactly one row in the `Categories` table.

---

## 8. Boyce-Codd Normal Form (BCNF)

### 8.1 Definition & Rules of BCNF
A relation R is in **Boyce-Codd Normal Form (BCNF)** if and only if for every non-trivial functional dependency **X → Y**:

> **X must strictly be a Super Key of R**

BCNF is also known as **3.5NF**. While 3NF permits an exception if Y is a prime attribute, BCNF **removes this exception entirely**. In BCNF, every determinant must be a candidate key or super key without exception.

### 8.2 Evaluation of the Proposed RythCore Schema
In the proposed eight-table RythCore schema:
- Every table has a single surrogate Primary Key (`user_id`, `story_id`, `category_id`, `like_id`, `bookmark_id`, `comment_id`, `subscription_id`, `payment_id`).
- All functional dependencies have a Super Key on the left-hand side.
- Therefore, the proposed eight RythCore tables **already satisfy BCNF** in their basic structure!

To demonstrate how a genuine BCNF violation arises and is solved, consider an advanced editorial feature in RythCore: **Editorial Review Allocations**.

---

### 8.3 RythCore Illustrative Business Scenario: Editorial Review Assignments
RythCore employs professional editors to review stories before publication under the following verified business rules:
1. Each story belongs to a specific category.
2. A story is reviewed by an assigned editor.
3. Multiple editors can review stories in the same category.
4. **Each editor specializes in and reviews stories for only ONE category.**
5. For any given story, only **ONE** editor is assigned.

#### Relation: `Story_Editor_Assignment`
- Attributes: `story_id`, `editor_id`, `category_name`
- **Functional Dependencies:**
  1. `story_id → editor_id` *(Each story has one assigned editor)*
  2. `editor_id → category_name` *(Each editor specializes in only one category)*
  3. `(story_id, category_name) → editor_id`

#### Candidate Keys:
- `(story_id)`: Determines `editor_id`, which in turn determines `category_name`.
- `(editor_id, story_id)`: Minimal superkey.

Both `story_id` and `category_name` are part of overlapping dependencies.

---

### 8.4 Why This Satisfies 3NF but Violates BCNF

Look at the dependency:
```text
editor_id → category_name
```

- Is `editor_id` a Super Key of `Story_Editor_Assignment`? **NO.** (An editor reviews many different stories; `editor_id` alone cannot uniquely identify a row in this table).
- Is `category_name` a Prime Attribute? If `(editor_id, category_name)` were considered, 3NF allows this dependency because of the prime attribute loophole.

**However, BCNF strictly forbids this!** Because `editor_id` is a determinant but NOT a super key, this table **VIOLATES BCNF**.

---

### 8.5 Before-Normalization Table (Violates BCNF)

#### Table: `Story_Editor_Assignment`

| story_id [PK] | editor_id [Determinant, Not SK] | category_name |
| :--- | :--- | :--- |
| ST01 | ED_01 (Dr. Vance) | Technology |
| ST02 | ED_02 (Dr. Tesla) | Philosophy |
| ST03 | ED_01 (Dr. Vance) | Technology |
| ST04 | ED_03 (Dr. Turing) | Technology |

#### Operational Anomalies in the 3NF Table:
- **Redundancy:** `ED_01 → Technology` is duplicated for every story Dr. Vance reviews.
- **Insertion Anomaly:** If RythCore hires a new editor `ED_04` specialized in `"Economics"`, but no stories are assigned yet, we cannot insert `(NULL, 'ED_04', 'Economics')` because `story_id` is the primary key and cannot be `NULL`.
- **Deletion Anomaly:** If story `ST02` is withdrawn, deleting the row erases all record that `ED_02` specializes in `Philosophy`.

---

### 8.6 After-Normalization Tables (BCNF Compliant)
We decompose the relation using the violating dependency `editor_id → category_name`:

#### Table 1: `Editor_Specialization` (BCNF)
- **Primary Key:** `editor_id` (The determinant is now a Super Key in this table!)

| editor_id [PK] | category_name |
| :--- | :--- |
| ED_01 | Technology |
| ED_02 | Philosophy |
| ED_03 | Technology |
| ED_04 | Economics |

#### Table 2: `Story_Reviewer` (BCNF)
- **Primary Key:** `story_id`
- **Foreign Key:** `editor_id` references `Editor_Specialization(editor_id)`

| story_id [PK] | editor_id [FK] |
| :--- | :--- |
| ST01 | ED_01 |
| ST02 | ED_02 |
| ST03 | ED_01 |
| ST04 | ED_03 |

---

### 8.7 Step-by-Step Decomposition Process
1. **Identify the Violating Non-Trivial Dependency:** In `editor_id → category_name`, `editor_id` is not a super key for the full table.
2. **Create a Relation for the Violating Determinant:** Extract `(editor_id [PK], category_name)` into `Editor_Specialization`. `editor_id` becomes the primary key.
3. **Create the Remaining Relationship Table:** Keep `(story_id [PK], editor_id [FK])` in `Story_Reviewer`.
4. **Verify BCNF Condition:**
   - In `Editor_Specialization`: `editor_id` is a Super Key ⟹ **BCNF Satisfied**.
   - In `Story_Reviewer`: `story_id` is a Super Key ⟹ **BCNF Satisfied**.

### 8.8 Result
Both decomposed tables satisfy **BCNF**. New editors can be onboarded and mapped to categories without requiring stories, and deleting stories preserves editor specialization profiles.

---

## 9. Final Conclusion

Through systematic analysis of the RythCore digital publishing platform, we have demonstrated the practical application of database normalization theory:

1. **1NF (Atomicity):** Ensured that all attribute fields contain indivisible scalar values, replacing comma-separated lists (such as multi-valued tags) with properly keyed atomic tuples.
2. **2NF (No Partial Dependencies):** Decomposed composite-key engagement tables (`Likes`, `Bookmarks`) so that descriptive attributes depend on the complete key, keeping user profiles and story headlines in their respective parent entity tables.
3. **3NF (No Transitive Dependencies):** Extracted indirect non-key determinants (such as `category_id → category_name`) into standalone entity tables (`Categories`, `Subscriptions`), ensuring every non-key attribute depends directly and only on the primary key.
4. **BCNF (Strict Superkey Determinants):** Eliminated anomalies arising from overlapping candidate keys in editorial review assignments, ensuring that every functional determinant is a super key.

### Summary Matrix

| Normal Form | Requirement | What It Eliminates | RythCore Application |
| :---: | :--- | :--- | :--- |
| **1NF** | Atomic values only; no repeating groups. | Comma-separated strings, multi-valued arrays. | Isolating story tags into individual atomic records. |
| **2NF** | 1NF + No partial functional dependencies. | Attributes depending on part of a composite key. | Separating user and story details from composite `Likes` interactions. |
| **3NF** | 2NF + No transitive dependencies. | Non-key attributes determining other non-key attributes. | Extracting `Categories` and `Subscriptions` from story logs. |
| **BCNF** | Every determinant X in X → Y must be a Super Key. | Anomalies from overlapping composite candidate keys. | Separating `Editor_Specialization` from `Story_Reviewer`. |

By implementing this normalized schema, **RythCore** achieves high write performance, minimal disk redundancy, complete referential integrity, and total protection against insertion, update, and deletion anomalies.
