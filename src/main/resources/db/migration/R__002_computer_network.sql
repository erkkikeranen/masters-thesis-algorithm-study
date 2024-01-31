delete from public.edge cascade
where source in (select id from public.node where graph_id in (1,2,7,8,9))
   or target in (select id from public.node where graph_id in (1,2,7,8,9));

delete from public.property cascade
where node_id in (select id from public.node where graph_id in (1,2,7,8,9));

delete from public.node cascade where graph_id in (1,2,7,8,9);

delete from public.graph cascade where id = 1;
delete from public.graph cascade where id = 2;
delete from public.graph cascade where id = 7;
delete from public.graph cascade where id = 8;
delete from public.graph cascade where id = 9;

-- graph to search in
INSERT INTO public.graph (id, name, query_graph) VALUES (1, 'computer network 1', false);

-- query graph
INSERT INTO public.graph (id, name, query_graph) VALUES (2, 'vulnerability 1', true);

-- knowledge graph
INSERT INTO public.node (id, label, graph_id) VALUES (1, 'application', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (2, 'application', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (3, 'vulnerability', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (4, 'vulnerability', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (5, 'network', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (6, 'strange', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (12, 'vulnerability', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (13, 'vulnerability', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (14, 'accesscontrol', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (15, 'application', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (16, 'application', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (17, 'vulnerability', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (18, 'network', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (19, 'application', 1);
INSERT INTO public.node (id, label, graph_id) VALUES (20, 'vulnerability', 1);

INSERT INTO public.edge (source, target, label) VALUES (1, 5, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (2, 5, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (1, 3, 'has');
INSERT INTO public.edge (source, target, label) VALUES (2, 4, 'has');
INSERT INTO public.edge (source, target, label) VALUES (2, 12, 'has');
INSERT INTO public.edge (source, target, label) VALUES (2, 13, 'has');
INSERT INTO public.edge (source, target, label) VALUES (2, 14, 'performs');
INSERT INTO public.edge (source, target, label) VALUES (2, 13, 'has');
INSERT INTO public.edge (source, target, label) VALUES (16, 5, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (16, 17, 'has');
INSERT INTO public.edge (source, target, label) VALUES (19, 18, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (19, 20, 'has');

-- query graph
INSERT INTO public.node (id, label, graph_id) VALUES (7, 'application', 2);
INSERT INTO public.node (id, label, graph_id) VALUES (8, 'application', 2);
INSERT INTO public.node (id, label, graph_id) VALUES (9, 'vulnerability', 2);
INSERT INTO public.node (id, label, graph_id) VALUES (10, 'vulnerability', 2);
INSERT INTO public.node (id, label, graph_id) VALUES (11, 'network', 2);

INSERT INTO public.edge (source, target, label) VALUES (7, 11, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (8, 11, 'connects to');
INSERT INTO public.edge (source, target, label) VALUES (7, 9, 'has');
INSERT INTO public.edge (source, target, label) VALUES (8, 10, 'has');

--- poc computer network
-- '(\s+)(.*)(\s+')
-- '\s+(.*)

INSERT INTO graph (id, name, query_graph) VALUES (	7	,'office net 1', false);

INSERT INTO node(id, label, graph_id) VALUES(	10000	,'network',	6	);	INSERT INTO property(node_id, key, value) VALUES(	10000	,'name','server network');
INSERT INTO node(id, label, graph_id) VALUES(	10001	,'network',7	);	INSERT INTO property(node_id, key, value) VALUES(	10001	,'name','office network');
INSERT INTO node(id, label, graph_id) VALUES(	10002	,'network',7	);	INSERT INTO property(node_id, key, value) VALUES(	10002	,'name','access network');
INSERT INTO node(id, label, graph_id) VALUES(	10003	,'network',7	);	INSERT INTO property(node_id, key, value) VALUES(	10003	,'name','internet');
INSERT INTO node(id, label, graph_id) VALUES(	10004	,'server',7	);	INSERT INTO property(node_id, key, value) VALUES(	10004	,'name','s1');
INSERT INTO node(id, label, graph_id) VALUES(	10005	,'server',7	);	INSERT INTO property(node_id, key, value) VALUES(	10005	,'name','s2');
INSERT INTO node(id, label, graph_id) VALUES(	10006	,'server',7	);	INSERT INTO property(node_id, key, value) VALUES(	10006	,'name','s3');
INSERT INTO node(id, label, graph_id) VALUES(	10007	,'server',7	);	INSERT INTO property(node_id, key, value) VALUES(	10007	,'name','s4');
INSERT INTO node(id, label, graph_id) VALUES(	10008	,'server',7	);	INSERT INTO property(node_id, key, value) VALUES(	10008	,'name','s5');
INSERT INTO node(id, label, graph_id) VALUES(	10009	,'server',7	);	INSERT INTO property(node_id, key, value) VALUES(	10009	,'name','s6');
INSERT INTO node(id, label, graph_id) VALUES(	10010	,'workstation',7	);	INSERT INTO property(node_id, key, value) VALUES(	10010	,'name','ws1');
INSERT INTO node(id, label, graph_id) VALUES(	10011	,'workstation',7	);	INSERT INTO property(node_id, key, value) VALUES(	10011	,'name','ws2');
INSERT INTO node(id, label, graph_id) VALUES(	10012	,'workstation',7	);	INSERT INTO property(node_id, key, value) VALUES(	10012	,'name','ws3');
INSERT INTO node(id, label, graph_id) VALUES(	10013	,'workstation',7	);	INSERT INTO property(node_id, key, value) VALUES(	10013	,'name','ws4');
INSERT INTO node(id, label, graph_id) VALUES(	10014	,'application',7	);	INSERT INTO property(node_id, key, value) VALUES(	10014	,'name','web');
INSERT INTO node(id, label, graph_id) VALUES(	10015	,'application',7	);	INSERT INTO property(node_id, key, value) VALUES(	10015	,'name','java');
INSERT INTO node(id, label, graph_id) VALUES(	10016	,'application',7	);	INSERT INTO property(node_id, key, value) VALUES(	10016	,'name','sql');
INSERT INTO node(id, label, graph_id) VALUES(	10017	,'application',7	);	INSERT INTO property(node_id, key, value) VALUES(	10017	,'name','mail');
INSERT INTO node(id, label, graph_id) VALUES(	10018	,'application',7	);	INSERT INTO property(node_id, key, value) VALUES(	10018	,'name','web');
INSERT INTO node(id, label, graph_id) VALUES(	10019	,'application',7	);	INSERT INTO property(node_id, key, value) VALUES(	10019	,'name','java');
INSERT INTO node(id, label, graph_id) VALUES(	10020	,'vulnerability',7	);	INSERT INTO property(node_id, key, value) VALUES(	10020	,'name','remote code execution');
INSERT INTO node(id, label, graph_id) VALUES(	10021	,'vulnerability',7	);	INSERT INTO property(node_id, key, value) VALUES(	10021	,'name','plaintext secrets');
INSERT INTO node(id, label, graph_id) VALUES(	10022	,'vulnerability',7	);	INSERT INTO property(node_id, key, value) VALUES(	10022	,'name','denial of service');

INSERT INTO graph (id, name, query_graph) VALUES (	8	,'office net query graph 1', true);
INSERT INTO node(id, label, graph_id) VALUES(	11000	,'workstation',8	);
INSERT INTO node(id, label, graph_id) VALUES(	11001	,'network',8	);
INSERT INTO node(id, label, graph_id) VALUES(	11002	,'server',8	);
INSERT INTO node(id, label, graph_id) VALUES(	11003	,'server',8	);
INSERT INTO node(id, label, graph_id) VALUES(	11004	,'application',8	);
INSERT INTO node(id, label, graph_id) VALUES(	11005	,'application',8	);
INSERT INTO node(id, label, graph_id) VALUES(	11006	,'vulnerability',8	);
INSERT INTO node(id, label, graph_id) VALUES(	11007	,'vulnerability',8	);

INSERT INTO edge (source, target, label) VALUES(	10000	,	10001	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10001	,	10000	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10001	,	10002	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10002	,	10001	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10003	,	10002	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10002	,	10003	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10004	,	10014	,'runs');
INSERT INTO edge (source, target, label) VALUES(	10004	,	10015	,'runs');
INSERT INTO edge (source, target, label) VALUES(	10005	,	10016	,'runs');
INSERT INTO edge (source, target, label) VALUES(	10006	,	10017	,'runs');
INSERT INTO edge (source, target, label) VALUES(	10007	,	10019	,'runs');
INSERT INTO edge (source, target, label) VALUES(	10009	,	10018	,'runs');
INSERT INTO edge (source, target, label) VALUES(	10014	,	10020	,'has');
INSERT INTO edge (source, target, label) VALUES(	10015	,	10021	,'has');
INSERT INTO edge (source, target, label) VALUES(	10016	,	10022	,'has');
INSERT INTO edge (source, target, label) VALUES(	10004	,	10000	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10005	,	10000	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10006	,	10000	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10007	,	10000	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10008	,	10003	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10009	,	10002	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10010	,	10001	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10011	,	10001	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10012	,	10001	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10013	,	10001	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	10010	,	10004	,'can talk to');
INSERT INTO edge (source, target, label) VALUES(	10012	,	10004	,'can talk to');
INSERT INTO edge (source, target, label) VALUES(	10004	,	10005	,'can talk to');
INSERT INTO edge (source, target, label) VALUES(	10007	,	10009	,'can talk to');
INSERT INTO edge (source, target, label) VALUES(	10008	,	10009	,'can talk to');



INSERT INTO edge (source, target, label) VALUES(	11000	,	11001	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	11000	,	11002	,'can talk to');
INSERT INTO edge (source, target, label) VALUES(	11002	,	11003	,'can talk to');
INSERT INTO edge (source, target, label) VALUES(	11002	,	11004	,'runs');
INSERT INTO edge (source, target, label) VALUES(	11003	,	11005	,'runs');
INSERT INTO edge (source, target, label) VALUES(	11004	,	11006	,'has');
INSERT INTO edge (source, target, label) VALUES(	11005	,	11007	,'has');

INSERT INTO graph (id, name, query_graph) VALUES (9	,'neighborhood: servers that can talk to servers with vulnerabilities',	true	);
INSERT INTO node(id, label, graph_id) VALUES(	12001	,'server',	9	);
INSERT INTO node(id, label, graph_id) VALUES(	12002	,'server',	9	);
INSERT INTO node(id, label, graph_id) VALUES(	12003	,'network',	9	);
INSERT INTO node(id, label, graph_id) VALUES(	12004	,'network',	9	);
INSERT INTO node(id, label, graph_id) VALUES(	12005	,'workstation',	9	);
INSERT INTO node(id, label, graph_id) VALUES(	12010	,'network',	9	);
--INSERT INTO node(id, label, graph_id) VALUES(	12011	,'network',	9	);
--INSERT INTO node(id, label, graph_id) VALUES(	12012	,'server',	9	);
INSERT INTO node(id, label, graph_id) VALUES(	12007	,'application',	9	);
INSERT INTO node(id, label, graph_id) VALUES(	12008	,'vulnerability',	9	);

INSERT INTO edge (source, target, label) VALUES(	12001	,	12002	,'can talk to');
-- inter connected networks
INSERT INTO edge (source, target, label) VALUES(	12003	,	12004	,'connects to');
--INSERT INTO edge (source, target, label) VALUES(	12012	,	12011	,'connects to');
-- INSERT INTO edge (source, target, label) VALUES(	12002	,	12003	,'connects to');
-- INSERT INTO edge (source, target, label) VALUES(	12001	,	12004	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	12005	,	12010	,'connects to');
-- INSERT INTO edge (source, target, label) VALUES(	12005	,	12004	,'connects to');
INSERT INTO edge (source, target, label) VALUES(	12002	,	12007	,'runs');
INSERT INTO edge (source, target, label) VALUES(	12007	,	12008	,'has');
