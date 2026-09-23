use ai_json_repair::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
