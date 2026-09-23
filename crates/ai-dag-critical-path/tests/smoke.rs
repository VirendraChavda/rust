use ai_dag_critical_path::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
