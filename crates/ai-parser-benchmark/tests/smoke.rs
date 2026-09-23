use ai_parser_benchmark::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
