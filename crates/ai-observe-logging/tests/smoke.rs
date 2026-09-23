use ai_observe_logging::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
