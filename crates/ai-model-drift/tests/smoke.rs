use ai_model_drift::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
