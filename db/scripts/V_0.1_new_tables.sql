alter table trpz.document
    add node_id integer;


create table trpz.site
(
    id             SERIAL not null
        constraint pk_site_id
            primary key,
    url            VARCHAR,
    title          VARCHAR,
    insert_date    TIMESTAMP,
    last_scan_date TIMESTAMP,
    document_count INTEGER,
    picture_count  integer
);

create table trpz.admin
(
    id       SERIAL not null
        constraint admin_pk
            primary key,
    login    VARCHAR,
    password VARCHAR
);
create table trpz.node
(
    id        SERIAL not null
        constraint node_pk
            primary key,
    ip        VARCHAR,
    port      VARCHAR,
    sync_date TIMESTAMP
);







create table trpz.document
(
    id          SERIAL not null
        constraint pk_document_id
            primary key,
    site_id     integer
        constraint fk_document_site_id
            references trpz.site
            on delete restrict,
    url         VARCHAR,
    status      VARCHAR,
    parent_url  VARCHAR,
    html        VARCHAR,
    insert_date TIMESTAMP,
    scan_date   TIMESTAMP,
    http_status VARCHAR,
    level       integer,
    content     VARCHAR(10000)
);

create table trpz.picture
(
    id          SERIAL not null
        constraint pk_picture_id
            primary key,
    site_id     integer
        constraint fk_picture_site_id
            references trpz.site
            on delete restrict,
    url         VARCHAR,
    parent_url  VARCHAR,
    insert_date TIMESTAMP
);

DROP INDEX IF EXISTS trpz.document_idx;

CREATE INDEX document_idx ON trpz.document USING GIN (trpz.gen_search_vector(content, title));


