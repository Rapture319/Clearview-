# Security Policy

## Local-First & File Safety Guarantees

Clearview Metadata Tool processes all images strictly on-device with no network connectivity required after installation.

- **No overwriting originals:** Cleaned copies are written to new paths with atomic temp-file writes and collision suffixes.
- **Path traversal & symlink protection:** File paths are validated and canonicalized before reading or writing.
- **Untrusted image hardening:** Image decoders and metadata parsers must treat all input files as untrusted and never execute embedded scripts or active content.
- **Log hygiene:** Sensitive metadata values (GPS coordinates, serial numbers, user paths) must not be written to application logs.

## Reporting a Vulnerability

If you discover a security issue (such as a parser crash on malformed images, path traversal, or metadata leakage after cleaning), please open a private security advisory on the project's GitHub repository rather than disclosing it publicly.
