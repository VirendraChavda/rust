use ai_feature_store_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
