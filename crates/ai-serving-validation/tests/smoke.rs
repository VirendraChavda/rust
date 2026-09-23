use ai_serving_validation::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
