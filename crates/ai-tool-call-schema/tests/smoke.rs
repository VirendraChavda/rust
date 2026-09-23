use ai_tool_call_schema::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
