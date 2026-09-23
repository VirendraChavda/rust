use ai_vector_elasticsearch::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
