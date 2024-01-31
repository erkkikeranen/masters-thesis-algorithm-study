package org.erkkikeranen.graphql.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Collection;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MatchGraph {

	String name;
	Double similarity;
	Collection<Node> nodes;
	Collection<Edge> edges;
}
