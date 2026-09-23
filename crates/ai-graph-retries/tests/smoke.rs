use ai_graph_retries::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
