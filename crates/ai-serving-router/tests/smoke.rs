use ai_serving_router::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
