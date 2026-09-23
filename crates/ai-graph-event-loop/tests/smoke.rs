use ai_graph_event_loop::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
