use ai_retrieval_router::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
