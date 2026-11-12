# BUG_NEG_004 — Missing lastname handling

| Field | Detail |
| --- | --- |
| Area | Public Restful Booker API |
| Endpoint | `POST /booking` |
| Payload variation | Omit `lastname` from an otherwise valid booking payload |
| Suspected result | HTTP 500 (to be confirmed with a response export or screenshot) |
| Desired behavior | Graceful client-input rejection, commonly 400 or 422, with a useful validation response |
| Severity | Medium (candidate; requires triage) |
| Status | Potential defect — pending reproduction |
| Author | Ajay Shankar Ganesh Eadara |

## Steps to reproduce

1. Submit a booking creation request with a valid `firstname`, price, deposit flag and booking dates.
2. Omit the `lastname` field.
3. Record the response status, body, and timestamp in a redacted screenshot or runner export.

## Notes

This is not recorded as a confirmed product defect until the behavior is reproduced and the evidence is saved in `screenshots/`. Confirm the published API contract before filing it externally.
