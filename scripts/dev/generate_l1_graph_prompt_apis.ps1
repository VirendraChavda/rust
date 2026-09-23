$ErrorActionPreference = "Stop"

function Convert-ToPascalCase {
    param([string]$Value)
    $parts = $Value -split '-'
    ($parts | ForEach-Object {
        if ($_.Length -eq 0) { return "" }
        $_.Substring(0, 1).ToUpper() + $_.Substring(1)
    }) -join ""
}

function Ensure-Dependency {
    param(
        [string]$CargoTomlPath,
        [string]$DependencyLine
    )

    $content = Get-Content $CargoTomlPath -Raw
    if ($content -notmatch '(?m)^\[dependencies\]$') {
        $content = $content.TrimEnd() + "`n`n[dependencies]`n"
    }

    if ($content -notmatch [regex]::Escape(($DependencyLine -split '=')[0].Trim())) {
        if ($content -notmatch "`n$") {
            $content += "`n"
        }
        $content += "$DependencyLine`n"
    }

    Set-Content -Path $CargoTomlPath -Value $content -NoNewline
}

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")

$promptCrates = @(
    "ai-prompt-registry",
    "ai-prompt-loader",
    "ai-prompt-renderer",
    "ai-prompt-optimizer",
    "ai-prompt-ab-testing",
    "ai-prompt-localization",
    "ai-output-parser-core",
    "ai-output-guard",
    "ai-output-diff",
    "ai-json-parser-core",
    "ai-json-repair",
    "ai-tool-call-schema",
    "ai-tool-call-parser",
    "ai-agent-memory-window",
    "ai-agent-transcript",
    "ai-agent-planner",
    "ai-agent-executor",
    "ai-agent-fallback",
    "ai-agent-simulation",
    "ai-parser-benchmark"
)

foreach ($crate in $promptCrates) {
    $src = Join-Path $root "crates\$crate\src"
    $coreName = $crate -replace '^ai-', ''
    $traitName = (Convert-ToPascalCase $coreName) + "Contract"

    $errorsRs = @"
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PipelineError {
    InvalidInput(&'static str),
    NotFound(String),
    ParseFailure(String),
    PolicyViolation(&'static str),
    Internal(String),
}

pub type PipelineResult<T> = Result<T, PipelineError>;
"@

    $contractsRs = @"
use crate::errors::PipelineResult;

pub trait $traitName {
    fn contract_name(&self) -> &'static str;
    fn validate(&self, payload: &str) -> PipelineResult<()>;
}
"@

    $libRs = @"
pub mod contracts;
pub mod errors;

pub use contracts::$traitName;
pub use errors::{PipelineError, PipelineResult};

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn health_is_ok() {
        assert_eq!(health(), "ok");
    }

    #[test]
    fn pipeline_error_equality() {
        let lhs = PipelineError::InvalidInput("payload");
        let rhs = PipelineError::InvalidInput("payload");
        assert_eq!(lhs, rhs);
    }
}
"@

    Set-Content -Path (Join-Path $src "errors.rs") -Value $errorsRs -NoNewline
    Set-Content -Path (Join-Path $src "contracts.rs") -Value $contractsRs -NoNewline
    Set-Content -Path (Join-Path $src "lib.rs") -Value $libRs -NoNewline
}

$graphCore = @'
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct NodeId(pub u64);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct EdgeId(pub u64);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct ExecutionId(pub u64);

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum GraphError {
    InvalidTopology(&'static str),
    NodeFailure { node: NodeId, message: String },
    ReplayMismatch(&'static str),
    Timeout(&'static str),
    Internal(String),
}

pub type GraphResult<T> = Result<T, GraphError>;

pub fn stable_hash(input: &str) -> u64 {
    let mut hash = 14695981039346656037_u64;
    for byte in input.as_bytes() {
        hash ^= u64::from(*byte);
        hash = hash.wrapping_mul(1099511628211_u64);
    }
    hash
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct StepOutcome {
    pub node: NodeId,
    pub output: String,
    pub replay_fingerprint: u64,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ReplayEvent {
    pub execution_id: ExecutionId,
    pub node: NodeId,
    pub input_hash: u64,
    pub output_hash: u64,
}

pub trait GraphNode {
    fn id(&self) -> NodeId;
    fn execute(&self, input: &str) -> GraphResult<String>;
}

pub trait DeterministicExecutor {
    fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome>;
    fn replay_seed(&self) -> u64;
}

pub trait ReplayRecorder {
    fn record(&mut self, event: ReplayEvent);
    fn events(&self) -> &[ReplayEvent];
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn stable_hash_is_deterministic() {
        assert_eq!(stable_hash("abc"), stable_hash("abc"));
    }

    #[test]
    fn stable_hash_changes_for_different_inputs() {
        assert_ne!(stable_hash("abc"), stable_hash("abd"));
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-core\src\lib.rs") -Value $graphCore -NoNewline

$graphDeterminism = @'
use ai_graph_core::{stable_hash, GraphError, GraphResult};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DeterminismMode {
    Strict,
    BestEffort,
}

pub trait DeterminismPolicy {
    fn mode(&self) -> DeterminismMode;
    fn fingerprint(&self, payload: &str) -> u64;
    fn verify_pair(&self, left: &str, right: &str) -> GraphResult<()>;
}

#[derive(Debug, Default, Clone, Copy)]
pub struct StrictDeterminismPolicy;

impl DeterminismPolicy for StrictDeterminismPolicy {
    fn mode(&self) -> DeterminismMode {
        DeterminismMode::Strict
    }

    fn fingerprint(&self, payload: &str) -> u64 {
        stable_hash(payload)
    }

    fn verify_pair(&self, left: &str, right: &str) -> GraphResult<()> {
        if self.fingerprint(left) == self.fingerprint(right) {
            Ok(())
        } else {
            Err(GraphError::ReplayMismatch("fingerprint mismatch"))
        }
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn strict_policy_detects_mismatch() {
        let policy = StrictDeterminismPolicy;
        assert!(policy.verify_pair("a", "b").is_err());
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-determinism\src\lib.rs") -Value $graphDeterminism -NoNewline

$graphReplay = @'
use ai_graph_core::{ExecutionId, NodeId, ReplayEvent};

#[derive(Debug, Clone, Default)]
pub struct ReplayTrace {
    pub events: Vec<ReplayEvent>,
}

pub trait ReplayTraceStore {
    fn append(&mut self, event: ReplayEvent);
    fn by_execution(&self, execution_id: ExecutionId) -> Vec<ReplayEvent>;
    fn by_node(&self, node: NodeId) -> Vec<ReplayEvent>;
}

#[derive(Debug, Clone, Default)]
pub struct InMemoryReplayTraceStore {
    pub trace: ReplayTrace,
}

impl ReplayTraceStore for InMemoryReplayTraceStore {
    fn append(&mut self, event: ReplayEvent) {
        self.trace.events.push(event);
    }

    fn by_execution(&self, execution_id: ExecutionId) -> Vec<ReplayEvent> {
        self.trace
            .events
            .iter()
            .copied()
            .filter(|event| event.execution_id == execution_id)
            .collect()
    }

    fn by_node(&self, node: NodeId) -> Vec<ReplayEvent> {
        self.trace
            .events
            .iter()
            .copied()
            .filter(|event| event.node == node)
            .collect()
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn stores_event_by_execution() {
        let mut store = InMemoryReplayTraceStore::default();
        store.append(ReplayEvent {
            execution_id: ExecutionId(7),
            node: NodeId(1),
            input_hash: 1,
            output_hash: 2,
        });
        assert_eq!(store.by_execution(ExecutionId(7)).len(), 1);
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-replay-trace\src\lib.rs") -Value $graphReplay -NoNewline

$checkpointIndex = @'
use ai_graph_core::ExecutionId;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct CheckpointPointer {
    pub execution_id: ExecutionId,
    pub step: u64,
    pub token: String,
}

pub trait CheckpointIndex {
    fn insert(&mut self, pointer: CheckpointPointer);
    fn latest(&self, execution_id: ExecutionId) -> Option<CheckpointPointer>;
}

#[derive(Debug, Clone, Default)]
pub struct InMemoryCheckpointIndex {
    pointers: Vec<CheckpointPointer>,
}

impl CheckpointIndex for InMemoryCheckpointIndex {
    fn insert(&mut self, pointer: CheckpointPointer) {
        self.pointers.push(pointer);
    }

    fn latest(&self, execution_id: ExecutionId) -> Option<CheckpointPointer> {
        self.pointers
            .iter()
            .filter(|pointer| pointer.execution_id == execution_id)
            .max_by_key(|pointer| pointer.step)
            .cloned()
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn latest_pointer_is_returned() {
        let mut index = InMemoryCheckpointIndex::default();
        index.insert(CheckpointPointer {
            execution_id: ExecutionId(1),
            step: 1,
            token: "a".to_string(),
        });
        index.insert(CheckpointPointer {
            execution_id: ExecutionId(1),
            step: 3,
            token: "b".to_string(),
        });
        assert_eq!(index.latest(ExecutionId(1)).unwrap().step, 3);
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-checkpoint-index\src\lib.rs") -Value $checkpointIndex -NoNewline

$snapshotStore = @'
use ai_graph_core::ExecutionId;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct SnapshotRecord {
    pub execution_id: ExecutionId,
    pub revision: u64,
    pub payload: String,
}

pub trait SnapshotStore {
    fn save(&mut self, snapshot: SnapshotRecord);
    fn load_latest(&self, execution_id: ExecutionId) -> Option<SnapshotRecord>;
}

#[derive(Debug, Clone, Default)]
pub struct InMemorySnapshotStore {
    snapshots: Vec<SnapshotRecord>,
}

impl SnapshotStore for InMemorySnapshotStore {
    fn save(&mut self, snapshot: SnapshotRecord) {
        self.snapshots.push(snapshot);
    }

    fn load_latest(&self, execution_id: ExecutionId) -> Option<SnapshotRecord> {
        self.snapshots
            .iter()
            .filter(|record| record.execution_id == execution_id)
            .max_by_key(|record| record.revision)
            .cloned()
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn latest_snapshot_is_returned() {
        let mut store = InMemorySnapshotStore::default();
        store.save(SnapshotRecord {
            execution_id: ExecutionId(9),
            revision: 1,
            payload: "a".to_string(),
        });
        store.save(SnapshotRecord {
            execution_id: ExecutionId(9),
            revision: 2,
            payload: "b".to_string(),
        });
        assert_eq!(store.load_latest(ExecutionId(9)).unwrap().revision, 2);
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-snapshot-store\src\lib.rs") -Value $snapshotStore -NoNewline

$graphExecutor = @'
use ai_graph_core::{DeterministicExecutor, GraphNode, GraphResult, StepOutcome};

pub trait GraphExecutor {
    fn execute(&self, nodes: &[&dyn GraphNode], input: &str) -> GraphResult<Vec<StepOutcome>>;
}

#[derive(Debug, Clone)]
pub struct SequentialExecutor<T>
where
    T: DeterministicExecutor,
{
    inner: T,
}

impl<T> SequentialExecutor<T>
where
    T: DeterministicExecutor,
{
    pub fn new(inner: T) -> Self {
        Self { inner }
    }
}

impl<T> GraphExecutor for SequentialExecutor<T>
where
    T: DeterministicExecutor,
{
    fn execute(&self, nodes: &[&dyn GraphNode], input: &str) -> GraphResult<Vec<StepOutcome>> {
        let mut outcomes = Vec::with_capacity(nodes.len());
        for node in nodes {
            outcomes.push(self.inner.execute_step(*node, input)?);
        }
        Ok(outcomes)
    }
}

pub fn health() -> &'static str {
    "ok"
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-executor\src\lib.rs") -Value $graphExecutor -NoNewline

$dagPlanner = @'
use ai_graph_core::{GraphError, GraphResult, NodeId};
use std::collections::{BTreeMap, BTreeSet, VecDeque};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct DagEdge {
    pub from: NodeId,
    pub to: NodeId,
}

pub trait TopologicalPlanner {
    fn topological_order(&self, nodes: &[NodeId], edges: &[DagEdge]) -> GraphResult<Vec<NodeId>>;
}

#[derive(Debug, Clone, Copy, Default)]
pub struct KahnTopologicalPlanner;

impl TopologicalPlanner for KahnTopologicalPlanner {
    fn topological_order(&self, nodes: &[NodeId], edges: &[DagEdge]) -> GraphResult<Vec<NodeId>> {
        let mut indegree: BTreeMap<NodeId, usize> = nodes.iter().copied().map(|node| (node, 0)).collect();
        for edge in edges {
            if let Some(value) = indegree.get_mut(&edge.to) {
                *value += 1;
            }
        }

        let mut outgoing: BTreeMap<NodeId, Vec<NodeId>> = BTreeMap::new();
        for edge in edges {
            outgoing.entry(edge.from).or_default().push(edge.to);
        }

        let mut queue: VecDeque<NodeId> = indegree
            .iter()
            .filter_map(|(node, degree)| if *degree == 0 { Some(*node) } else { None })
            .collect();

        let mut order = Vec::with_capacity(nodes.len());
        while let Some(node) = queue.pop_front() {
            order.push(node);
            if let Some(children) = outgoing.get(&node) {
                for child in children {
                    if let Some(child_degree) = indegree.get_mut(child) {
                        *child_degree -= 1;
                        if *child_degree == 0 {
                            queue.push_back(*child);
                        }
                    }
                }
            }
        }

        if order.len() != nodes.len() {
            return Err(GraphError::InvalidTopology("cycle detected in DAG plan"));
        }

        let expected: BTreeSet<NodeId> = nodes.iter().copied().collect();
        let actual: BTreeSet<NodeId> = order.iter().copied().collect();
        if expected != actual {
            return Err(GraphError::InvalidTopology("planner lost nodes"));
        }

        Ok(order)
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn simple_dag_is_ordered() {
        let planner = KahnTopologicalPlanner;
        let nodes = vec![NodeId(1), NodeId(2), NodeId(3)];
        let edges = vec![
            DagEdge { from: NodeId(1), to: NodeId(2) },
            DagEdge { from: NodeId(2), to: NodeId(3) },
        ];
        let order = planner.topological_order(&nodes, &edges).unwrap();
        assert_eq!(order.first().copied(), Some(NodeId(1)));
        assert_eq!(order.last().copied(), Some(NodeId(3)));
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-dag-planner\src\lib.rs") -Value $dagPlanner -NoNewline

$cycleDetector = @'
use ai_dag_planner::DagEdge;
use ai_graph_core::NodeId;

pub trait CycleDetector {
    fn find_cycle(&self, nodes: &[NodeId], edges: &[DagEdge]) -> Option<Vec<NodeId>>;
}

#[derive(Debug, Clone, Copy, Default)]
pub struct PairCycleDetector;

impl CycleDetector for PairCycleDetector {
    fn find_cycle(&self, nodes: &[NodeId], edges: &[DagEdge]) -> Option<Vec<NodeId>> {
        for left in edges {
            for right in edges {
                if left.from == right.to && left.to == right.from && nodes.contains(&left.from) {
                    return Some(vec![left.from, left.to]);
                }
            }
        }
        None
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn no_cycle_returns_none() {
        let detector = PairCycleDetector;
        let nodes = vec![NodeId(1), NodeId(2)];
        let edges = vec![DagEdge { from: NodeId(1), to: NodeId(2) }];
        assert!(detector.find_cycle(&nodes, &edges).is_none());
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-cycle-detector\src\lib.rs") -Value $cycleDetector -NoNewline

$fixedPoint = @'
use ai_graph_core::{GraphError, GraphResult};

pub trait FixedPointEngine {
    fn converge<F>(&self, input: String, step: F) -> GraphResult<String>
    where
        F: Fn(&str) -> String;
}

#[derive(Debug, Clone, Copy)]
pub struct BoundedFixedPointEngine {
    pub max_iterations: usize,
}

impl FixedPointEngine for BoundedFixedPointEngine {
    fn converge<F>(&self, mut input: String, step: F) -> GraphResult<String>
    where
        F: Fn(&str) -> String,
    {
        for _ in 0..self.max_iterations {
            let next = step(&input);
            if next == input {
                return Ok(next);
            }
            input = next;
        }
        Err(GraphError::Timeout("fixed-point not reached within iteration budget"))
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn converges_to_lowercase() {
        let engine = BoundedFixedPointEngine { max_iterations: 4 };
        let result = engine
            .converge("HELLO".to_string(), |value| value.to_lowercase())
            .unwrap();
        assert_eq!(result, "hello");
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-fixed-point-engine\src\lib.rs") -Value $fixedPoint -NoNewline

$iterativeConvergence = @'
use ai_graph_core::{GraphError, GraphResult};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ConvergenceReport {
    pub value: String,
    pub iterations: usize,
}

pub trait ConvergenceStrategy {
    fn run<F>(&self, input: String, step: F) -> GraphResult<ConvergenceReport>
    where
        F: Fn(&str) -> String;
}

#[derive(Debug, Clone, Copy)]
pub struct BoundedConvergence {
    pub limit: usize,
}

impl ConvergenceStrategy for BoundedConvergence {
    fn run<F>(&self, mut input: String, step: F) -> GraphResult<ConvergenceReport>
    where
        F: Fn(&str) -> String,
    {
        for iteration in 1..=self.limit {
            let next = step(&input);
            if next == input {
                return Ok(ConvergenceReport {
                    value: next,
                    iterations: iteration,
                });
            }
            input = next;
        }
        Err(GraphError::Timeout("convergence limit reached"))
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn report_is_returned_for_stable_step() {
        let strategy = BoundedConvergence { limit: 2 };
        let report = strategy.run("x".to_string(), |value| value.to_string()).unwrap();
        assert_eq!(report.value, "x");
        assert_eq!(report.iterations, 1);
    }
}
'@
Set-Content -Path (Join-Path $root "crates\ai-iterative-convergence\src\lib.rs") -Value $iterativeConvergence -NoNewline

$runtimeWithCoreDep = @(
    "ai-graph-determinism",
    "ai-graph-replay-trace",
    "ai-graph-checkpoint-index",
    "ai-graph-snapshot-store",
    "ai-graph-executor",
    "ai-dag-planner",
    "ai-cycle-detector",
    "ai-fixed-point-engine",
    "ai-iterative-convergence"
)

foreach ($crate in $runtimeWithCoreDep) {
    Ensure-Dependency -CargoTomlPath (Join-Path $root "crates\$crate\Cargo.toml") -DependencyLine 'ai-graph-core = { path = "../ai-graph-core" }'
}

Ensure-Dependency -CargoTomlPath (Join-Path $root "crates\ai-cycle-detector\Cargo.toml") -DependencyLine 'ai-dag-planner = { path = "../ai-dag-planner" }'

$graphCoreCargo = Join-Path $root "crates\ai-graph-core\Cargo.toml"
$graphCoreContent = Get-Content $graphCoreCargo -Raw
if ($graphCoreContent -notmatch '(?m)^\[dev-dependencies\]$') {
    $graphCoreContent = $graphCoreContent.TrimEnd() + "`n`n[dev-dependencies]`n"
}
foreach ($line in @(
    'ai-dag-planner = { path = "../ai-dag-planner" }',
    'ai-cycle-detector = { path = "../ai-cycle-detector" }',
    'ai-fixed-point-engine = { path = "../ai-fixed-point-engine" }',
    'ai-graph-executor = { path = "../ai-graph-executor" }'
)) {
    if ($graphCoreContent -notmatch [regex]::Escape(($line -split '=')[0].Trim())) {
        if ($graphCoreContent -notmatch "`n$") {
            $graphCoreContent += "`n"
        }
        $graphCoreContent += "$line`n"
    }
}
Set-Content -Path $graphCoreCargo -Value $graphCoreContent -NoNewline

$dagCyclicHarness = @'
use ai_cycle_detector::{CycleDetector, PairCycleDetector};
use ai_dag_planner::{DagEdge, KahnTopologicalPlanner, TopologicalPlanner};
use ai_fixed_point_engine::{BoundedFixedPointEngine, FixedPointEngine};
use ai_graph_core::{
    stable_hash, DeterministicExecutor, GraphError, GraphNode, GraphResult, NodeId, StepOutcome,
};
use ai_graph_executor::{GraphExecutor, SequentialExecutor};

struct EchoNode {
    id: NodeId,
}

impl GraphNode for EchoNode {
    fn id(&self) -> NodeId {
        self.id
    }

    fn execute(&self, input: &str) -> GraphResult<String> {
        Ok(format!("{}:{}", self.id.0, input))
    }
}

#[derive(Debug, Clone, Copy)]
struct SimpleDeterministicExecutor;

impl DeterministicExecutor for SimpleDeterministicExecutor {
    fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome> {
        let output = node.execute(input)?;
        Ok(StepOutcome {
            node: node.id(),
            replay_fingerprint: stable_hash(&output),
            output,
        })
    }

    fn replay_seed(&self) -> u64 {
        7
    }
}

#[test]
fn topological_planner_returns_complete_order() {
    let planner = KahnTopologicalPlanner;
    let nodes = vec![NodeId(1), NodeId(2), NodeId(3)];
    let edges = vec![
        DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        },
        DagEdge {
            from: NodeId(2),
            to: NodeId(3),
        },
    ];
    let order = planner.topological_order(&nodes, &edges).unwrap();
    assert_eq!(order.len(), 3);
    assert_eq!(order[0], NodeId(1));
}

#[test]
fn cycle_detector_finds_two_node_cycle() {
    let detector = PairCycleDetector;
    let nodes = vec![NodeId(1), NodeId(2)];
    let edges = vec![
        DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        },
        DagEdge {
            from: NodeId(2),
            to: NodeId(1),
        },
    ];
    let cycle = detector.find_cycle(&nodes, &edges);
    assert!(cycle.is_some());
}

#[test]
fn fixed_point_engine_converges() {
    let engine = BoundedFixedPointEngine { max_iterations: 5 };
    let out = engine
        .converge("HELLO".to_string(), |value| value.to_lowercase())
        .unwrap();
    assert_eq!(out, "hello");
}

#[test]
fn sequential_executor_yields_outcome() {
    let exec = SequentialExecutor::new(SimpleDeterministicExecutor);
    let node = EchoNode { id: NodeId(5) };
    let outcomes = exec.execute(&[&node], "ping").unwrap();
    assert_eq!(outcomes.len(), 1);
    assert_eq!(outcomes[0].node, NodeId(5));
    assert!(outcomes[0].output.contains("ping"));
}

#[test]
fn planner_rejects_cycle() {
    let planner = KahnTopologicalPlanner;
    let nodes = vec![NodeId(1), NodeId(2)];
    let edges = vec![
        DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        },
        DagEdge {
            from: NodeId(2),
            to: NodeId(1),
        },
    ];
    let err = planner.topological_order(&nodes, &edges).unwrap_err();
    assert!(matches!(err, GraphError::InvalidTopology(_)));
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-core\tests\dag_and_cyclic_harness.rs") -Value $dagCyclicHarness -NoNewline

$loadBaseline = @'
use ai_graph_core::{stable_hash, DeterministicExecutor, GraphNode, GraphResult, NodeId, StepOutcome};
use ai_graph_executor::{GraphExecutor, SequentialExecutor};
use std::time::{Duration, Instant};

struct FastNode;

impl GraphNode for FastNode {
    fn id(&self) -> NodeId {
        NodeId(1)
    }

    fn execute(&self, input: &str) -> GraphResult<String> {
        Ok(input.to_string())
    }
}

#[derive(Debug, Clone, Copy)]
struct FastExecutor;

impl DeterministicExecutor for FastExecutor {
    fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome> {
        let output = node.execute(input)?;
        Ok(StepOutcome {
            node: node.id(),
            replay_fingerprint: stable_hash(&output),
            output,
        })
    }

    fn replay_seed(&self) -> u64 {
        1
    }
}

#[test]
fn baseline_hash_loop_under_budget() {
    let start = Instant::now();
    let mut acc = 0_u64;
    for idx in 0..50_000_u64 {
        acc ^= stable_hash(&format!("payload-{idx}"));
    }
    assert_ne!(acc, 0);
    assert!(start.elapsed() < Duration::from_secs(15));
}

#[test]
fn baseline_executor_loop_under_budget() {
    let start = Instant::now();
    let node = FastNode;
    let runner = SequentialExecutor::new(FastExecutor);

    let mut total = 0_usize;
    for _ in 0..50_000 {
        total += runner.execute(&[&node], "ok").unwrap().len();
    }

    assert_eq!(total, 50_000);
    assert!(start.elapsed() < Duration::from_secs(15));
}
'@
Set-Content -Path (Join-Path $root "crates\ai-graph-core\tests\load_baseline.rs") -Value $loadBaseline -NoNewline

Write-Host "L1 API generation complete."
