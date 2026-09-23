use ai_llm_ollama::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
