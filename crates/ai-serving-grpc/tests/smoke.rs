use ai_serving_grpc::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
