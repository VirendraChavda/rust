#[test]
fn health_is_available() {
    assert!(ai_cloud_gcp::health());
}
