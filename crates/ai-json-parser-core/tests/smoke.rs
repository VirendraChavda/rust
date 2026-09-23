use ai_json_parser_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
