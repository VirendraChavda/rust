use ai_graph_migrations::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
