package org.erkkikeranen.graphql.query;

import lombok.extern.slf4j.Slf4j;
import org.erkkikeranen.db.model.Graph;
import org.erkkikeranen.db.repository.GraphRepository;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.List;

@Slf4j
@Controller
public class GraphQueryController {



		GraphRepository graphRepository;


		public GraphQueryController(GraphRepository graphRepository) {
			this.graphRepository = graphRepository;
		}

	@QueryMapping
	List<Graph> graphs(@Argument Boolean isQueryGraph) {
			return graphRepository.findByIsQueryGraph(isQueryGraph);
	}
}
