delete from public.edge cascade
where source in (select id from public.node where graph_id in (20, 21, 22, 23))
   or target in (select id from public.node where graph_id in (20, 21, 22, 23));

delete from public.property cascade
where node_id in (select id from public.node where graph_id in (20, 21, 22,23 ));

delete from public.node cascade where graph_id in (20, 21, 22, 23);
delete from public.graph cascade where id in (20, 21, 22, 23);






--- small business network

INSERT INTO public.graph (id, name, query_graph) VALUES (20, 'small business network', false);

--- small business network query graphs

-- search similar graphs does not show link through extranet, neighborhoodsimilarity will show

-- start qg focus on workstation
INSERT INTO public.graph (id, name, query_graph) VALUES (21, 'workstations that can directly access applications on network', true);

INSERT INTO public.node (id, label, graph_id) VALUES (80000, 'workstation', 21);
INSERT INTO public.node (id, label, graph_id) VALUES (80001, 'network', 21);
INSERT INTO public.node (id, label, graph_id) VALUES (80002, 'application', 21);

INSERT INTO public.edge (source, target, label) VALUES (80000, 80001, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (80001, 80002, 'exposes');
-- eng eq

-- start qg focus on workstation
INSERT INTO public.graph (id, name, query_graph) VALUES (22, 'workstations that can directly access applications using centralized authentication', true);

INSERT INTO public.node (id, label, graph_id) VALUES (80003, 'workstation', 22);
INSERT INTO public.node (id, label, graph_id) VALUES (80005, 'application', 22);
INSERT INTO public.node (id, label, graph_id) VALUES (80006, 'application', 22);
INSERT INTO public.edge (source, target, label) VALUES (80003, 80005, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (80005, 80006, 'utilizes');
INSERT INTO public.property (node_id, key, value, weight) VALUES (80006, 'type', 'auth', 1.0);
-- end qg

-- start qg focuslabel: network. Combine to combine all results
-- remove lab by raising the treshold
INSERT INTO public.graph (id, name, query_graph) VALUES (23, 'Internet connected workstations, servers and networks', true);

INSERT INTO public.node (id, label, graph_id) VALUES (80007, 'server', 23);
INSERT INTO public.node (id, label, graph_id) VALUES (80008, 'workstation', 23);
INSERT INTO public.node (id, label, graph_id) VALUES (80009, 'network', 23);
INSERT INTO public.node (id, label, graph_id) VALUES (80010, 'network', 23);

INSERT INTO public.node (id, label, graph_id) VALUES (80011, 'network', 23);
INSERT INTO public.node (id, label, graph_id) VALUES (80012, 'network', 23);

INSERT INTO public.edge (source, target, label) VALUES (80007, 80009, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (80009, 80010, 'egress to');

INSERT INTO public.edge (source, target, label) VALUES (80008, 80011, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (80011, 80012, 'egress to');


INSERT INTO public.property (node_id, key, value, weight) VALUES (80010, 'name', 'Internet', 1.0);

INSERT INTO public.property (node_id, key, value, weight) VALUES (80012, 'name', 'Internet', 1.0);
--INSERT INTO public.property (node_id, key, value, weight) VALUES (80014, 'name', 'Internet', 1.0);

--INSERT INTO public.property (node_id, key, value, weight) VALUES (80009, 'type', 'app', 1.0);
-- INSERT INTO public.property (node_id, key, value, weight) VALUES (80010, 'type', 'auth', 1.0);
-- end qg

-- workstations, sites
-- belongs to

INSERT INTO public.node (id, label, graph_id) VALUES (8001, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8002, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8003, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8004, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8005, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8006, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8007, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8008, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8009, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8010, 'workstation', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8001, 'name', 'WS1', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8002, 'name', 'WS2', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8003, 'name', 'WS3', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8004, 'name', 'WS4', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8005, 'name', 'WS5', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8006, 'name', 'WS6', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8007, 'name', 'WS7', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8008, 'name', 'WS8', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8009, 'name', 'WS9', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8010, 'name', 'WS10', 1);

INSERT INTO public.node (id, label, graph_id) VALUES (8011, 'site', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8012, 'site', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8011, 'name', 'Headquarters', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8012, 'name', 'Satellite', 1);

INSERT INTO public.node (id, label, graph_id) VALUES (8030, 'department', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8031, 'department', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8032, 'department', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8030, 'name', 'Sales', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8031, 'name', 'Accounting', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8032, 'name', 'IT', 1);

INSERT INTO public.edge (source, target, label) VALUES (8001, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8002, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8003, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8004, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8005, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8006, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8007, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8008, 8012, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8009, 8012, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8010, 8012, 'belongs to');

INSERT INTO public.edge (source, target, label) VALUES (8001, 8030, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8002, 8030, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8003, 8030, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8004, 8032, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8005, 8031, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8006, 8031, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8007, 8031, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8008, 8030, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8009, 8030, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8010, 8030, 'belongs to');


--- servers, applications
-- server - runs - application
-- application - utilizes - application
-- workstation - can access - application

INSERT INTO public.node (id, label, graph_id) VALUES (8013, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8014, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8015, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8016, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8017, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8018, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8019, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8020, 'server', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8013, 'name', 'App Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8014, 'name', 'App Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8015, 'name', 'Directory Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8016, 'name', 'App Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8017, 'name', 'Administration Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8018, 'name', 'App Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8020, 'name', 'App Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8019, 'name', 'App Srv', 1);

INSERT INTO public.node (id, label, graph_id) VALUES (8021, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8022, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8023, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8024, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8025, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8026, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8027, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8028, 'application', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8029, 'application', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8021, 'name', 'CRM1', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8021, 'type', 'app', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8022, 'name', 'SalesDB1', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8022, 'type', 'app', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8023, 'name', 'Authentication', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8023, 'type', 'auth', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8024, 'name', 'SW update', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8024, 'type', 'admin', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8025, 'name', 'Remote Management', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8025, 'type', 'admin', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8026, 'name', 'Reporting', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8026, 'type', 'app', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8027, 'name', 'Extranet', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8027, 'type', 'app', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8028, 'name', 'CRM2', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8028, 'type', 'app', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8029, 'name', 'SalesDB2', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8029, 'type', 'app', 1);

INSERT INTO public.edge (source, target, label) VALUES (8013, 8021, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8014, 8022, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8015, 8023, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8017, 8024, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8017, 8025, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8016, 8026, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8018, 8027, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8019, 8028, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8020, 8029, 'runs');

INSERT INTO public.edge (source, target, label) VALUES (8021, 8022, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (8021, 8023, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (8026, 8022, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (8027, 8021, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (8027, 8023, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (8028, 8029, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (8024, 8023, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (8025, 8023, 'utilizes');

INSERT INTO public.edge (source, target, label) VALUES (8008, 8028, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8009, 8028, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8010, 8028, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8001, 8021, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8002, 8021, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8003, 8021, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8005, 8026, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8006, 8026, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8007, 8026, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8004, 8024, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8004, 8025, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8008, 8027, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8009, 8027, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8010, 8027, 'uses');

-- networking
-- workstation/server connects to network
-- network exposes application

INSERT INTO public.node (id, label, graph_id) VALUES (8033, 'network', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8034, 'network', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8035, 'network', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8036, 'network', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8033, 'name', 'Internet', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8034, 'name', 'office_hq', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8035, 'name', 'server', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8036, 'name', 'office_satellite', 1);

-- connect to office network
INSERT INTO public.edge (source, target, label) VALUES (8001, 8034, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8002, 8034, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8003, 8034, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8004, 8034, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8005, 8034, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8006, 8034, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8007, 8034, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8008, 8036, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8009, 8036, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8010, 8036, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8019, 8036, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8020, 8036, 'connects to');

-- connect to server network
INSERT INTO public.edge (source, target, label) VALUES (8013, 8035, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8014, 8035, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8015, 8035, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8016, 8035, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8017, 8035, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8018, 8035, 'connects to');

INSERT INTO public.edge (source, target, label) VALUES (8034, 8021, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8034, 8025, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8034, 8026, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8036, 8028, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8036, 8029, 'exposes');

INSERT INTO public.edge (source, target, label) VALUES (8035, 8021, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8035, 8022, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8035, 8023, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8035, 8024, 'exposes');

--- remote workers that uses extra net

INSERT INTO public.node (id, label, graph_id) VALUES (8037, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8038, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8039, 'workstation', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8037, 'name', 'WS11', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8038, 'name', 'WS12', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8039, 'name', 'WS13', 1);

-- remote workers connect directly to internet
INSERT INTO public.edge (source, target, label) VALUES (8037, 8033, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8038, 8033, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8039, 8033, 'connects to');

INSERT INTO public.edge (source, target, label) VALUES (8037, 8027, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8038, 8027, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8039, 8027, 'uses');

INSERT INTO public.edge (source, target, label) VALUES (8037, 8030, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8038, 8030, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8039, 8030, 'belongs to');

INSERT INTO public.node (id, label, graph_id) VALUES (8040, 'site', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8040, 'name', 'Travel', 1);

INSERT INTO public.edge (source, target, label) VALUES (8037, 8040, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8038, 8040, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8039, 8040, 'belongs to');

INSERT INTO public.node (id, label, graph_id) VALUES (8041, 'network', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8041, 'name', 'DMZ', 1);

INSERT INTO public.edge (source, target, label) VALUES (8041, 8027, 'exposes');

-- egress from network to network
-- to dmz

INSERT INTO public.edge (source, target, label) VALUES (8034, 8041, 'egress to');
INSERT INTO public.edge (source, target, label) VALUES (8035, 8041, 'egress to');

-- from internet to dmz
INSERT INTO public.edge (source, target, label) VALUES (8033, 8041, 'ingress to');

-- from dmz to internet
INSERT INTO public.edge (source, target, label) VALUES (8041, 8033, 'egress to');

-- from hq office network to server network
INSERT INTO public.edge (source, target, label) VALUES (8034, 8035, 'egress to');

-- from dmz to server network
INSERT INTO public.edge (source, target, label) VALUES (8041, 8035, 'ingress to');

-- from satellite office network to internet
INSERT INTO public.edge (source, target, label) VALUES (8036, 8033, 'egress to');

-- lab room

INSERT INTO public.node (id, label, graph_id) VALUES (8042, 'network', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8043, 'server', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8044, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8045, 'workstation', 20);
INSERT INTO public.node (id, label, graph_id) VALUES (8046, 'application', 20);

INSERT INTO public.property (node_id, key, value, weight) VALUES (8042, 'name', 'Lab', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8043, 'name', 'App Srv', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8046, 'name', 'Lab Server', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8044, 'name', 'WS14', 1);
INSERT INTO public.property (node_id, key, value, weight) VALUES (8045, 'name', 'WS15', 1);

INSERT INTO public.edge (source, target, label) VALUES (8042, 8046, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (8043, 8046, 'runs');
INSERT INTO public.edge (source, target, label) VALUES (8043, 8042, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8044, 8042, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8045, 8042, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8044, 8032, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8045, 8032, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8044, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8045, 8011, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (8044, 8046, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (8045, 8046, 'uses');