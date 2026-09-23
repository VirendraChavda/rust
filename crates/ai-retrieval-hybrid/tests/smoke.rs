use ai_retrieval_hybrid::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
