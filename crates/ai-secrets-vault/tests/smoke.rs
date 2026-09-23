use ai_secrets_vault::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
