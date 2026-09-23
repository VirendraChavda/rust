use ai_iterative_convergence::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
