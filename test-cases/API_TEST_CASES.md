# API test cases

| ID | Scenario | Method | Expected result | Baseline status |
| --- | --- | --- | --- | --- |
| API_001 | Service health | GET `/ping` | 201 response | Pending run |
| API_002 | List bookings | GET `/booking` | 200 and array response | Pending run |
| API_003 | Create booking | POST `/booking` | 200 and numeric booking ID | Pending run; ID is stored dynamically |
| API_004 | Read created booking | GET `/booking/:id` | 200 and created data | Pending run |
| API_005 | Authenticate | POST `/auth` | 200 and token | Pending run; token remains runtime-only |
| API_006 | Replace booking | PUT `/booking/:id` | 200 and replacement fields | Pending run |
| API_007 | Verify PUT | GET `/booking/:id` | Updated values persist | Pending run |
| API_008 | Partial update | PATCH `/booking/:id` | 200 and changed field | Pending run |
| API_009 | Verify PATCH | GET `/booking/:id` | Changed fields persist; retained fields remain | Pending run |
| API_010 | Delete booking | DELETE `/booking/:id` | 201 | Pending run |
| API_011 | Verify deletion | GET `/booking/:id` | 404 | Pending run |
| NEG_004 | Missing `lastname` | POST `/booking` | Invalid payload should be rejected; exact status to be confirmed | Not in baseline; pending reproduction |

`NEG_004` is not part of the automated baseline; reproduce it separately and retain redacted evidence before treating it as a defect. Results are recorded in `test-reports/` once evidence is added.
