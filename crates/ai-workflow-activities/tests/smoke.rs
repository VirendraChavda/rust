use ai_workflow_activities::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
