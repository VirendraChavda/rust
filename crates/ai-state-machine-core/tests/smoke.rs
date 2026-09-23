use ai_state_machine_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
