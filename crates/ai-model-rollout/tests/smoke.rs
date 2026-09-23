use ai_model_rollout::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
