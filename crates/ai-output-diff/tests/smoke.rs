use ai_output_diff::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
