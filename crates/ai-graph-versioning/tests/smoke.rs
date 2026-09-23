use ai_graph_versioning::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
