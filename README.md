# REST API Testing & Automation

A QA portfolio project demonstrating API functional testing with Postman and database integrity testing with PostgreSQL. The two parts are deliberately kept separate: the API tests exercise the public [Restful Booker API](https://restful-booker.herokuapp.com/), and the SQL scripts exercise a local, independently created `api_testing_db`. This repository does **not** claim access to the public API's internal database.

**Author:** Ajay Shankar Ganesh Eadara

## What is included

| Area | Coverage |
| --- | --- |
| API | Authentication, GET, POST, PUT, PATCH and DELETE requests |
| API automation | Request chaining with a dynamic booking ID and runtime token |
| API checks | Status codes, response shape, field values, update verification and deletion verification |
| API negative test | Missing `lastname` case documented separately as a contract observation |
| Database | `customers` and `bookings` schema, three seed customers and three seed bookings |
| Database tests | Six positive CRUD/relationship tests and six negative constraint tests |

## Repository layout

```text
rest-api-testing-automation/
├── postman/                 # Importable collection and safe environment template
├── database/                # PostgreSQL setup, seed data, and transaction-safe test suites
├── test-cases/              # API and database test matrices (Markdown + CSV)
├── test-reports/            # Test execution status report
├── defect-reports/          # Potential API defect / contract observation
├── screenshots/             # Redacted execution evidence
├── docs/                    # Portfolio copy
├── README.md
├── CONTRIBUTING.md
└── LICENSE
```

## Quick start

### Run the Postman collection

1. Import `postman/REST-API-Testing-Automation.postman_collection.json` into Postman.
2. Import `postman/Restful-Booker.postman_environment.template.json`.
3. Select that environment and run the collection in its listed order.
4. Set `username` and `password` in your private Postman environment before running the authenticated requests. The **Create Booking** request stores `bookingId`; **Create Token** stores a runtime-only `token`. Neither value is committed to the repository.

### Run the PostgreSQL tests

Create a local database named `api_testing_db`, then execute in this order:

```sql
\i database/01_schema.sql
\i database/02_seed.sql
\i database/03_positive_tests.sql
\i database/04_negative_tests.sql
```

Both test suites run inside transactions that end with `ROLLBACK`, so test rows are not kept. The tests expect the seed customer `ajay.test@example.com`.

## Test results

Test cases and their current status are tracked in [`test-cases/`](test-cases/) and [`test-reports/TEST_EXECUTION_REPORT.md`](test-reports/TEST_EXECUTION_REPORT.md). Results are only recorded as passed or failed when backed by a runner export or redacted screenshot in this repository.

## Safe sharing

Do not commit API tokens, passwords, Postman local environments, or screenshots containing sensitive data. The provided environment is a template only. Use a private Postman environment for credentials and keep values marked as secrets.

## More

See [docs/PORTFOLIO_BLURB.md](docs/PORTFOLIO_BLURB.md) for a short project summary and [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## License

Released under the [MIT License](LICENSE). Copyright (c) 2026 Ajay Shankar Ganesh Eadara.
