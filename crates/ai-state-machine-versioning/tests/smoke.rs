use ai_state_machine_versioning::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
