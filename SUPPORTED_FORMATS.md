# Supported Formats

| Format | Import | Cleaned Export | Lossless Metadata Removal Target | Notes |
|---|---|---|---|---|
| JPEG / JPG | Yes | Yes | Yes (segment stripping) | Milestone 3 |
| PNG | Yes | Yes | Yes (chunk stripping) | Milestone 3 |
| HEIC / HEIF | Yes | Yes | Where container allows | Milestone 3+ |
| WebP | Yes | Yes | Yes (RIFF chunk stripping) | Milestone 3 |
| TIFF | Yes | Yes | Tag/IFD stripping | Milestone 3 |
| BMP | Yes | Yes | Yes | Milestone 3+ |
| GIF | Yes | Yes | Yes, preserving animation | Milestone 3+ |
| RAW / DNG | Yes | Derivative only | Original RAW never modified | Clearly labeled as derivative |

## Format Preservation Rules

- Default export format matches the original format whenever technically possible.
- No silent format conversion or unrequested lossy recompression.
- Any operation requiring image reconstruction preserves dimensions, orientation, animation frames, and color profiles where possible, and requires explicit user confirmation before lossy conversion.
- Unsupported formats are reported explicitly.
