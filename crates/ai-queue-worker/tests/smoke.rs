use ai_queue_worker::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
