use ai_state_machine_event_sourcing::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
