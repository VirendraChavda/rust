use ai_graph_debugger::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
