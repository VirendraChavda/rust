use ai_feedback_edges::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
