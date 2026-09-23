use ai_vector_milvus::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
