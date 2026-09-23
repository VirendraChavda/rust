use ai_serving_lifespan::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
