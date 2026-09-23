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
        let edges = vec![DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        }];
        assert!(detector.find_cycle(&nodes, &edges).is_none());
    }
}
