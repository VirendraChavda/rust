use ai_llm_azure_openai::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
