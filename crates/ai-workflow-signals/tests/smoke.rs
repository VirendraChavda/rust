use ai_workflow_signals::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
