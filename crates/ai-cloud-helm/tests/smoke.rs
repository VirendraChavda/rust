use ai_cloud_helm::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
