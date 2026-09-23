use ai_queue_task_registry::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
