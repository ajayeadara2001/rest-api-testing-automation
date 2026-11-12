# Database test cases

## Positive tests

| ID | Scenario | Expected result |
| --- | --- | --- |
| DB_POS_001 | Insert valid booking | New booking is created |
| DB_POS_002 | Retrieve booking with customer JOIN | Correct related customer and booking are returned |
| DB_POS_003 | Update booking price | Updated price persists |
| DB_POS_004 | Update booking status | Updated status persists |
| DB_POS_005 | Delete booking | Booking no longer exists |
| DB_POS_006 | Verify customer remains | Customer remains after booking deletion |

## Negative constraint tests

| ID | Scenario | Expected SQLSTATE | Constraint concept |
| --- | --- | --- | --- |
| DB_NEG_001 | Duplicate customer email | 23505 | Unique |
| DB_NEG_002 | Missing customer firstname | 23502 | Not null |
| DB_NEG_003 | Negative booking price | 23514 | Check: price |
| DB_NEG_004 | Checkout before check-in | 23514 | Check: dates |
| DB_NEG_005 | Nonexistent customer ID | 23503 | Foreign key |
| DB_NEG_006 | Invalid booking status | 23514 | Check: status |

Run `database/03_positive_tests.sql` and `database/04_negative_tests.sql` to produce the result grids, and save redacted output in `screenshots/`.
