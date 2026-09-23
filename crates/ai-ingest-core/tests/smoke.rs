#[test]
fn health_is_available() {
    assert!(ai_ingest_core::health());
}
