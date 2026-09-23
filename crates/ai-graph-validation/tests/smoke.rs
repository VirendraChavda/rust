use ai_graph_validation::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
