use clearview_engine::ffi::{
    clearview_engine_ping, clearview_engine_version, clearview_free_string,
};
use std::ffi::CStr;

#[test]
fn ffi_ping_and_version_roundtrip() {
    let ping_ptr = clearview_engine_ping();
    assert!(!ping_ptr.is_null());

    let ping_str = unsafe { CStr::from_ptr(ping_ptr) }
        .to_str()
        .expect("valid UTF-8 ping payload")
        .to_owned();
    unsafe { clearview_free_string(ping_ptr) };

    assert!(ping_str.contains("\"engine\":\"clearview_engine\""));
    assert!(ping_str.contains("\"ready\":true"));

    let ver_ptr = clearview_engine_version();
    assert!(!ver_ptr.is_null());

    let ver_str = unsafe { CStr::from_ptr(ver_ptr) }
        .to_str()
        .expect("valid UTF-8 version string")
        .to_owned();
    unsafe { clearview_free_string(ver_ptr) };

    assert!(!ver_str.is_empty());
}
