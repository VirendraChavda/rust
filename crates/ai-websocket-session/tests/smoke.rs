use ai_websocket_session::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
