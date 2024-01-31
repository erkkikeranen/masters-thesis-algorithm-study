delete from public.edge cascade
where source in (select id from public.node where graph_id in (24, 25, 26, 27, 28, 29,41))
   or target in (select id from public.node where graph_id in (24, 25, 26, 27, 28, 29,41));

delete from public.property cascade
where node_id in (select id from public.node where graph_id in (24, 25, 26, 27, 28, 29,41));

delete from public.node cascade where graph_id in (24, 25, 26, 27, 28, 29,41);
delete from public.graph cascade where id in (24, 25, 26, 27, 28, 29,41);

--- small vulnerable business network

INSERT INTO public.graph (id, name, query_graph) VALUES (24, 'small vulnerable business network', false);

-- duplicate the content

insert into node
select n.id + 10000 as id,
       n.label,
       24 as graph_id
from node n where graph_id = 20;

insert into property
select p.node_id + 10000 as node_id,
       p.key,
       p.value,
       p.weight
from property p where node_id in (select id from node where graph_id = 20);

insert into edge
select e.source + 10000 as source,
       e.target + 10000 as target,
       e.label
from edge e where target in (select id from node where graph_id = 20)
or source in (select id from node where graph_id = 20);

-- end of duplication

-- query graph : vulnerable things
-- finds the vulnerable networks

INSERT INTO public.graph (id, name, query_graph) VALUES (25, 'vulnerable entities using AND in matches', true);


INSERT INTO public.node (id, label, graph_id) VALUES (90000, 'vulnerability', 25);
INSERT INTO public.node (id, label, graph_id) VALUES (90001, 'workstation', 25);
INSERT INTO public.node (id, label, graph_id) VALUES (90002, 'vulnerability', 25);
INSERT INTO public.node (id, label, graph_id) VALUES (90003, 'server', 25);
INSERT INTO public.node (id, label, graph_id) VALUES (90004, 'vulnerability', 25);
INSERT INTO public.node (id, label, graph_id) VALUES (90005, 'network', 25);
INSERT INTO public.node (id, label, graph_id) VALUES (90006, 'vulnerability', 25);
INSERT INTO public.node (id, label, graph_id) VALUES (90007, 'application', 25);


INSERT INTO public.edge (source, target, label) VALUES (90000, 90001, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90002, 90003, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90004, 90005, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90006, 90007, 'compromises');

-- query graph : vulnerable things with site and department use neighborhoodsimilarity or search similargraphs

INSERT INTO public.graph (id, name, query_graph) VALUES (26, 'vulnerable entities incl sites and departments', true);


INSERT INTO public.node (id, label, graph_id) VALUES (90010, 'vulnerability', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90011, 'workstation', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90012, 'vulnerability', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90013, 'server', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90014, 'vulnerability', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90015, 'network', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90016, 'vulnerability', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90017, 'application', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90018, 'site', 26);
INSERT INTO public.node (id, label, graph_id) VALUES (90019, 'department', 26);


INSERT INTO public.edge (source, target, label) VALUES (90010, 90011, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90012, 90013, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90014, 90015, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90016, 90017, 'compromises');

INSERT INTO public.edge (source, target, label) VALUES (90011, 90018, 'belongs to');
INSERT INTO public.edge (source, target, label) VALUES (90011, 90019, 'belongs to');

-- vulnerable chain1

INSERT INTO public.graph (id, name, query_graph) VALUES (27, 'vulnerable chain : compromised ws -> compromised app', true);

INSERT INTO public.node (id, label, graph_id) VALUES (90020, 'vulnerability', 27);
INSERT INTO public.node (id, label, graph_id) VALUES (90021, 'workstation', 27);
INSERT INTO public.node (id, label, graph_id) VALUES (90022, 'vulnerability', 27);
INSERT INTO public.node (id, label, graph_id) VALUES (90023, 'application', 27);

INSERT INTO public.edge (source, target, label) VALUES (90020, 90021, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90021, 90023, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (90022, 90023, 'compromises');

-- vulnerable chain2

INSERT INTO public.graph (id, name, query_graph) VALUES (28, 'vulnerable chain : compromised ws -> compromised (network, app)', true);

INSERT INTO public.node (id, label, graph_id) VALUES (90024, 'vulnerability', 28);
INSERT INTO public.node (id, label, graph_id) VALUES (90025, 'workstation', 28);
INSERT INTO public.node (id, label, graph_id) VALUES (90026, 'vulnerability', 28);
INSERT INTO public.node (id, label, graph_id) VALUES (90027, 'application', 28);
INSERT INTO public.node (id, label, graph_id) VALUES (90028, 'vulnerability', 28);
INSERT INTO public.node (id, label, graph_id) VALUES (90029, 'network', 28);

INSERT INTO public.edge (source, target, label) VALUES (90024, 90025, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90025, 90027, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (90026, 90027, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90025, 90029, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (90028, 90029, 'compromises');

-- vulnerable chain3

INSERT INTO public.graph (id, name, query_graph) VALUES (29, 'vulnerable chain : ws -> uses compromised connected apps exposed by network', true);

INSERT INTO public.node (id, label, graph_id) VALUES (90030, 'workstation', 29);
INSERT INTO public.node (id, label, graph_id) VALUES (90031, 'vulnerability', 29);
INSERT INTO public.node (id, label, graph_id) VALUES (90032, 'application', 29);
INSERT INTO public.node (id, label, graph_id) VALUES (90033, 'vulnerability', 29);
INSERT INTO public.node (id, label, graph_id) VALUES (90034, 'application', 29);
INSERT INTO public.node (id, label, graph_id) VALUES (90035, 'network', 29);

INSERT INTO public.edge (source, target, label) VALUES (90030, 90032, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (90031, 90032, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90033, 90034, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (90032, 90034, 'utilizes');
INSERT INTO public.edge (source, target, label) VALUES (90035, 90032, 'exposes');
INSERT INTO public.edge (source, target, label) VALUES (90030, 90035, 'connects to');

-- vulnerable chain4

INSERT INTO public.graph (id, name, query_graph) VALUES (41, 'vulnerable chain : vuln -> server, compromised ws -> compromised (network, app)', true);

INSERT INTO public.node (id, label, graph_id) VALUES (95024, 'vulnerability', 41);
INSERT INTO public.node (id, label, graph_id) VALUES (95025, 'workstation', 41);
INSERT INTO public.node (id, label, graph_id) VALUES (95026, 'vulnerability', 41);
INSERT INTO public.node (id, label, graph_id) VALUES (95027, 'application', 41);
INSERT INTO public.node (id, label, graph_id) VALUES (95028, 'vulnerability', 41);
INSERT INTO public.node (id, label, graph_id) VALUES (95029, 'network', 41);
INSERT INTO public.node (id, label, graph_id) VALUES (95030, 'vulnerability', 41);
INSERT INTO public.node (id, label, graph_id) VALUES (95031, 'server', 41);


INSERT INTO public.edge (source, target, label) VALUES (95024, 95025, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (95025, 95027, 'uses');
INSERT INTO public.edge (source, target, label) VALUES (95026, 95027, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (95025, 95029, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (95028, 95029, 'compromises');
INSERT INTO public.edge (source, target, label) VALUES (95030, 95031, 'compromises');

-- end of query graphs

-- add vulnerabilities

-- reporting, dbs and crm2 have homegrown authentication
INSERT INTO public.node (id, label, graph_id) VALUES (19001, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19001, 'name', 'unmanaged authentication', 1);
INSERT INTO public.edge (source, target, label) VALUES (19001, 18026, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19002, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19002, 'name', 'unmanaged authentication', 1);
INSERT INTO public.edge (source, target, label) VALUES (19002, 18022, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19003, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19003, 'name', 'unmanaged authentication', 1);
INSERT INTO public.edge (source, target, label) VALUES (19003, 18028, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19004, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19004, 'name', 'unmanaged authentication', 1);
INSERT INTO public.edge (source, target, label) VALUES (19004, 18029, 'compromises');

-- traveling salesman problem

INSERT INTO public.node (id, label, graph_id) VALUES (19005, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19005, 'name', 'unmanaged network', 1);
INSERT INTO public.edge (source, target, label) VALUES (19005, 18037, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19006, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19006, 'name', 'unmanaged network', 1);
INSERT INTO public.edge (source, target, label) VALUES (19006, 18038, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19007, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19007, 'name', 'unmanaged network', 1);
INSERT INTO public.edge (source, target, label) VALUES (19007, 18039, 'compromises');

-- physical access at satellite site

INSERT INTO public.node (id, label, graph_id) VALUES (19008, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19008, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (19008, 18008, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19009, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19009, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (19009, 18009, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19010, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19010, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (19010, 18010, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19011, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19011, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (19011, 18019, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19012, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19012, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (19012, 18020, 'compromises');

-- physical access at lab and server credentials

INSERT INTO public.node (id, label, graph_id) VALUES (19013, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19013, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (19013, 18044, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19014, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19014, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (19014, 18045, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19015, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19015, 'name', 'unmanaged authentication', 1);
INSERT INTO public.edge (source, target, label) VALUES (19015, 18046, 'compromises');

-- network flaws

INSERT INTO public.node (id, label, graph_id) VALUES (19016, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19016, 'name', 'implicit trust', 1);
INSERT INTO public.edge (source, target, label) VALUES (19016, 18042, 'compromises');

INSERT INTO public.node (id, label, graph_id) VALUES (19017, 'vulnerability', 24);
INSERT INTO public.property (node_id, key, value, weight) VALUES (19017, 'name', 'implicit trust', 1);
INSERT INTO public.edge (source, target, label) VALUES (19017, 18036, 'compromises');


