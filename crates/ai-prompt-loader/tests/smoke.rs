use ai_prompt_loader::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
