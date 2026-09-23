use ai_state_machine_compensation::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
