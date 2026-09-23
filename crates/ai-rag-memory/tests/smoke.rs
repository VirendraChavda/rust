use ai_rag_memory::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
