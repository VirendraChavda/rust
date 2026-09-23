use ai_agent_fallback::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
