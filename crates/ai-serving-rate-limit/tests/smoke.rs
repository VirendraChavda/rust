use ai_serving_rate_limit::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
