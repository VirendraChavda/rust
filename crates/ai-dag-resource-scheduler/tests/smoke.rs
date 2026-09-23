use ai_dag_resource_scheduler::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
