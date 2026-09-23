use ai_auth_jwt::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
