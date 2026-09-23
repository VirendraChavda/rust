use ai_llm_vertex::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
