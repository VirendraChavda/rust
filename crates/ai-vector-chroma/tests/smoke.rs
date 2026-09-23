use ai_vector_chroma::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
