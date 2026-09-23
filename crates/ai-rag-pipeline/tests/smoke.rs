use ai_rag_pipeline::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
