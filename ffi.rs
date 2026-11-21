//! C-ABI FFI surface for Flutter / Dart communication.
//!
//! Milestone 1 exposes a minimal, memory-safe C-ABI bridge (`ping`, `version`,
//! and `free_string`) so the Flutter app can verify native communication on all
//! four target platforms.

use std::ffi::{c_char, CString};

use crate::{engine_ping_json, ENGINE_VERSION};

/// Returns a newly allocated UTF-8 JSON string containing the engine health status.
///
/// Caller must free the returned pointer using `clearview_free_string`.
#[no_mangle]
pub extern "C" fn clearview_engine_ping() -> *mut c_char {
    let payload = engine_ping_json();
    match CString::new(payload) {
        Ok(cstr) => cstr.into_raw(),
        Err(_) => std::ptr::null_mut(),
    }
}

/// Returns a newly allocated UTF-8 string containing the engine semantic version.
///
/// Caller must free the returned pointer using `clearview_free_string`.
#[no_mangle]
pub extern "C" fn clearview_engine_version() -> *mut c_char {
    match CString::new(ENGINE_VERSION) {
        Ok(cstr) => cstr.into_raw(),
        Err(_) => std::ptr::null_mut(),
    }
}

/// Frees a string previously returned by `clearview_*` FFI functions.
///
/// # Safety
/// `ptr` must either be null or a pointer previously returned by this library
/// that has not already been freed.
#[no_mangle]
pub unsafe extern "C" fn clearview_free_string(ptr: *mut c_char) {
    if !ptr.is_null() {
        drop(unsafe { CString::from_raw(ptr) });
    }
}
