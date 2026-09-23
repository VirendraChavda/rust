use ai_document_pdf::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
