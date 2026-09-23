use ai_graph_admin_api::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
