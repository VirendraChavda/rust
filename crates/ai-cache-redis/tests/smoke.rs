use ai_cache_redis::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
