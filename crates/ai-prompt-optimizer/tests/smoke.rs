use ai_prompt_optimizer::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
