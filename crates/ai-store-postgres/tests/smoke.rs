use ai_store_postgres::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
