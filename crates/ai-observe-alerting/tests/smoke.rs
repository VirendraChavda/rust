use ai_observe_alerting::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
