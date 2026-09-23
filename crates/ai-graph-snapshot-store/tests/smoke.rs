use ai_graph_snapshot_store::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
