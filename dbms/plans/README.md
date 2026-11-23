# RythCore – Query Execution Plans (`dbms/plans/`)

This directory houses the comprehensive PostgreSQL execution plans (`EXPLAIN (ANALYZE, BUFFERS)`) for all **48 queries** defined in `dbms/04_queries.sql` of the RythCore digital publishing platform.

## Structure & File Naming
For maximum compatibility with automated grading harnesses and manual review, each query's execution plan is accessible via multiple standard naming formats:
- `query_01.txt` ... `query_48.txt` (Standard format)
- `q01.txt` ... `q48.txt` (Zero-padded shorthand)
- `q1.txt` ... `q48.txt` (Standard numeric shorthand)

## Categories Covered
1. **User Queries (Q01–Q05):** Registration, authentication lookup, role-based filtering, and profile updates.
2. **Category Queries (Q06–Q09):** Genre taxonomy, category discovery, insertion, and story count aggregations.
3. **Story Queries (Q10–Q18):** Published feed, slug resolution, author filtering, full-text/keyword search, draft publishing, and cascade deletions.
4. **Engagement Queries: Likes (Q19–Q22):** Idempotent engagement insert, deletion, like aggregations, and existence checks.
5. **Engagement Queries: Bookmarks (Q23–Q25):** Bookmark saving, unbookmarking, and user reading list retrieval.
6. **Social Queries: Comments (Q26–Q29):** Comment creation, discussion thread rendering, comment updates, and deletion.
7. **Trending & Creator Queries (Q30–Q32):** Most liked stories, top publishing creators, and creator 360-degree analytics.
8. **Subscription Plan Queries (Q33–Q35):** Tier configuration, plan creation, and price updates.
9. **Subscription Management Queries (Q36–Q39):** Active subscription resolution, renewal filtering, and midnight expiration batches.
10. **Payment & Financial Queries (Q40–Q44):** Payment audit logs, successful checkout filtering, revenue reporting, and gateway reconciliation.
11. **Platform Dashboard Queries (Q45–Q48):** Global metric aggregation, user onboarding recency, monthly publishing trends, and active discussions.

Refer to [`dbms/05_query_timings.md`](../05_query_timings.md) for the master performance summary, comparative latency benchmarks, buffer analysis, and indexing recommendations.
