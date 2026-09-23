use ai_store_mongodb::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
