# Test execution status

**Tester:** Ajay Shankar Ganesh Eadara

## Scope

| Suite | System under test | Tests | Status |
| --- | --- | --- | --- |
| Postman API baseline | Public Restful Booker API | 11 requests | Pending run — add runner export or screenshot |
| PostgreSQL positive suite | Local `api_testing_db` | 6 | Pending run — add result output |
| PostgreSQL negative suite | Local `api_testing_db` | 6 | Pending run — add result output |

## API baseline

The Postman collection covers the health check, booking list, create/read, authentication, PUT/PATCH updates, delete, and deletion verification flow. Record assertion counts, duration, and pass/fail totals here once a run export or screenshot is saved in `screenshots/`.

## Database suites

The repository defines twelve SQL tests: six positive CRUD/relationship tests (`DB_POS_001`–`006`) and six negative constraint tests (`DB_NEG_001`–`006`). Run `database/03_positive_tests.sql` and `database/04_negative_tests.sql` locally and attach the output to record results.

## Exception / observation

The missing-`lastname` API case is intentionally excluded from the automated baseline and tracked separately. See `defect-reports/BUG_NEG_004_MISSING_LASTNAME.md`.
