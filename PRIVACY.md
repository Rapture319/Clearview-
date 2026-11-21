# Privacy Guarantees

Clearview Metadata Tool is built on a strict local-first privacy model:

- **100% On-Device Processing:** All inspection, cleaning, hashing, and verification run locally on the user's device.
- **No Network Activity:** No cloud uploads, no automatic update pings, no telemetry, no analytics, and no ads.
- **No Accounts:** No sign-up, login, or external database required.
- **Original File Integrity:** Original photos are never modified, overwritten, or deleted. A SHA-256 hash is computed before and verified after processing.
- **Independent Export Verification:** Every cleaned file is reopened and re-inspected to confirm intended metadata removal and report any retained fields.
