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