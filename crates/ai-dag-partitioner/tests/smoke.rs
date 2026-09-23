use ai_dag_partitioner::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
