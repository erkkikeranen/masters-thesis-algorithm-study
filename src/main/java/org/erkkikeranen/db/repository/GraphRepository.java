package org.erkkikeranen.db.repository;

import org.erkkikeranen.db.model.Graph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface GraphRepository extends JpaRepository<Graph, Integer> {

	@Query("FROM Graph g where g.queryGraph = :isQueryGraph order by g.id")
	List<Graph> findByIsQueryGraph(Boolean isQueryGraph);
}
