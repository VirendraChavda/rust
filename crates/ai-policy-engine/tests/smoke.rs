use ai_policy_engine::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
