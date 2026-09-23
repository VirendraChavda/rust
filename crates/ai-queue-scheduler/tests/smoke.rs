use ai_queue_scheduler::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
