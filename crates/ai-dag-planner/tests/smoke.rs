use ai_dag_planner::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
