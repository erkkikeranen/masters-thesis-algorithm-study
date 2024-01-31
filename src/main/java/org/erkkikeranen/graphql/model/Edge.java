package org.erkkikeranen.graphql.model;

import lombok.*;

import java.util.ArrayList;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Edge {
	Integer source;
	Integer target;
	String label;
	ArrayList<Property> properties;

	public Edge(Integer source, Integer target, String label) {
		this.source = source;
		this.target = target;
		this.label = label;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		Edge edge = (Edge) o;
		return source.equals(edge.source) && target.equals(edge.target);
	}

	@Override
	public int hashCode() {
		return Objects.hash(source, target);
	}
}
