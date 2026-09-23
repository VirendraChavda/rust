use ai_graph_schema::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
