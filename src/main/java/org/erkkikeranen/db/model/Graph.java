package org.erkkikeranen.db.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "graph")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Graph {

	@Id
	Integer id;

	String name;

	@Column(name = "query_graph")
	Boolean queryGraph;

}
