drop view if exists nodes_edges cascade;
drop table if exists edge cascade;
drop table if exists node cascade;
drop table if exists graph cascade;
drop table if exists property cascade;

create table graph
(
    id serial not null
        constraint graph_pk
            primary key,
    name varchar,
    query_graph boolean default false not null
);

alter table graph owner to "user";

create table node
(
    id serial not null
        constraint node_pk
            primary key,
    label varchar,
    graph_id integer not null
        constraint node_graph_id_fk
            references graph
);

alter table node owner to "user";

create table edge
(
    source integer not null
        constraint edge_node_id_fk
            references node,
    target integer not null
        constraint edge_node_id_fk_2
            references node,
    label varchar
);

alter table edge owner to "user";

create table property
(
    node_id integer                    not null
        constraint property_node_id_fk
            references node,
    key     varchar                    not null,
    value   varchar                    not null,
    weight  double precision default 1 not null
);

alter table property owner to "user";

create view nodes_edges(id, source_id, source, relationship, target_id, target, graph_id, graph_name, query_graph) as
SELECT concat(g.id, '-', sn.id, '-', (SELECT COALESCE(es.target, 0) AS "coalesce")) AS id,
       sn.id                                                                        AS source_id,
       sn.label                                                                     AS source,
       es.label                                                                     AS relationship,
       tn.id                                                                        AS target_id,
       tn.label                                                                     AS target,
       sn.graph_id,
       g.name                                                                       AS graph_name,
       g.query_graph
FROM node sn
         LEFT JOIN edge es ON sn.id = es.source
         LEFT JOIN node tn ON tn.id = es.target
         JOIN graph g ON sn.graph_id = g.id
WHERE (sn.id IN (SELECT edge.source
                 FROM edge))
   OR NOT (sn.id IN (SELECT edge.target
                     FROM edge));

alter table nodes_edges owner to "user";

