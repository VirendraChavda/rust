use ai_queue_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
