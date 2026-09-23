use ai_observe_opentelemetry::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
