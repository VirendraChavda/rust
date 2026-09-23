use ai_graph_determinism::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
