use ai_document_ocr::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
