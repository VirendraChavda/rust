use ai_agent_transcript::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
