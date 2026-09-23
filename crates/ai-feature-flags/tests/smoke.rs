use ai_feature_flags::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
