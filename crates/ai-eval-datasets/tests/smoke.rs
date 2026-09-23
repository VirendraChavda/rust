use ai_eval_datasets::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
