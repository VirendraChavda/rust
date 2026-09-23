use ai_migrations_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
