use ai_queue_sqs::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
