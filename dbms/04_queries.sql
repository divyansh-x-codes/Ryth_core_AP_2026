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


-- 7. TRENDING AND CREATOR QUERIES

-- 30. Get trending stories based on likes
SELECT
    s.id,
    s.title,
    s."coverImage",
    u.name AS author,
    COUNT(l.id) AS total_likes
FROM story s
JOIN "user" u ON s."authorId" = u.id
LEFT JOIN "Like" l ON s.id = l."storyId"
WHERE s.visibility = 'PUBLIC'
GROUP BY s.id, s.title, s."coverImage", u.name
ORDER BY total_likes DESC
LIMIT 10;


-- 31. Get top creators based on published stories
SELECT
    u.id,
    u.name,
    COUNT(s.id) AS published_stories
FROM "user" u
JOIN story s ON u.id = s."authorId"
WHERE s.visibility = 'PUBLIC'
GROUP BY u.id, u.name
ORDER BY published_stories DESC
LIMIT 10;


-- 32. Get creator statistics
SELECT
    u.id,
    u.name,
    COUNT(DISTINCT s.id) AS total_stories,
    COUNT(DISTINCT l.id) AS total_likes,
    COUNT(DISTINCT c.id) AS total_comments
FROM "user" u
LEFT JOIN story s ON u.id = s."authorId"
LEFT JOIN "Like" l ON s.id = l."storyId"
LEFT JOIN "Comment" c ON s.id = c."storyId"
WHERE u.id = 'USER_ID'
GROUP BY u.id, u.name;


-- 8. SUBSCRIPTION PLAN QUERIES

-- 33. Get all active subscription plans
SELECT *
FROM "SubscriptionPlan"
WHERE "isActive" = TRUE
ORDER BY price ASC;


-- 34. Add a subscription plan
INSERT INTO "SubscriptionPlan"
    (name, description, price, "durationMonths", "isActive")
VALUES
    ('Ryth Premium', 'Premium access to RythCore', 499.00, 1, TRUE);


-- 35. Update a subscription plan
UPDATE "SubscriptionPlan"
SET price = 599.00,
    "updatedAt" = CURRENT_TIMESTAMP
WHERE id = 1;


-- 9. SUBSCRIPTION QUERIES

-- 36. Get a user's subscriptions
SELECT
    sub.id,
    u.name AS user_name,
    p.name AS plan_name,
    sub.status,
    sub."startDate",
    sub."endDate"
FROM "Subscription" sub
JOIN "user" u ON sub."userId" = u.id
JOIN "SubscriptionPlan" p ON sub."planId" = p.id
WHERE sub."userId" = 'USER_ID'
ORDER BY sub."createdAt" DESC;


-- 37. Get all currently active subscriptions
SELECT
    u.name,
    u.email,
    p.name AS plan_name,
    sub."startDate",
    sub."endDate"
FROM "Subscription" sub
JOIN "user" u ON sub."userId" = u.id
JOIN "SubscriptionPlan" p ON sub."planId" = p.id
WHERE sub.status = 'ACTIVE'
AND sub."endDate" > CURRENT_TIMESTAMP;


-- 38. Count active subscriptions
SELECT COUNT(*) AS active_subscriptions
FROM "Subscription"
WHERE status = 'ACTIVE'
AND "endDate" > CURRENT_TIMESTAMP;


-- 39. Expire subscriptions whose end date has passed
UPDATE "Subscription"
SET status = 'EXPIRED',
    "updatedAt" = CURRENT_TIMESTAMP
WHERE status = 'ACTIVE'
AND "endDate" <= CURRENT_TIMESTAMP;


-- 10. PAYMENT QUERIES

-- 40. Get payment history of a user
SELECT
    pay.id,
    pay.amount,
    pay.currency,
    pay.status,
    pay."paymentProvider",
    pay."providerPaymentId",
    pay."paymentDate",
    sub.id AS subscription_id
FROM "Payment" pay
JOIN "Subscription" sub ON pay."subscriptionId" = sub.id
WHERE sub."userId" = 'USER_ID'
ORDER BY pay."createdAt" DESC;


-- 41. Get successful payments
SELECT *
FROM "Payment"
WHERE status = 'SUCCESS'
ORDER BY "paymentDate" DESC;


-- 42. Calculate total successful revenue
SELECT
    currency,
    SUM(amount) AS total_revenue
FROM "Payment"
WHERE status = 'SUCCESS'
GROUP BY currency;


-- 43. Count payments by status
SELECT
    status,
    COUNT(*) AS total_payments
FROM "Payment"
GROUP BY status;


-- 44. Find a payment using Razorpay payment ID
SELECT *
FROM "Payment"
WHERE "providerPaymentId" = 'RAZORPAY_PAYMENT_ID';


-- 11. DASHBOARD QUERIES

-- 45. RythCore dashboard statistics
SELECT
    (SELECT COUNT(*) FROM "user") AS total_users,

    (SELECT COUNT(*)
     FROM story
     WHERE visibility = 'PUBLIC') AS published_stories,

    (SELECT COUNT(*)
     FROM "Like") AS total_likes,

    (SELECT COUNT(*)
     FROM "Comment") AS total_comments,

    (SELECT COUNT(*)
     FROM "Bookmark") AS total_bookmarks,

    (SELECT COUNT(*)
     FROM "Subscription"
     WHERE status = 'ACTIVE'
     AND "endDate" > CURRENT_TIMESTAMP) AS active_subscriptions;


-- 46. Get recently joined users
SELECT id, name, email, "createdAt"
FROM "user"
ORDER BY "createdAt" DESC
LIMIT 10;


-- 47. Get stories published this month
SELECT id, title, "publishedAt"
FROM story
WHERE visibility = 'PUBLIC'
AND "publishedAt" >= DATE_TRUNC('month', CURRENT_TIMESTAMP)
ORDER BY "publishedAt" DESC;


-- 48. Get most commented stories
SELECT
    s.id,
    s.title,
    COUNT(c.id) AS total_comments
FROM story s
LEFT JOIN "Comment" c ON s.id = c."storyId"
WHERE s.visibility = 'PUBLIC'
GROUP BY s.id, s.title
ORDER BY total_comments DESC
LIMIT 10;
