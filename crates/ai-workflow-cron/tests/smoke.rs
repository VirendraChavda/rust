use ai_workflow_cron::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
