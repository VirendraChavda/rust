use ai_superstep_runtime::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
