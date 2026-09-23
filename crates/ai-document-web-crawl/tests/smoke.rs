use ai_document_web_crawl::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
