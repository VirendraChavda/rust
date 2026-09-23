use ai_vector_opensearch::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
