use ai_agent_executor::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
