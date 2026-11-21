//! Shared domain models for Clearview Metadata Tool.

/// Supported photograph container formats.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ImageFormat {
    Jpeg,
    Png,
    Heic,
    WebP,
    Tiff,
    Bmp,
    Gif,
    RawDng,
    Unsupported,
}

impl ImageFormat {
    /// Returns a human-readable format label.
    pub fn label(self) -> &'static str {
        match self {
            ImageFormat::Jpeg => "JPEG",
            ImageFormat::Png => "PNG",
            ImageFormat::Heic => "HEIC/HEIF",
            ImageFormat::WebP => "WebP",
            ImageFormat::Tiff => "TIFF",
            ImageFormat::Bmp => "BMP",
            ImageFormat::Gif => "GIF",
            ImageFormat::RawDng => "RAW/DNG",
            ImageFormat::Unsupported => "Unsupported",
        }
    }

    /// Indicates whether the format can be exported directly without derivative conversion.
    pub fn supports_direct_clean_export(self) -> bool {
        !matches!(self, ImageFormat::RawDng | ImageFormat::Unsupported)
    }
}

/// Metadata categories tracked during inspection, cleaning, and verification.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MetadataCategory {
    Exif,
    Iptc,
    Xmp,
    Gps,
    Thumbnail,
    IccProfile,
    MakerNotes,
    AiProvenance,
    C2paManifest,
    Comments,
}

/// Cleaning profiles defined in the specification.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum CleaningProfile {
    /// Profile A: Remove identifying and descriptive metadata while preserving technical functionality.
    PrivacyClean,
    /// Profile B: Remove all supported embedded metadata, including provenance manifests (with warning).
    FullMetadataClean,
    /// User-selected subset of metadata categories.
    Custom,
}

/// Result of a foundation health check between UI and Rust engine.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct EngineStatus {
    pub engine_name: &'static str,
    pub version: &'static str,
    pub local_only: bool,
    pub ready: bool,
}

/// Summary report generated for every inspected or cleaned photograph.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ProcessingReport {
    pub original_filename: String,
    pub original_format: ImageFormat,
    pub original_size_bytes: u64,
    pub original_sha256: String,
    pub export_filename: String,
    pub export_format: ImageFormat,
    pub export_size_bytes: u64,
    pub categories_detected: Vec<MetadataCategory>,
    pub categories_removed: Vec<MetadataCategory>,
    pub categories_retained: Vec<MetadataCategory>,
    pub warnings: Vec<String>,
    pub verified: bool,
    pub timestamp_utc: String,
}
