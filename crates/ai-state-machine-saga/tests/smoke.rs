use ai_state_machine_saga::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
