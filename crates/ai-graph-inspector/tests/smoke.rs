use ai_graph_inspector::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
