package org.erkkikeranen.graphql.query;

import lombok.extern.slf4j.Slf4j;
import org.erkkikeranen.algorithm.Algorithm;
import org.erkkikeranen.algorithm.Scoring;
import org.erkkikeranen.db.model.NodeEdge;
import org.erkkikeranen.db.repository.NodeEdgeRepository;
import org.erkkikeranen.graphql.model.*;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Controller
public class GraphqlQueryController {

	NodeEdgeRepository nodeEdgeRepository;
	Algorithm algorithm;
	Scoring scoring;

	public GraphqlQueryController(NodeEdgeRepository nodeEdgeRepository, Algorithm algorithm, Scoring scoring) {
		this.nodeEdgeRepository = nodeEdgeRepository;
		this.algorithm = algorithm;
		this.scoring = scoring;
	}

	public Set<Edge> graphEdges(Collection<Node> nodes) {
		return nodes.stream()
						.map(Node::getEdges).flatMap(Collection::stream)
						.collect(Collectors.toSet());
	}

	/**
	 * Aka individual similarity
	 * Todo: multiple focus label stuff in query graph?
	 *
	 * @param knowledgeGraph
	 * @param similarityTreshold
	 * @param queryGraph
	 * @param queryFocusLabel
	 * @return
	 */
	@QueryMapping
	public List<MatchGraph> similarityMeasure(@Argument Integer knowledgeGraph,
																							@Argument Double similarityTreshold,
																							@Argument Integer queryGraph,
																							@Argument String queryFocusLabel) {

		log.info("** ENTRY ");
		List<NodeEdge> knowledgeGraphNodes = nodeEdgeRepository.findByGraphId(knowledgeGraph);
		List<NodeEdge> queryGraphNodes = nodeEdgeRepository.findByGraphId(queryGraph);

		InvestigationGraph investigationKnowledgeGraph = new InvestigationGraph(
						knowledgeGraph,
						knowledgeGraphNodes.get(0).getGraphName(),
						false,
						knowledgeGraphNodes);

		InvestigationGraph investigationQueryGraph = new InvestigationGraph(
						queryGraph,
						queryGraphNodes.get(0).getGraphName(),
						true,
						queryGraphNodes);


		Map<Integer, Set<Node>> graphSet = algorithm.similarityMeasure(
						investigationQueryGraph,
						investigationKnowledgeGraph,
						queryFocusLabel);


		/*
		construct response
		 */
		ArrayList<MatchGraph> matchGraphs = new ArrayList<>();

		Double maxWeight = scoring.referenceWeight(investigationQueryGraph);

		// add queryGraph
		matchGraphs.add(
						new MatchGraph(
										investigationQueryGraph.getName(),
										1000.0,
										investigationQueryGraph.getNodes().values(),
										investigationQueryGraph.allEdges()));
		matchGraphs.add(
						new MatchGraph(
										investigationKnowledgeGraph.getName(),
										1000.0,
										investigationKnowledgeGraph.getNodes().values(),
										investigationKnowledgeGraph.allEdges()));

		// invidual similaritys match score is calculated here...
		matchGraphs.addAll(
						graphSet.keySet().stream()
										.map(nsetkey ->
														new MatchGraph(
																		"match# " + nsetkey,
																		scoring.matchGraphWeight(
																						graphSet.get(nsetkey),
																						graphEdges(graphSet.get(nsetkey)),
																						investigationQueryGraph) / maxWeight,
																		List.copyOf(graphSet.get(nsetkey)),
																		graphEdges(graphSet.get(nsetkey))))
						.collect(Collectors.toList()));


		log.info("** EXIT, returning ");
		return matchGraphs.stream().filter(mg -> mg.getSimilarity() >= similarityTreshold).collect(Collectors.toList());

	}

	/**
	 * Find similar neighborhoods
	 * Todo: multiple focus label stuff in query graph?
	 *
	 * @param knowledgeGraph
	 * @param similarityTreshold
	 * @param queryGraph
	 * @param queryFocusLabel
	 * @return
	 */
	@QueryMapping
	public List<MatchGraph> neighborhoodSimilarity(@Argument Integer knowledgeGraph,
																						@Argument Double similarityTreshold,
																						@Argument Integer queryGraph,
																						@Argument String queryFocusLabel) {

		log.info("** ENTRY ");
		List<NodeEdge> knowledgeGraphNodes = nodeEdgeRepository.findByGraphId(knowledgeGraph);
		List<NodeEdge> queryGraphNodes = nodeEdgeRepository.findByGraphId(queryGraph);

		InvestigationGraph investigationKnowledgeGraph = new InvestigationGraph(
						knowledgeGraph,
						knowledgeGraphNodes.get(0).getGraphName(),
						false,
						knowledgeGraphNodes);

		InvestigationGraph investigationQueryGraph = new InvestigationGraph(
						queryGraph,
						queryGraphNodes.get(0).getGraphName(),
						true,
						queryGraphNodes);


		Map<Integer, List<Set<Node>>> graphSet = algorithm.neighborhoodSimilarity(
						investigationQueryGraph,
						investigationKnowledgeGraph,
						queryFocusLabel);


		/*
		construct response
		 */
		ArrayList<MatchGraph> matchGraphs = new ArrayList<>();

		Double maxWeight = scoring.referenceWeight(investigationQueryGraph);

		// add queryGraph
		matchGraphs.add(
						new MatchGraph(
										investigationQueryGraph.getName(),
										1000.0,
										investigationQueryGraph.getNodes().values(),
										investigationQueryGraph.allEdges()));
		matchGraphs.add(
						new MatchGraph(
										investigationKnowledgeGraph.getName(),
										1000.0,
										investigationKnowledgeGraph.getNodes().values(),
										investigationKnowledgeGraph.allEdges()));

		// invidual similaritys match score is calculated here...
		matchGraphs.addAll(
						graphSet.keySet().stream()
										.map(nsetkey ->
														{
															Map<Integer, Set<Node>> combinedNeighborhoods = graphSet.get(nsetkey).stream()
																			.flatMap(Collection::stream)
																			.collect(Collectors.toMap(e -> nsetkey, Set::of, (a, b) -> {
																				ArrayList<Node> temp = new ArrayList<>(a);
																				temp.addAll(b);
																				return Set.copyOf(temp);
																			}));

															return new MatchGraph(
																			"match# " + nsetkey,
																			scoring.matchGraphWeight(
																							combinedNeighborhoods.get(nsetkey),
																							graphEdges(combinedNeighborhoods.get(nsetkey)),
																							investigationQueryGraph) / maxWeight,
																			List.copyOf(combinedNeighborhoods.get(nsetkey)),
																			graphEdges(combinedNeighborhoods.get(nsetkey)));
														}).collect(Collectors.toList()));

		log.info("** EXIT, returning ");
		return matchGraphs.stream().filter(mg -> mg.getSimilarity() >= similarityTreshold).collect(Collectors.toList());

	}
}
