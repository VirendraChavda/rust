use ai_dag_backfill::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
