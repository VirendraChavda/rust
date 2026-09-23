use ai_graph_cancellation::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
