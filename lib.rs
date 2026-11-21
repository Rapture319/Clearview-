//! Clearview Metadata Tool — Core Processing Engine
//!
//! Licensed under GNU GPL-3.0-or-later.
//! All image inspection, metadata removal, original-file preservation, and
//! post-export verification logic resides in this crate.

pub mod adapter;
pub mod ffi;
pub mod models;

use models::EngineStatus;

/// Current semantic version of the Rust processing engine.
pub const ENGINE_VERSION: &str = env!("CARGO_PKG_VERSION");

/// Returns the current engine status for health-check verification.
pub fn engine_status() -> EngineStatus {
    EngineStatus {
        engine_name: "clearview_engine",
        version: ENGINE_VERSION,
        local_only: true,
        ready: true,
    }
}

/// Serializes the engine health status to a compact JSON string for FFI transport.
pub fn engine_ping_json() -> String {
    let status = engine_status();
    format!(
        "{{\"engine\":\"{}\",\"version\":\"{}\",\"localOnly\":{},\"ready\":{}}}",
        status.engine_name, status.version, status.local_only, status.ready
    )
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::models::ImageFormat;

    #[test]
    fn engine_status_is_local_and_ready() {
        let status = engine_status();
        assert_eq!(status.engine_name, "clearview_engine");
        assert!(status.local_only);
        assert!(status.ready);
    }

    #[test]
    fn engine_ping_json_contains_expected_fields() {
        let json = engine_ping_json();
        assert!(json.contains("\"engine\":\"clearview_engine\""));
        assert!(json.contains("\"localOnly\":true"));
        assert!(json.contains("\"ready\":true"));
    }

    #[test]
    fn raw_format_does_not_claim_direct_clean_export() {
        assert!(!ImageFormat::RawDng.supports_direct_clean_export());
        assert!(ImageFormat::Jpeg.supports_direct_clean_export());
        assert!(ImageFormat::Png.supports_direct_clean_export());
    }
}
