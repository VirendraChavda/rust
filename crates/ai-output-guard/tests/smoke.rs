use ai_output_guard::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
