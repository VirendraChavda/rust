use ai_stream_windowing::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
