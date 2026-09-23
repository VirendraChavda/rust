use ai_workflow_scheduler::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
