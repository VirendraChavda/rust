use ai_serving_openapi::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
