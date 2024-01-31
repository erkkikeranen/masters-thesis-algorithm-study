delete from public.edge cascade
where source in (select id from public.node where graph_id in (40))
   or target in (select id from public.node where graph_id in (40));

delete from public.property cascade
where node_id in (select id from public.node where graph_id in (40));

delete from public.node cascade where graph_id in (40);
delete from public.graph cascade where id in (40);

--- small vulnerable business network

INSERT INTO public.graph (id, name, query_graph) VALUES (40, 'enlarged business network with fixes and flaws', false);

-- duplicate the original network without vulnerabilities

insert into node
select n.id + 400000 as id,
       n.label,
       40 as graph_id
from node n where graph_id = 20;

insert into property
select p.node_id + 400000 as node_id,
       p.key,
       p.value,
       p.weight
from property p where node_id in (select id from node where graph_id = 20);

insert into edge
select e.source + 400000 as source,
       e.target + 400000 as target,
       e.label
from edge e where target in (select id from node where graph_id = 20)
or source in (select id from node where graph_id = 20);

-- duplicate the vulnerable network

insert into node
select n.id + 500000 as id,
       n.label,
       40 as graph_id
from node n where graph_id = 24;

insert into property
select p.node_id + 500000 as node_id,
       p.key,
       p.value,
       p.weight
from property p where node_id in (select id from node where graph_id = 24);

insert into edge
select e.source + 500000 as source,
       e.target + 500000 as target,
       e.label
from edge e where target in (select id from node where graph_id = 24)
               or source in (select id from node where graph_id = 24);

--- duplicate the partly fixed network


insert into node
select n.id + 600000 as id,
       n.label,
       40 as graph_id
from node n where graph_id = 31;

insert into property
select p.node_id + 600000 as node_id,
       p.key,
       p.value,
       p.weight
from property p where node_id in (select id from node where graph_id = 31);

insert into edge
select e.source + 600000 as source,
       e.target + 600000 as target,
       e.label
from edge e where target in (select id from node where graph_id = 31)
               or source in (select id from node where graph_id = 31);

-- make single internet


update edge
set target = (select node_id from property where value = 'Internet' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'Internet' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'Internet' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'Internet' and node_id >= 400000);

-- make single departments

-- single sales
update edge
set target = (select node_id from property where value = 'Sales' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'Sales' and node_id >= 400000);

-- make management
update property
    set value = 'Management' WHERE value = 'Accounting' and node_id >= 400000 and node_id < 500000;

-- make hr
update property
set value = 'HR' WHERE value = 'Accounting' and node_id >= 500000 and node_id < 600000;

update edge
set target = (select node_id from property where value = 'IT' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'IT' and node_id >= 400000);

-- single travel site
update edge
set target = (select node_id from property where value = 'Travel' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'Travel' and node_id >= 400000);

-- single headquarters
update edge
set target = (select node_id from property where value = 'Headquarters' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'Headquarters' and node_id >= 400000);

-- single office network
update edge
set target = (select node_id from property where value = 'office_hq' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'office_hq' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'office_hq' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'office_hq' and node_id >= 400000);

-- single server network
update edge
set target = (select node_id from property where value = 'server' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'server' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'server' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'server' and node_id >= 400000);

-- single dmz
update edge
set target = (select node_id from property where value = 'DMZ' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'DMZ' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'DMZ' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'DMZ' and node_id >= 400000);

-- single extranet
update edge
set target = (select node_id from property where value = 'Extranet' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'Extranet' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'Extranet' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'Extranet' and node_id >= 400000);

-- small and large network lab
update edge
set target = (select node_id from property where value = 'Lab' and node_id >= 400000 and node_id < 500000 limit 1)
WHERE target in (select node_id from property where value = 'Lab' and node_id >= 400000 and node_id < 500000);

update edge
set source = (select node_id from property where value = 'Lab' and node_id >= 400000 and node_id < 500000 limit 1)
WHERE source in (select node_id from property where value = 'Lab' and node_id >= 400000 and node_id < 500000);

update edge
set target = (select node_id from property where value = 'Lab' and node_id >= 500000 limit 1)
WHERE target in (select node_id from property where value = 'Lab' and node_id >= 500000);

update edge
set source = (select node_id from property where value = 'Lab' and node_id >= 500000 limit 1)
WHERE source in (select node_id from property where value = 'Lab' and node_id >= 500000);

update property set value = 'Small Lab'
where node_id = (select node_id from property where value = 'Lab' and node_id >= 400000 and node_id < 500000);

update property set value = 'Large Lab'
where node_id in (select node_id from property where value = 'Lab' and node_id >= 500000 and node_id < 700000);

-- make single crm1 and salesdb1

update edge
set target = (select node_id from property where value = 'CRM1' and node_id >= 400000 and node_id < 600000 limit 1)
WHERE target in (select node_id from property where value = 'CRM1' and node_id >= 400000 and node_id < 600000);

update edge
set source = (select node_id from property where value = 'CRM1' and node_id >= 400000 and node_id < 600000 limit 1)
WHERE source in (select node_id from property where value = 'CRM1' and node_id >= 400000 and node_id < 600000);

update edge
set target = (select node_id from property where value = 'SalesDB1' and node_id >= 400000 and node_id < 600000 limit 1)
WHERE target in (select node_id from property where value = 'SalesDB1' and node_id >= 400000 and node_id < 600000);

update edge
set source = (select node_id from property where value = 'SalesDB1' and node_id >= 400000 and node_id < 600000 limit 1)
WHERE source in (select node_id from property where value = 'SalesDB1' and node_id >= 400000 and node_id < 600000);


-- make hr system
update property
set value = 'HR DB' WHERE value = 'SalesDB1' and node_id >= 600000 and node_id < 700000;

delete from edge
where source = (select node_id from property where value = 'CRM1' and node_id >= 600000 and node_id < 700000)
or target = (select node_id from property where value = 'CRM1' and node_id >= 600000 and node_id < 700000);

delete from edge
    where target = (select node_id from property where value = 'HR DB')
and label = 'utilizes';

update property
set value = 'CRM2' WHERE value = 'CRM2' and node_id >= 400000 and node_id < 500000;
update property
set value = 'CRM3' WHERE value = 'CRM2' and node_id >= 500000 and node_id < 600000;
update property
set value = 'CRM4' WHERE value = 'CRM2' and node_id >= 600000 and node_id < 700000;

update property
set value = 'SalesDB2' WHERE value = 'SalesDB2' and node_id >= 400000 and node_id < 500000;
update property
set value = 'SalesDB3' WHERE value = 'SalesDB2' and node_id >= 500000 and node_id < 600000;
update property
set value = 'SalesDB4' WHERE value = 'SalesDB2' and node_id >= 600000 and node_id < 700000;

-- make single authentication

update edge
set target = (select node_id from property where value = 'Authentication' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'Authentication' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'Authentication' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'Authentication' and node_id >= 400000);

-- make remote management

update edge
set target = (select node_id from property where value = 'Remote Management' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'Remote Management' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'Remote Management' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'Remote Management' and node_id >= 400000);

-- make sw update

update edge
set target = (select node_id from property where value = 'SW update' and node_id >= 400000 limit 1)
WHERE target in (select node_id from property where value = 'SW update' and node_id >= 400000);

update edge
set source = (select node_id from property where value = 'SW update' and node_id >= 400000 limit 1)
WHERE source in (select node_id from property where value = 'SW update' and node_id >= 400000);

-- rename satellite networks
update property
set value = 'office_satellite1' WHERE value = 'office_satellite' and node_id >= 400000 and node_id < 500000;
update property
set value = 'office_satellite2' WHERE value = 'office_satellite' and node_id >= 500000 and node_id < 600000;
update property
set value = 'office_satellite3' WHERE value = 'office_satellite' and node_id >= 600000 and node_id < 700000;

-- fix sites
update property
    set value = 'Satellite1' WHERE value = 'Satellite' and node_id >= 400000 and node_id < 500000;

update property
set value = 'Satellite2' WHERE value = 'Satellite' and node_id >= 500000 and node_id < 600000;

update property
set value = 'Satellite3' WHERE value = 'Satellite' and node_id >= 600000 and node_id < 700000;


-- make management reporting
update property
set value = 'Reporting Management' WHERE value = 'Reporting' and node_id >= 400000 and node_id < 500000;

insert into edge (source, target, label) VALUES
                                                ((select node_id from property where value = 'Reporting Management'),
                                                 (select node_id from property where value = 'HR DB'),
                                                     'utilizes');

-- make HR reporting
update property
set value = 'HR System' WHERE value = 'Reporting' and node_id >= 600000 and node_id < 700000;

insert into edge (source, target, label) VALUES ((select node_id from property where value = 'HR System'),
                                                 (select node_id from property where value = 'HR DB'),
                                                 'utilizes');
-- single directory server to authentication app

delete from edge
where source in (select node_id from property where node_id >= 500000 and key = 'name' and value = 'Directory Srv');

-- single administration server to remote management and

delete from edge
where source in (select node_id from property where node_id >= 500000 and key = 'name' and value = 'Administration Srv');


-- single app server to extranet

delete from edge
    where source in (select node_id from property where node_id >= 500000 and value = 'App Srv')
    and target in (select node_id from property where node_id >= 400000 and value = 'Extranet')
   and label = 'runs';

delete from edge
where source in (select node_id from property where node_id >= 400000 and value = 'Extranet')
  and target in (select node_id from property where node_id >= 500000 and value = 'server')
and label = 'connects to';

delete from edge
where source in (select node_id from property where node_id >= 500000 and value = 'server')
  and target in (select node_id from property where node_id >= 400000 and value = 'Extranet')
  and label = 'exposes';

-- single salesdb1 server

delete from edge
where source in (select node_id from property where node_id >= 500000 and value = 'App Srv')
  and target in (select node_id from property where node_id >= 400000 and value = 'SalesDB1')
  and label = 'runs';

delete from edge
where source in (select node_id from property where node_id >= 400000 and value = 'SalesDB1')
  and target in (select node_id from property where node_id >= 500000 and value = 'server')
  and label = 'connects to';

delete from edge
where source in (select node_id from property where node_id >= 500000 and value = 'server')
  and target in (select node_id from property where node_id >= 400000 and value = 'SalesDB1')
  and label = 'exposes';

-- single CRM1 server

delete from edge
where source in (select node_id from property where node_id >= 500000 and value = 'App Srv')
  and target in (select node_id from property where node_id >= 400000 and value = 'CRM1')
  and label = 'runs';

delete from edge
where source in (select node_id from property where node_id >= 400000 and value = 'CRM1')
  and target in (select node_id from property where node_id >= 500000 and value = 'server')
  and label = 'connects to';

delete from edge
where source in (select node_id from property where node_id >= 500000 and value = 'server')
  and target in (select node_id from property where node_id >= 400000 and value = 'CRM1')
  and label = 'exposes';

--- delete orphanized servers check

delete from edge
    where source in (518018,518013,638018, 638013,518014);

-- rename workstations

update property
set value = (select concat('HR ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'HR System')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000
and label = 'uses');

update property set value = 'HR WS1' where value= 'HR WS5';
update property set value = 'HR WS2' where value = 'HR WS6';
update property set value = 'HR WS3' where value = 'HR WS7';

update property
set value = (select concat('AC ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Reporting')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000
      and label = 'uses');

update property set value = 'AC WS1' where value= 'AC WS5';
update property set value = 'AC WS2' where value = 'AC WS6';
update property set value = 'AC WS3' where value = 'AC WS7';

update property
set value = (select concat('MG ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Reporting Management')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000
      and label = 'uses');

update property set value = 'MG WS1' where value = 'MG WS5';
update property set value = 'MG WS2' where value = 'MG WS6';
update property set value = 'MG WS3' where value = 'MG WS7';

update property
set value = (select concat('IT ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Remote Management')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000
      and label = 'uses');

update property set value = 'IT WS1' where value = 'IT WS4' and node_id >= 400000 and node_id < 500000;
update property set value = 'IT WS2' where value = 'IT WS4' and node_id >= 500000 and node_id < 600000;
update property set value = 'IT WS3' where value = 'IT WS4' and node_id >= 600000;

update property
set value = (select concat('SL IT ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Small Lab')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000 and target < 500000
      and label = 'connects to');
update property set value = 'SL IT WS1' where value = 'SL IT WS14' and node_id >= 400000 and node_id < 500000;
update property set value = 'SL IT WS2' where value = 'SL IT WS15' and node_id >= 400000 and node_id < 500000;

update property
set value = (select concat('LL IT ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Large Lab')
      and source in (select node_id from property where value like 'WS%')
      and target >= 500000 and target < 700000
      and label = 'connects to');

update property set value = 'LL IT WS1' where value = 'LL IT WS14' and node_id >= 500000 and node_id < 600000;
update property set value = 'LL IT WS2' where value = 'LL IT WS15' and node_id >= 500000 and node_id < 600000;
update property set value = 'LL IT WS3' where value = 'LL IT WS14' and node_id >= 600000 and node_id < 700000;
update property set value = 'LL IT WS4' where value = 'LL IT WS15' and node_id >= 600000 and node_id < 700000;

update property
set value = (select concat('S ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Headquarters')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000 and target < 700000
      and label = 'belongs to');

update property set value = 'S WS4' where value = 'S WS1' and node_id >= 500000 and node_id < 600000;
update property set value = 'S WS5' where value = 'S WS2' and node_id >= 500000 and node_id < 600000;
update property set value = 'S WS6' where value = 'S WS3' and node_id >= 500000 and node_id < 600000;

update property set value = 'S WS7' where value = 'S WS1' and node_id >= 600000 and node_id < 700000;
update property set value = 'S WS8' where value = 'S WS2' and node_id >= 600000 and node_id < 700000;
update property set value = 'S WS9' where value = 'S WS3' and node_id >= 600000 and node_id < 700000;

update property
set value = (select concat('S1 ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Satellite1')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000 and target < 700000
      and label = 'belongs to');

update property set value = 'S1 WS1' where value = 'S1 WS8' and node_id >= 400000 and node_id < 500000;
update property set value = 'S1 WS2' where value = 'S1 WS9' and node_id >= 400000 and node_id < 500000;
update property set value = 'S1 WS3' where value = 'S1 WS10' and node_id >= 400000 and node_id < 500000;

update property
set value = (select concat('S2 ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Satellite2')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000 and target < 700000
      and label = 'belongs to');

update property set value = 'S2 WS1' where value = 'S2 WS8' and node_id >= 500000 and node_id < 600000;
update property set value = 'S2 WS2' where value = 'S2 WS9' and node_id >= 500000 and node_id < 600000;
update property set value = 'S2 WS3' where value = 'S2 WS10' and node_id >= 500000 and node_id < 600000;

update property
set value = (select concat('S3 ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Satellite3')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000 and target < 700000
      and label = 'belongs to');

update property set value = 'S3 WS1' where value = 'S3 WS8' and node_id >= 600000 and node_id < 700000;
update property set value = 'S3 WS2' where value = 'S3 WS9' and node_id >= 600000 and node_id < 700000;
update property set value = 'S3 WS3' where value = 'S3 WS10' and node_id >= 600000 and node_id < 700000;

update property
set value = (select concat('T ', value))
where node_id in (
    select source
    from edge
    where target in (select node_id from property where value = 'Travel')
      and source in (select node_id from property where value like 'WS%')
      and target >= 400000 and target < 700000
      and label = 'belongs to');

update property set value = 'T WS1' where value = 'T WS11' and node_id >= 400000 and node_id < 500000;
update property set value = 'T WS2' where value = 'T WS12' and node_id >= 400000 and node_id < 500000;
update property set value = 'T WS3' where value = 'T WS13' and node_id >= 400000 and node_id < 500000;

update property set value = 'T WS4' where value = 'T WS11' and node_id >= 500000 and node_id < 600000;
update property set value = 'T WS5' where value = 'T WS12' and node_id >= 500000 and node_id < 600000;
update property set value = 'T WS6' where value = 'T WS13' and node_id >= 500000 and node_id < 600000;

update property set value = 'T WS7' where value = 'T WS11' and node_id >= 600000 and node_id < 700000;
update property set value = 'T WS8' where value = 'T WS12' and node_id >= 600000 and node_id < 700000;
update property set value = 'T WS9' where value = 'T WS13' and node_id >= 600000 and node_id < 700000;


-- rename departments

update property set value = 'HR_temp' where value = 'Accounting' and node_id > 400000;
update property set value = 'Accounting' where value = 'HR' and node_id > 400000;
update property set value = 'HR' where value = 'HR_temp'  and node_id > 400000;

----------------------------
-- delete orphan properties

delete from edge where source = '639016';

delete from property
where node_id >= 400000 and
      (node_id not in (select source from edge) and node_id not in (select target from edge));

-- delete orphan nodes
delete from node
where graph_id = 40
and id not in (select source from edge)
  and id not in (select target from edge);



-- create network egress between labs

insert into edge (source, target, label) values
((select node_id from property where value = 'Large Lab' and node_id >= 400000),
 (select node_id from property where value = 'Small Lab' and node_id >= 400000),
 'egress to'),
((select node_id from property where value = 'Small Lab' and node_id >= 400000),
 (select node_id from property where value = 'Large Lab' and node_id >= 400000),
 'egress to'),
((select node_id from property where value = 'Large Lab' and node_id >= 400000),
 (select node_id from property where value = 'office_hq' and node_id >= 400000),
 'egress to');

