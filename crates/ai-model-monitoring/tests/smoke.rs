use ai_model_monitoring::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
