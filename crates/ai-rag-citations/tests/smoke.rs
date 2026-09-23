use ai_rag_citations::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
