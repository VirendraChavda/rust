use ai_graph_replay_trace::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
