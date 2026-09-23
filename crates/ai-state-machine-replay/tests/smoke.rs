use ai_state_machine_replay::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
