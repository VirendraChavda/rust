use ai_llm_cohere::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
