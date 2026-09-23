#[test]
fn health_is_available() {
    assert!(ai_vector_weaviate::health());
}
