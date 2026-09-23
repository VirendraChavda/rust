use ai_state_machine_fsm::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
