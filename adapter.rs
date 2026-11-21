//! Metadata-processing adapter trait.
//!
//! Each supported image format registers an adapter implementing inspection
//! and cleaning (pure Rust or desktop ExifTool where appropriate), ensuring
//! consistent behavior across Windows, macOS, Android, and iOS.

use crate::models::{CleaningProfile, ImageFormat, MetadataCategory};
use std::path::Path;

/// Errors returned by metadata adapters.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AdapterError {
    UnsupportedFormat(String),
    IoError(String),
    VerificationFailed(String),
    LossyConfirmationRequired,
}

/// Inspection output produced before cleaning.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct InspectionResult {
    pub format: ImageFormat,
    pub detected_categories: Vec<MetadataCategory>,
    pub field_count: usize,
    pub warnings: Vec<String>,
}

/// Common interface implemented by format-specific metadata adapters.
pub trait MetadataAdapter {
    fn adapter_name(&self) -> &'static str;
    fn supports_format(&self, format: ImageFormat) -> bool;
    fn inspect(&self, input_path: &Path) -> Result<InspectionResult, AdapterError>;
    fn clean(
        &self,
        input_path: &Path,
        output_path: &Path,
        profile: CleaningProfile,
    ) -> Result<(), AdapterError>;
}
