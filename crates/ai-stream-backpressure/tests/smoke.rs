use ai_stream_backpressure::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
