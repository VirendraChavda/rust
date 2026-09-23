use ai_observe_prometheus::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
