use ai_scc_analyzer::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
