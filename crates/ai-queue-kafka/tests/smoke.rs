use ai_queue_kafka::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
