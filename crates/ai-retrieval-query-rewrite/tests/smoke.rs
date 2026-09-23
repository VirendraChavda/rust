use ai_retrieval_query_rewrite::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
