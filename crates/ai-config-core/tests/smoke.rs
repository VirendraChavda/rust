use ai_config_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
