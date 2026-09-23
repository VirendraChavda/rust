#[test]
fn health_is_available() {
    assert!(ai_serving_batch::health());
}
