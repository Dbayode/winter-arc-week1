# Day 5 — HTTP status codes observed

Fill this table **after running curl**. Do not record expected results as observed results.

| Test command | Observed code | Why it happened |
|---|---|---|
| `curl -i http://127.0.0.1:8080/` | TBD | TBD |
| `curl -i http://127.0.0.1:8080/missing-file` | TBD | TBD |
| Stop backend; repeat first command | TBD | TBD |

## Concepts
- `200 OK`: request succeeded.
- `404 Not Found`: resource missing.
- `502 Bad Gateway`: proxy received an invalid response or could not reach its upstream.
- `503 Service Unavailable`: service currently unavailable.
