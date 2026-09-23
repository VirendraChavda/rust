use ai_serving_background_tasks::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
