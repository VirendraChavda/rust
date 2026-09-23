use ai_graph_timeouts::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
