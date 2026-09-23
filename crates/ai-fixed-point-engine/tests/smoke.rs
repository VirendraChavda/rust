use ai_fixed_point_engine::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
