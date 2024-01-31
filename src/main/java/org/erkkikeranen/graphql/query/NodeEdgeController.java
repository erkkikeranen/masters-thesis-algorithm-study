package org.erkkikeranen.graphql.query;

import org.erkkikeranen.db.model.NodeEdge;
import org.erkkikeranen.db.repository.NodeEdgeRepository;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class NodeEdgeController {

	NodeEdgeRepository nodeEdgeRepository;

	public NodeEdgeController(NodeEdgeRepository nodeEdgeRepository) {
		this.nodeEdgeRepository = nodeEdgeRepository;
	}
	@QueryMapping
	public List<NodeEdge> nodeEdges() {
		return nodeEdgeRepository.findAll();
	}
}
