use ai_serving_upload::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
