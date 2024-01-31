package org.erkkikeranen.db.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Immutable;

import java.util.List;

@Entity
@Table(name = "nodes_edges")
@Immutable
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class NodeEdge {

	@Id
	String id;

	@Column(name = "source_id")
	Integer sourceId;

	String source;

	String relationship;

	@Column(name = "target_id")
	Integer targetId;

	String target;

	@Column(name = "graph_id")
	Integer graphId;

	@Column(name = "graph_name")
	String graphName;

	@Column(name = "query_graph")
	Boolean queryGraph;

	@ElementCollection(fetch = FetchType.EAGER)
	@CollectionTable(name = "property", joinColumns =  @JoinColumn(name = "node_id", referencedColumnName = "source_id"))
	List<NodeProperty> sourceProperties;

	@ElementCollection(fetch = FetchType.EAGER)
	@CollectionTable(name = "property", joinColumns =  @JoinColumn(name = "node_id", referencedColumnName = "target_id"))
	List<NodeProperty> targetProperties;
}
