use ai_llm_bedrock::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
