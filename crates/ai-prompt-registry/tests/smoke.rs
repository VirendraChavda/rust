use ai_prompt_registry::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
