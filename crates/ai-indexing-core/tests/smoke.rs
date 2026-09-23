use ai_indexing_core::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
