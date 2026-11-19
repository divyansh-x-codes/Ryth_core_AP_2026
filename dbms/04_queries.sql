-- RYTHCORE DATABASE QUERIES
-- 1. USER QUERIES

-- 1. Get all registered users
SELECT *
FROM "user"
ORDER BY "createdAt" DESC;


-- 2. Find a user using email
SELECT id, name, email, image, role
FROM "user"
WHERE email = 'user@example.com';


-- 3. Get all creators
SELECT id, name, email, image
FROM "user"
WHERE role = 'creator';


-- 4. Count total registered users
SELECT COUNT(*) AS total_users
FROM "user";


-- 5. Update user role
UPDATE "user"
SET role = 'creator',
    "updatedAt" = CURRENT_TIMESTAMP
WHERE id = 'USER_ID';


-- 2. CATEGORY QUERIES

-- 6. Get all categories
SELECT *
FROM "Category"
ORDER BY name;


-- 7. Find a category by name
SELECT *
FROM "Category"
WHERE name = 'Technology';


-- 8. Add a new category
INSERT INTO "Category" (name, description)
VALUES ('Technology', 'Technology, innovation and digital trends');


-- 9. Count stories in each category
SELECT
    c.id,
    c.name,
    COUNT(s.id) AS total_stories
FROM "Category" c
LEFT JOIN story s ON s."categoryId" = c.id
GROUP BY c.id, c.name
ORDER BY total_stories DESC;



-- 3. STORY QUERIES


-- 10. Get all published public stories
SELECT
    s.id,
    s.title,
    s.slug,
    s.excerpt,
    s."coverImage",
    s."publishedAt",
    u.name AS author,
    c.name AS category
FROM story s
JOIN "user" u ON s."authorId" = u.id
JOIN "Category" c ON s."categoryId" = c.id
WHERE s.visibility = 'PUBLIC'
ORDER BY s."publishedAt" DESC;


-- 11. Get a particular story using its slug
SELECT
    s.*,
    u.name AS author,
    c.name AS category
FROM story s
JOIN "user" u ON s."authorId" = u.id
JOIN "Category" c ON s."categoryId" = c.id
WHERE s.slug = 'sample-story';


-- 12. Get all stories written by a creator
SELECT
    s.id,
    s.title,
    s.visibility,
    s."createdAt"
FROM story s
WHERE s."authorId" = 'USER_ID'
ORDER BY s."createdAt" DESC;


-- 13. Get stories belonging to a category
SELECT
    s.id,
    s.title,
    s.excerpt,
    u.name AS author
FROM story s
JOIN "user" u ON s."authorId" = u.id
WHERE s."categoryId" = 1
AND s.visibility = 'PUBLIC'
ORDER BY s."publishedAt" DESC;


-- 14. Search stories by title or content
SELECT id, title, excerpt
FROM story
WHERE visibility = 'PUBLIC'
AND (
    title ILIKE '%technology%'
    OR content ILIKE '%technology%'
);


-- 15. Get the latest 10 stories
SELECT id, title, "coverImage", "publishedAt"
FROM story
WHERE visibility = 'PUBLIC'
ORDER BY "publishedAt" DESC
LIMIT 10;


-- 16. Publish a draft story
UPDATE story
SET visibility = 'PUBLIC',
    "publishedAt" = CURRENT_TIMESTAMP,
    "updatedAt" = CURRENT_TIMESTAMP
WHERE id = 1
AND visibility = 'DRAFT';


-- 17. Update story details
UPDATE story
SET title = 'Updated Story Title',
    excerpt = 'Updated story description',
    content = 'Updated story content',
    "updatedAt" = CURRENT_TIMESTAMP
WHERE id = 1;


-- 18. Delete a story
DELETE FROM story
WHERE id = 1;


-- 4. LIKE QUERIES

-- 19. Like a story
INSERT INTO "Like" ("userId", "storyId")
VALUES ('USER_ID', 1)
ON CONFLICT ("userId", "storyId") DO NOTHING;


-- 20. Unlike a story
DELETE FROM "Like"
WHERE "userId" = 'USER_ID'
AND "storyId" = 1;


-- 21. Count likes on each story
SELECT
    s.id,
    s.title,
    COUNT(l.id) AS total_likes
FROM story s
LEFT JOIN "Like" l ON s.id = l."storyId"
GROUP BY s.id, s.title
ORDER BY total_likes DESC;


-- 22. Check whether a user liked a story
SELECT EXISTS (
    SELECT 1
    FROM "Like"
    WHERE "userId" = 'USER_ID'
    AND "storyId" = 1
) AS is_liked;


-- 5. BOOKMARK QUERIES


-- 23. Bookmark a story
INSERT INTO "Bookmark" ("userId", "storyId")
VALUES ('USER_ID', 1)
ON CONFLICT ("userId", "storyId") DO NOTHING;


-- 24. Remove a bookmark
DELETE FROM "Bookmark"
WHERE "userId" = 'USER_ID'
AND "storyId" = 1;


-- 25. Get all bookmarked stories of a user
SELECT
    s.id,
    s.title,
    s.excerpt,
    s."coverImage",
    b."createdAt"
FROM "Bookmark" b
JOIN story s ON b."storyId" = s.id
WHERE b."userId" = 'USER_ID'
ORDER BY b."createdAt" DESC;


-- 6. COMMENT QUERIES

-- 26. Add a comment to a story
INSERT INTO "Comment" ("content", "userId", "storyId")
VALUES ('This is a very informative story.', 'USER_ID', 1);


-- 27. Get all comments on a story
SELECT
    c.id,
    c.content,
    c."createdAt",
    u.name AS commenter,
    u.image AS profile_image
FROM "Comment" c
JOIN "user" u ON c."userId" = u.id
WHERE c."storyId" = 1
ORDER BY c."createdAt" DESC;


-- 28. Update a comment
UPDATE "Comment"
SET content = 'Updated comment',
    "updatedAt" = CURRENT_TIMESTAMP
WHERE id = 1
AND "userId" = 'USER_ID';


-- 29. Delete a comment
DELETE FROM "Comment"
WHERE id = 1
AND "userId" = 'USER_ID';
