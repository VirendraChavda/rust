use ai_vector_pinecone::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
