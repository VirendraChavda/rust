use ai_config_runtime::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
