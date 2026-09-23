use ai_integration_github::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
