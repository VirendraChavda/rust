use ai_request_signing::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
