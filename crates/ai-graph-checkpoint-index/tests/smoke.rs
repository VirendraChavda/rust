use ai_graph_checkpoint_index::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
