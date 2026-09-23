use ai_queue_result_store::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
