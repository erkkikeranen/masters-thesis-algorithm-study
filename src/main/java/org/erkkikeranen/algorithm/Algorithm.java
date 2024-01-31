package org.erkkikeranen.algorithm;

import lombok.extern.slf4j.Slf4j;
import org.erkkikeranen.graphql.model.Edge;
import org.erkkikeranen.graphql.model.InvestigationGraph;
import org.erkkikeranen.graphql.model.Node;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class Algorithm {


	/**
	 * similarityMeasure matches suitable subgraphs in knowledgegraph by given querygraph
	 *
	 * @param investigationQueryGraph
	 * @param investigationKnowledgeGraph
	 * @param queryFocusLabel
	 * @return
	 */
	public Map<Integer, Set<Node>> similarityMeasure(InvestigationGraph investigationQueryGraph,
																									 InvestigationGraph investigationKnowledgeGraph,
																									 String queryFocusLabel) {

		Map<Integer, Set<Node>> matchGraphs = searchSimilarGraphs(investigationQueryGraph,
						investigationKnowledgeGraph,
						queryFocusLabel);

		return matchGraphs;
	}

	/**
	 * matches suitable subgraphs with their networks. results include the main match and additional matches
	 *
	 * drops results where no network neighborhood available
	 *
	 * @param investigationQueryGraph
	 * @param investigationKnowledgeGraph
	 * @param queryFocusLabel
	 * @return
	 */
	public Map<Integer, List<Set<Node>>> neighborhoodSimilarity(InvestigationGraph investigationQueryGraph,
																															InvestigationGraph investigationKnowledgeGraph,
																															String queryFocusLabel) {

		Map<Integer, Set<Node>> matchGraphs = searchSimilarGraphs(investigationQueryGraph,
						investigationKnowledgeGraph,
						queryFocusLabel);

		Map<Integer, Set<Node>> neighborhoodNodes = searchNeighborNodes(matchGraphs, investigationKnowledgeGraph);

		Map<Integer, List<Set<Node>>> neighborhoodMatchesGraphs =
						neighborhoodNodes.entrySet().stream().map(matchGraph -> {
											Set<Node> neighbors = matchGraph.getValue();

											ArrayList<Map<Integer, Set<Node>>> result = new ArrayList<>(List.of(Map.of(matchGraph.getKey(), matchGraphs.get(matchGraph.getKey()))));

											// nämä avaimet pitää vaihtaa matchGraph Id:ksi
											List<Map<Integer, Set<Node>>> intermediate = neighbors.stream().map(neighbor -> searchSimilarGraphs(
															investigationQueryGraph,
															investigationKnowledgeGraph,
															queryFocusLabel,
															Set.of(neighbor)))
															.map(Map::entrySet).map(es -> es.stream()
																			.map(e -> Map.entry(matchGraph.getKey(), e.getValue()))
															.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)))
															.collect(Collectors.toList());

											result.addAll(intermediate);

											return result;
										}
						).flatMap(Collection::stream).flatMap(m -> m.entrySet().stream())
										.collect(Collectors.toMap(Map.Entry::getKey, e -> new ArrayList<>(List.of(e.getValue())),
														(a, b) -> {
															ArrayList<Set<Node>> temp = new ArrayList<>(a);
															temp.addAll(b);
															return temp;
														}));

		// drop if no neighborhood
		return neighborhoodMatchesGraphs;
						/*
						.keySet().stream()
						.filter(k -> neighborhoodMatchesGraphs.get(k).size() > 1)
						.collect(Collectors.toMap(Function.identity(), neighborhoodMatchesGraphs::get));

						 */

	}

	/**
	 * finds unlisted neighbornodes in match graphs for further analysis
	 * nn ← searchNeighborNodes(gm)
	 * <p>
	 * the response has a map with match graph id as key and set of unlisted nodes in value
	 *
	 * @param matchedGraphs = gm
	 * @return nn
	 */
	private Map<Integer, Set<Node>> searchNeighborNodes(Map<Integer, Set<Node>> matchedGraphs, InvestigationGraph knowledgeGraph) {

		return matchedGraphs.entrySet().stream()
						.map(entry -> {
							Set<Node> nodes = entry.getValue();

							ArrayList<Node> neighbornodes = new ArrayList<>();
							for (Node node : nodes) {
								Node knowledgeGraphNode = knowledgeGraph.getNodes().get(node.getId());
								if (knowledgeGraphNode != null) {

									// check relationships to other nodes outgoing
									neighbornodes.addAll(knowledgeGraphNode.getEdges().stream()
													// where corresponding nodes edges a) from inspected node source and query graph does not already contain the target node
													.filter(edge -> edge.getSource().equals(node.getId()) && !nodes.contains(knowledgeGraph.getNodes().get(edge.getTarget())))
													.map(edge -> knowledgeGraph.getNodes().get(edge.getTarget()))
													.collect(Collectors.toSet()));

									// check relationships from other nodes ingoing
									neighbornodes.addAll(knowledgeGraphNode.getEdges().stream()
													// where corresponding nodes edges a) from inspected node source and query graph does not already contain the target node
													.filter(edge -> edge.getTarget().equals(node.getId()) && !nodes.contains(knowledgeGraph.getNodes().get(edge.getSource())))
													.map(edge -> knowledgeGraph.getNodes().get(edge.getSource()))
													.collect(Collectors.toSet()));
								}
							}
							return Map.entry(entry.getKey(), neighbornodes);

						}).collect(Collectors.toMap(Map.Entry::getKey, entry -> Set.copyOf(entry.getValue())));
	}


	/**
	 * Pings algorithm re-work
	 *
	 * @param investigationQueryGraph
	 * @param investigationKnowledgeGraph
	 * @param queryFocusLabel
	 * @return
	 */
	private Map<Integer, Set<Node>> searchSimilarGraphs(
					InvestigationGraph investigationQueryGraph,
					InvestigationGraph investigationKnowledgeGraph,
					String queryFocusLabel) {

		return searchSimilarGraphs(investigationQueryGraph, investigationKnowledgeGraph, queryFocusLabel, null);
	}

	/**
	 * Pings algorithm re-work
	 *
	 * @param investigationQueryGraph
	 * @param investigationKnowledgeGraph
	 * @param queryFocusLabel
	 * @param startingNodes               list of starting nodes -- Algorithms DM
	 * @return
	 */

	private Map<Integer, Set<Node>> searchSimilarGraphs(
					InvestigationGraph investigationQueryGraph,
					InvestigationGraph investigationKnowledgeGraph,
					String queryFocusLabel,
					Set<Node> startingNodes) {

		HashMap<Integer, Set<Node>> subGraphSet = new HashMap<>();

		ArrayList<Node> startingNodesToIterate = new ArrayList<>();

		if (startingNodes == null) {
			startingNodesToIterate.addAll(investigationKnowledgeGraph.nodesByLabel(queryFocusLabel));
		} else {
			startingNodesToIterate.addAll(startingNodes);
		}

		startingNodesToIterate.forEach(startingNode -> {
			ArrayList<Node> resultList = new ArrayList<>();
			subGraphSet.put(startingNode.getId(), Set.copyOf(matchQueryGraphNodes(
							investigationQueryGraph,
							investigationKnowledgeGraph,
							List.of(startingNode),
							resultList)));

		});


		return subGraphSet.entrySet().stream()
						.filter(es ->
										es.getValue().size() > 0)
						.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
	}


	/**
	 * foreach q′ ∈ Q do
	 *
	 * @param queryGraph                   queryGraph to match
	 * @param knowledgeGraphNodesToIterate list of nodes to inspect during this recursion
	 * @return nodes
	 */
	private ArrayList<Node> matchQueryGraphNodes(InvestigationGraph queryGraph,
																							 InvestigationGraph knowledgeGraph,
																							 List<Node> knowledgeGraphNodesToIterate,
																							 ArrayList<Node> result) {

		if (knowledgeGraphNodesToIterate.isEmpty()) {
			// recursion complete
			return result;
		} else {

			ArrayList<Node> iterationResult = new ArrayList<>();

			// foreach q′ ∈ Q do
			queryGraph.getNodes().values().forEach(queryGraphNode -> {
				// for each start node in knowledgegraph do..
				// foreach s′ ∈ DM do
				knowledgeGraphNodesToIterate.forEach(knowledgeGraphNode -> {
					// if matchNode(s′, q′, W, C) then
					if (queryGraphNode.nodeMatch(knowledgeGraphNode, true)) {

						// Remove s′ from DM <-- foreach does this..
						// RQ = {rq | rq ∈ QE & outgoingEdges(q )}

						Set<Edge> qgnEdges = Set.copyOf(queryGraphNode.getEdges());

						// foreach rq ∈ RQ do
						qgnEdges.forEach(qgnEdge -> {
							// RG =
							//{rg | rg ∈ GE & outgoingEdges(s′)}
							Set<Edge> ignEdges = Set.copyOf(knowledgeGraphNode.getEdges());

							// foreach rg ∈ RG do
							ignEdges.forEach(ignEdge -> {
								// mn = matchEdge(rq, rg)
								Node qgSourceNode = queryGraph.getNodes().get(qgnEdge.getSource());
								Node qgTargetNode = queryGraph.getNodes().get(qgnEdge.getTarget());
								Node igSourceNode = knowledgeGraph.getNodes().get(ignEdge.getSource());
								Node igTargetNode = knowledgeGraph.getNodes().get(ignEdge.getTarget());

								// edge match
								if (qgnEdge.getLabel().equalsIgnoreCase(ignEdge.getLabel()) &&
												qgSourceNode.nodeMatch(igSourceNode, true) &&
												qgTargetNode.nodeMatch(igTargetNode, true)) {

									// log.info("edge match: qs: {} {} ks: {}", qgnEdge.getSource(), qgnEdge.getLabel(),ignEdge.getSource());

									if (!iterationResult.contains(igSourceNode) &&
													!knowledgeGraphNodesToIterate.contains(igSourceNode) &&
													!result.contains(igSourceNode)) {
										// add props
										igSourceNode.setProperties(qgSourceNode.withCommonPropertiesWeights(igSourceNode));
										iterationResult.add(igSourceNode);
									}
									if (!iterationResult.contains(igTargetNode)
													&& !knowledgeGraphNodesToIterate.contains(igTargetNode)
													&& !result.contains(igTargetNode)) {
										igTargetNode.setProperties(qgTargetNode.withCommonPropertiesWeights(igTargetNode));
										iterationResult.add(igTargetNode);
									}

								}

							});
						});
					}
				});
			});
			ArrayList<Node> newResult = new ArrayList<>(result);
			newResult.addAll(iterationResult);
			return matchQueryGraphNodes(queryGraph, knowledgeGraph, iterationResult, newResult);
		}
	}


}
