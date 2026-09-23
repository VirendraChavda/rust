use ai_agent_memory_window::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
