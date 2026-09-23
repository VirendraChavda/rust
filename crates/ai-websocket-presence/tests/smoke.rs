use ai_websocket_presence::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
