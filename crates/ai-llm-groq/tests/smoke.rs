use ai_llm_groq::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
