use ai_state_machine_locks::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
