use ai_websocket_broadcast::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
