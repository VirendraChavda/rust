use ai_graph_executor::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
