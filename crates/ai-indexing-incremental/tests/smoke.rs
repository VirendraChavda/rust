use ai_indexing_incremental::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
