use ai_cloud_kubernetes::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
