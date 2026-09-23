use ai_schema_model::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
