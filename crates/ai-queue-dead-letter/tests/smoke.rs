use ai_queue_dead_letter::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
