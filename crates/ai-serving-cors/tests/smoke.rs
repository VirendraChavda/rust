use ai_serving_cors::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
