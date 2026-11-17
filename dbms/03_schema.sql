
-- RYTHCORE DATABASE SCHEMA

-- ENUMS

CREATE TYPE "StoryVisibility" AS ENUM (
    'DRAFT', 'PUBLIC', 'SUBSCRIBERS_ONLY'
);

CREATE TYPE "SubscriptionStatus" AS ENUM (
    'ACTIVE', 'CANCELLED', 'EXPIRED', 'PENDING'
);

CREATE TYPE "PaymentStatus" AS ENUM (
    'PENDING', 'SUCCESS', 'FAILED', 'REFUNDED'
);


-- 1. USER

CREATE TABLE IF NOT EXISTS "user" (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    "emailVerified" BOOLEAN NOT NULL DEFAULT FALSE,
    image TEXT,
    role TEXT NOT NULL DEFAULT 'reader',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_user_role
ON "user"(role);


-- 2. SESSION

CREATE TABLE IF NOT EXISTS session (
    id TEXT PRIMARY KEY,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    token TEXT NOT NULL UNIQUE,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "userId" TEXT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_session_user
ON session("userId");


-- 3. ACCOUNT

CREATE TABLE IF NOT EXISTS account (
    id TEXT PRIMARY KEY,
    "accountId" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "userId" TEXT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    "accessToken" TEXT,
    "refreshToken" TEXT,
    "idToken" TEXT,
    "accessTokenExpiresAt" TIMESTAMP(3),
    "refreshTokenExpiresAt" TIMESTAMP(3),
    scope TEXT,
    password TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_account_user
ON account("userId");


-- 4. VERIFICATION

CREATE TABLE IF NOT EXISTS verification (
    id TEXT PRIMARY KEY,
    identifier TEXT NOT NULL,
    value TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_verification_identifier
ON verification(identifier);


-- 5. CATEGORY

CREATE TABLE IF NOT EXISTS category (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);


-- 6. STORY

CREATE TABLE IF NOT EXISTS story (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    excerpt TEXT,
    content TEXT NOT NULL,
    "coverImage" TEXT,
    visibility "StoryVisibility" NOT NULL DEFAULT 'DRAFT',
    "authorId" TEXT NOT NULL REFERENCES "user"(id),
    "categoryId" INTEGER NOT NULL REFERENCES category(id),
    "publishedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_story_author
ON story("authorId");

CREATE INDEX IF NOT EXISTS idx_story_category
ON story("categoryId");

CREATE INDEX IF NOT EXISTS idx_story_visibility
ON story(visibility);

CREATE INDEX IF NOT EXISTS idx_story_published
ON story("publishedAt");


-- 7. LIKE

CREATE TABLE IF NOT EXISTS "like" (
    id SERIAL PRIMARY KEY,
    "userId" TEXT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    "storyId" INTEGER NOT NULL REFERENCES story(id) ON DELETE CASCADE,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE ("userId", "storyId")
);

CREATE INDEX IF NOT EXISTS idx_like_story
ON "like"("storyId");


-- 8. BOOKMARK

CREATE TABLE IF NOT EXISTS bookmark (
    id SERIAL PRIMARY KEY,
    "userId" TEXT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    "storyId" INTEGER NOT NULL REFERENCES story(id) ON DELETE CASCADE,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE ("userId", "storyId")
);

CREATE INDEX IF NOT EXISTS idx_bookmark_story
ON bookmark("storyId");


-- 9. COMMENT

CREATE TABLE IF NOT EXISTS comment (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    "userId" TEXT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    "storyId" INTEGER NOT NULL REFERENCES story(id) ON DELETE CASCADE,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_comment_user
ON comment("userId");

CREATE INDEX IF NOT EXISTS idx_comment_story
ON comment("storyId");


-- 10. SUBSCRIPTION PLAN

CREATE TABLE IF NOT EXISTS subscription_plan (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    "durationMonths" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT TRUE,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);


-- 11. SUBSCRIPTION

CREATE TABLE IF NOT EXISTS subscription (
    id SERIAL PRIMARY KEY,
    "userId" TEXT NOT NULL REFERENCES "user"(id),
    "planId" INTEGER NOT NULL REFERENCES subscription_plan(id),
    status "SubscriptionStatus" NOT NULL DEFAULT 'PENDING',
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_subscription_user
ON subscription("userId");

CREATE INDEX IF NOT EXISTS idx_subscription_plan
ON subscription("planId");

CREATE INDEX IF NOT EXISTS idx_subscription_status
ON subscription(status);


-- 12. PAYMENT

CREATE TABLE IF NOT EXISTS payment (
    id SERIAL PRIMARY KEY,
    "subscriptionId" INTEGER NOT NULL REFERENCES subscription(id),
    amount DECIMAL(10,2) NOT NULL,
    currency TEXT NOT NULL DEFAULT 'INR',
    status "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "paymentProvider" TEXT NOT NULL DEFAULT 'razorpay',
    "providerOrderId" TEXT UNIQUE,
    "providerPaymentId" TEXT UNIQUE,
    "paymentDate" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);
