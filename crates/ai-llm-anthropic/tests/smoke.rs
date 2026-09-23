#[test]
fn health_is_available() {
    assert!(ai_llm_anthropic::health());
}
