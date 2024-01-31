package org.erkkikeranen.graphql.model;

import lombok.*;
import org.erkkikeranen.db.model.NodeProperty;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Node {
	Integer id;
	String label;
	Set<Edge> edges;
	ArrayList<Property> properties;

	public Node(Integer id, String label) {
		this(id, label, new ArrayList<>());
	}

	public Node(Integer id, String label, List<NodeProperty> properties) {
		this.id = id;
		this.label = label;
		this.edges = Set.of();
		this.properties = properties.stream()
						.map(p -> new Property(p.getKey(), p.getValue(), p.getWeight()))
						.collect(Collectors.toCollection(ArrayList::new));
	}

	/**
	 * matches label and common properties
	 *
	 * @param other
	 * @return
	 */
	public boolean nodeMatch(Node other, boolean targetMustHaveProps) {

		// check label match
		if (!this.getLabel().equalsIgnoreCase(other.getLabel())) {
			return false;
		}

		if (targetMustHaveProps) {
			Map<String, String> sourceProps = this.getProperties().stream()
							.collect(Collectors.toMap(Property::getKey, Property::getValue));

			Map<String, String> targetProps = other.getProperties().stream()
							.collect(Collectors.toMap(Property::getKey, Property::getValue));

			if (sourceProps.size() > targetProps.size()) {
				// there are not enough props in target
				return false;
			}


			for (String key : sourceProps.keySet()) {
				// case null, no common key
				// case: no props to compare
				Boolean matchingProps = targetProps.get(key) != null &&
								sourceProps.get(key).equalsIgnoreCase(targetProps.get(key));
				if (!matchingProps) {
					return false;
				}
			}
		}

		return true;

	}

	/**
	 * Return common properties weight of two nodes with target node values and weight in return value
	 * Assumes match was made by algorithm and knowledge graph has weights of 1
	 * Used for calculating matchgraph results
	 *
	 * @param other
	 * @return
	 */

	public ArrayList<Property> withCommonPropertiesWeights(Node other) {
		Map<String, Property> sourceProps = this.getProperties().stream()
						.collect(Collectors.toMap(Property::getKey, Function.identity()));

		Map<String, Property> targetProps = other.getProperties().stream()
						.collect(Collectors.toMap(Property::getKey, Function.identity()));

		return targetProps.keySet().stream().map(k -> {
			if (sourceProps.containsKey(k)) {
				Property targetProperty = targetProps.get(k);
				targetProperty.setWeight(sourceProps.get(k).getWeight());
				return targetProperty;
			} else {
				return targetProps.get(k);
			}
		}).filter(Objects::nonNull).distinct().collect(Collectors.toCollection(ArrayList::new));
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		Node node = (Node) o;
		return id.equals(node.id);
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
}
