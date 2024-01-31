package org.erkkikeranen.graphql.query;

import org.erkkikeranen.graphql.model.PingStatus;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

@Controller
public class PingController {

	@QueryMapping
	public PingStatus getPing() {
		return new PingStatus();
	}
}