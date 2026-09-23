use ai_store_redis::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
