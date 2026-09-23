use ai_tool_call_parser::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
