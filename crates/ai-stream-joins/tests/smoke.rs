use ai_stream_joins::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
