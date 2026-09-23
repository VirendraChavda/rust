use ai_queue_redis::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
