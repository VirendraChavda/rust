use ai_agent_simulation::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
