use ai_state_machine_inbox::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
