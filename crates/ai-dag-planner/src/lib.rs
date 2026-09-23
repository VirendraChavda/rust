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

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ExecutionPlan {
    pub ordered_nodes: Vec<NodeId>,
}

impl ExecutionPlan {
    pub fn len(&self) -> usize {
        self.ordered_nodes.len()
    }

    pub fn is_empty(&self) -> bool {
        self.ordered_nodes.is_empty()
    }
}

#[derive(Debug, Clone, Copy, Default)]
pub struct KahnTopologicalPlanner;

impl TopologicalPlanner for KahnTopologicalPlanner {
    fn topological_order(&self, nodes: &[NodeId], edges: &[DagEdge]) -> GraphResult<Vec<NodeId>> {
        for edge in edges {
            if edge.from == edge.to {
                return Err(GraphError::InvalidTopology(
                    "self-loop edge is not valid in DAG",
                ));
            }
        }

        let mut indegree: BTreeMap<NodeId, usize> =
            nodes.iter().copied().map(|node| (node, 0)).collect();
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

impl KahnTopologicalPlanner {
    pub fn build_plan(&self, nodes: &[NodeId], edges: &[DagEdge]) -> GraphResult<ExecutionPlan> {
        Ok(ExecutionPlan {
            ordered_nodes: self.topological_order(nodes, edges)?,
        })
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
        assert_eq!(order.first().copied(), Some(NodeId(1)));
        assert_eq!(order.last().copied(), Some(NodeId(3)));
    }

    #[test]
    fn self_loop_is_rejected() {
        let planner = KahnTopologicalPlanner;
        let nodes = vec![NodeId(1)];
        let edges = vec![DagEdge {
            from: NodeId(1),
            to: NodeId(1),
        }];
        assert!(planner.topological_order(&nodes, &edges).is_err());
    }

    #[test]
    fn execution_plan_wraps_order() {
        let planner = KahnTopologicalPlanner;
        let nodes = vec![NodeId(1), NodeId(2)];
        let edges = vec![DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        }];
        let plan = planner.build_plan(&nodes, &edges).unwrap();
        assert_eq!(plan.len(), 2);
        assert_eq!(plan.ordered_nodes[0], NodeId(1));
    }
}
