use ai_prompt_ab_testing::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
