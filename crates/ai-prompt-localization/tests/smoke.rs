use ai_prompt_localization::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
