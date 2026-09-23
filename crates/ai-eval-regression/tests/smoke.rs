use ai_eval_regression::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
