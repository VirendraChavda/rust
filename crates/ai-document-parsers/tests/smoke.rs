use ai_document_parsers::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
