use ai_state_machine_snapshots::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
