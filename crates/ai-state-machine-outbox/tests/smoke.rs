use ai_state_machine_outbox::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
