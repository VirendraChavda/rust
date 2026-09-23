use ai_serving_sse::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
