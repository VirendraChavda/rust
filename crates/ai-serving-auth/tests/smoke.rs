use ai_serving_auth::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
