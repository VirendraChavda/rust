use ai_dag_toposort::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
