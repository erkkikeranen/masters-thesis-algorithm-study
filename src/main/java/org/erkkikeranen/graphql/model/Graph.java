package org.erkkikeranen.graphql.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.erkkikeranen.db.model.NodeEdge;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Graph {

	Double score;

	List<NodeEdge> nodeEdges;

}
