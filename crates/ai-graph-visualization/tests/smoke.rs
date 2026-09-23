use ai_graph_visualization::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
