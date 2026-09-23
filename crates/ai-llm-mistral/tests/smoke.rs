use ai_llm_mistral::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
