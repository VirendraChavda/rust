use ai_serving_error_model::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
