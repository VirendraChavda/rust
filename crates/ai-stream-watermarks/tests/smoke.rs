use ai_stream_watermarks::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
