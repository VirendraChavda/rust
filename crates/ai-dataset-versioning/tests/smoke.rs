use ai_dataset_versioning::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
