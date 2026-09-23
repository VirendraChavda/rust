use ai_rag_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
