use ai_graph_signal_bus::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
