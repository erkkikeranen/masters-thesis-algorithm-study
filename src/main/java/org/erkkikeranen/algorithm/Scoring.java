package org.erkkikeranen.algorithm;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.erkkikeranen.graphql.model.Edge;
import org.erkkikeranen.graphql.model.InvestigationGraph;
import org.erkkikeranen.graphql.model.Node;
import org.erkkikeranen.graphql.model.Property;
import org.springframework.stereotype.Service;

import java.util.Set;

@Slf4j
@Service
public class Scoring {

	/**
	 * gets total weight for querygraph
	 * @param queryGraph
	 * @return
	 */
	@SneakyThrows
	public Double referenceWeight(InvestigationGraph queryGraph) {

		if (!queryGraph.getQueryGraph()) {
			throw new UnsupportedOperationException("cannot calculate reference weight from non-query graph " +  queryGraph.getName());
		}

		Double score = 0.0;

		for (Node node : queryGraph.getNodes().values()) {

			// each node boosts weight
			score = score + 1.0;

			if (node.getProperties() != null) {
				for (Property nodeProperty : node.getProperties()) {
					// each property mentioned boosts weight by value provided in querygraph
					// this is the modular red flag multiple
					score = score + nodeProperty.getWeight(); // get absolute value to negate effects of negative query graph weight
				}
			}
		}

		// each edge boosts weight
		for (Edge edge : queryGraph.allEdges()) {
			score = score + 1.0;
			if (edge.getProperties() != null) {
				for (Property edgeProperty : edge.getProperties()) {
					// each mentioned edge property also boosts score
					// todo: will work when there are edge props future / never..
					score = score + Math.abs(edgeProperty.getWeight()); // get absolute value to negate effects of negative query graph weight
				}
			}
		}

		log.info("query graph weight score {}", score);
		return score;
	}

	/**
	 * calculates match graph weight. assumes that the nodes and edges are correctly matched by the algorithm
	 * @param matchGraphNodes
	 * @param matchGraphEdges
	 * @return
	 */
	@SneakyThrows
	public Double matchGraphWeight(Set<Node> matchGraphNodes, Set<Edge> matchGraphEdges, InvestigationGraph queryGraph) {

		if (!queryGraph.getQueryGraph()) {
			throw new UnsupportedOperationException("cannot check reference weights from non-query graph " +  queryGraph.getName());
		}
		Double score = 0.0;

		// each node boosts weight
		score = score + matchGraphNodes.size() * 1.0;

		for (Node node : matchGraphNodes) {
			if (node.getProperties() != null) {
				for (Property nodeProperty : node.getProperties()) {
					// todo: skip weights not existing in query graph
					// each property mentioned boosts weight by value provided in querygraph
					// this is the modular red flag multiple
					score = score + nodeProperty.getWeight();
				}
			}
		}


		// each edge boosts weight
		// todo props
		score = score + matchGraphEdges.size() * 1.0;

		return score;

	}



}
