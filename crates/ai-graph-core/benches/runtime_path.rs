use ai_graph_core::{
    CancellationToken, DeterministicExecutor, ExecutionConfig, ExecutionId, GraphNode, GraphResult,
    NodeId, StepOutcome, stable_hash,
};
use ai_graph_executor::SequentialExecutor;
use criterion::{Criterion, black_box, criterion_group, criterion_main};

struct BenchNode {
    id: NodeId,
}

impl GraphNode for BenchNode {
    fn id(&self) -> NodeId {
        self.id
    }

    fn execute(&self, input: &str) -> GraphResult<String> {
        Ok(format!("{}:{input}", self.id.0))
    }
}

#[derive(Debug, Clone, Copy)]
struct BenchDeterministicExecutor;

impl DeterministicExecutor for BenchDeterministicExecutor {
    fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome> {
        let output = node.execute(input)?;
        Ok(StepOutcome {
            node: node.id(),
            replay_fingerprint: stable_hash(&output),
            output,
        })
    }

    fn replay_seed(&self) -> u64 {
        17
    }
}

fn bench_runtime_path(c: &mut Criterion) {
    let runner = SequentialExecutor::new(BenchDeterministicExecutor);
    let n1 = BenchNode { id: NodeId(1) };
    let n2 = BenchNode { id: NodeId(2) };
    let n3 = BenchNode { id: NodeId(3) };
    let nodes: [&dyn GraphNode; 3] = [&n1, &n2, &n3];
    let cfg = ExecutionConfig {
        max_retries: 0,
        timeout_ms: 200,
    };
    let cancellation = CancellationToken::new();

    c.bench_function("graph_runtime_exact_path_3_nodes", |b| {
        b.iter(|| {
            let report = runner
                .execute_runtime(
                    ExecutionId(black_box(42)),
                    black_box(&nodes),
                    black_box("payload"),
                    cfg,
                    &cancellation,
                )
                .unwrap();
            black_box(report.succeeded_nodes());
        })
    });
}

criterion_group!(benches, bench_runtime_path);
criterion_main!(benches);
