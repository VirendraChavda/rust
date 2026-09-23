use ai_queue_rabbitmq::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
