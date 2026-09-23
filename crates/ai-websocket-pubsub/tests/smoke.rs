use ai_websocket_pubsub::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
