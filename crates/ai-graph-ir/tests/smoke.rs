use ai_graph_ir::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
