use ai_workflow_human_loop::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
