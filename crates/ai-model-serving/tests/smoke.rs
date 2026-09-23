use ai_model_serving::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
