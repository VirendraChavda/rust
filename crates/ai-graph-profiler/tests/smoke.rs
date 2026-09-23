use ai_graph_profiler::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
