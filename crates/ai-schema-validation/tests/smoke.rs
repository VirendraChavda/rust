use ai_schema_validation::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
