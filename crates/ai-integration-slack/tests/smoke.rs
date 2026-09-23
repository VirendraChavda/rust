use ai_integration_slack::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
