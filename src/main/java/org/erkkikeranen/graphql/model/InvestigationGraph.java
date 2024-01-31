package org.erkkikeranen.graphql.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.erkkikeranen.db.model.NodeEdge;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class InvestigationGraph {

	Integer id;
	String name;
	Boolean queryGraph;
	Map<Integer, Node> nodes;
	Map<Integer, Set<Edge>> incomingEdges;
	Map<Integer, Set<Edge>> outgoingEdges;

	public InvestigationGraph(Integer id, String name, Boolean queryGraph, List<NodeEdge> nodeEdges) {
		this.id = id;
		this.name = name;
		this.queryGraph = queryGraph;

		ArrayList<Node> nodeList = new ArrayList<>();
		ArrayList<Edge> edgeList = new ArrayList<>();
		nodeEdges.forEach(ne -> {
			nodeList.add(new Node(ne.getSourceId(), ne.getSource(), ne.getSourceProperties()));
			if (ne.getTarget() != null) {
				nodeList.add(new Node(ne.getTargetId(), ne.getTarget(), ne.getTargetProperties()));
				edgeList.add(new Edge(ne.getSourceId(), ne.getTargetId(), ne.getRelationship()));
			}

		});


		incomingEdges = edgeList.stream()
						.collect(Collectors.toMap(
										Edge::getTarget,
										Set::of,
										(a, b) -> {
											ArrayList<Edge> edges = new ArrayList<>(a);
											edges.add(b.stream().findFirst().orElse(new Edge()));
											return Set.copyOf(edges);
										}));

		outgoingEdges = edgeList.stream()
						.collect(Collectors.toMap(
										Edge::getSource,
										Set::of,
										(a, b) -> {
											ArrayList<Edge> edges = new ArrayList<>(a);
											edges.add(b.stream().findFirst().orElse(new Edge()));
											return Set.copyOf(edges);
										}));

		nodeList.forEach(node -> {
			Set<Edge> nodeIncoming = incomingEdges.get(node.getId());
			Set<Edge> nodeOutgoing = outgoingEdges.get(node.getId());

				ArrayList<Edge> edgeArrayList = new ArrayList<>();
				if (nodeIncoming != null) {
					edgeArrayList.addAll(nodeIncoming);
				}
				if (nodeOutgoing != null) {
					edgeArrayList.addAll(nodeOutgoing);
				}
				node.setEdges(Set.copyOf(edgeArrayList));

		});

		nodes = nodeList.stream().collect(Collectors.toMap(Node::getId, Function.identity(), (a, b) -> a));

	}

	public List<Node> nodesByLabel(String label) {
		return nodes.values().stream()
						.filter(n -> n.getLabel().equalsIgnoreCase(label))
						.collect(Collectors.toList());
	}

	public Set<Edge> allEdges() {
		ArrayList<Edge> edges = incomingEdges.values().stream().flatMap(Collection::stream).collect(Collectors.toCollection(ArrayList::new));
		edges.addAll(outgoingEdges.values().stream().flatMap(Collection::stream).collect(Collectors.toList()));
		return Set.copyOf(edges);
	}
}
