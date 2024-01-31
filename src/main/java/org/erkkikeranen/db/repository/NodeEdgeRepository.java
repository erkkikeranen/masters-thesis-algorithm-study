package org.erkkikeranen.db.repository;

import org.erkkikeranen.db.model.NodeEdge;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface NodeEdgeRepository extends JpaRepository<NodeEdge, String> {

	List<NodeEdge> findByGraphId(Integer id);

	@Query("select ne FROM NodeEdge ne where ne.graphId = :id and (ne.source = :label or ne.target = :label)")
	List<NodeEdge> findByGraphIdAndLabel(Integer id, String label);

}
