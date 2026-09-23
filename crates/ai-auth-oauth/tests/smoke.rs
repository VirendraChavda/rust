use ai_auth_oauth::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
