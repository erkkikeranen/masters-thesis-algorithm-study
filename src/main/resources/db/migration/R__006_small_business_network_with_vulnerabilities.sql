delete from public.edge cascade
where source in (select id from public.node where graph_id in (31))
   or target in (select id from public.node where graph_id in (31));

delete from public.property cascade
where node_id in (select id from public.node where graph_id in (31));

delete from public.node cascade where graph_id in (31);
delete from public.graph cascade where id in (31);

--- small vulnerable business network

INSERT INTO public.graph (id, name, query_graph) VALUES (31, 'small vulnerable business network fixed with locked doors and managed authentication', false);

-- duplicate the content

insert into node
select n.id + 10000 as id,
       n.label,
       31 as graph_id
from node n where graph_id = 30;

insert into property
select p.node_id + 10000 as node_id,
       p.key,
       p.value,
       p.weight
from property p where node_id in (select id from node where graph_id = 30);

insert into edge
select e.source + 10000 as source,
       e.target + 10000 as target,
       e.label
from edge e where target in (select id from node where graph_id = 30)
or source in (select id from node where graph_id = 30);

-- end of duplication
-- clean up unmanaged authentication

DELETE FROM public.edge cascade
where source in (select node_id from property where node_id in (select id from node where graph_id = 31) and key = 'name' and value = 'unmanaged authentication');

DELETE FROM public.property cascade
where node_id in (select id from node where graph_id = 31) and key = 'name' and value = 'unmanaged authentication';

DELETE from public.node
where label = 'vulnerability' and id not in (select source from edge where source in (select id from node where graph_id = 31))
and graph_id = 31;

-- let's keep one physical access flaw

INSERT INTO public.node (id, label, graph_id) VALUES (39011, 'vulnerability', 31);
INSERT INTO public.property (node_id, key, value, weight) VALUES (39011, 'name', 'physical access', 1);
INSERT INTO public.edge (source, target, label) VALUES (39011, 38019, 'compromises');

-- let's keep one unmanaged authentication flaw

INSERT INTO public.node (id, label, graph_id) VALUES (39002, 'vulnerability', 31);
INSERT INTO public.property (node_id, key, value, weight) VALUES (39002, 'name', 'unmanaged authentication', 1);
INSERT INTO public.edge (source, target, label) VALUES (39002, 38022, 'compromises');
