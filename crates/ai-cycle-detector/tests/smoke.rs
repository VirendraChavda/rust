use ai_cycle_detector::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
