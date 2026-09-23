use ai_audit_log::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
