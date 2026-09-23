use ai_workflow_dag::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
