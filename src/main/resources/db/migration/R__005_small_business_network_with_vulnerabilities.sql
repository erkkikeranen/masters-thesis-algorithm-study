delete from public.edge cascade
where source in (select id from public.node where graph_id in (30))
   or target in (select id from public.node where graph_id in (30));

delete from public.property cascade
where node_id in (select id from public.node where graph_id in (30));

delete from public.node cascade where graph_id in (30);
delete from public.graph cascade where id in (30);

--- small vulnerable business network

INSERT INTO public.graph (id, name, query_graph) VALUES (30, 'small vulnerable business network fixed with locked doors', false);

-- duplicate the content

insert into node
select n.id + 10000 as id,
       n.label,
       30 as graph_id
from node n where graph_id = 24;

insert into property
select p.node_id + 10000 as node_id,
       p.key,
       p.value,
       p.weight
from property p where node_id in (select id from node where graph_id = 24);

insert into edge
select e.source + 10000 as source,
       e.target + 10000 as target,
       e.label
from edge e where target in (select id from node where graph_id = 24)
or source in (select id from node where graph_id = 24);

-- end of duplication
-- clean up physical access

DELETE FROM public.edge cascade
where source in (select node_id from property where node_id in (select id from node where graph_id = 30) and key = 'name' and value = 'physical access');

DELETE FROM public.property cascade
where node_id in (select id from node where graph_id = 30) and key = 'name' and value = 'physical access';

DELETE from public.node
where label = 'vulnerability' and id not in (select source from edge where source in (select id from node where graph_id = 30))
and graph_id = 30;
