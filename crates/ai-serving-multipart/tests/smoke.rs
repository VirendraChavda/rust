use ai_serving_multipart::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
