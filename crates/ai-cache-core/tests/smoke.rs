use ai_cache_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
