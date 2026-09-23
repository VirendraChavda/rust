use ai_graph_typing::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
