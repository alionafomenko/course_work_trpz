DROP FUNCTION IF EXISTS trpz.get_document_from_node(p_last_sync_doc_date in VARCHAR);
CREATE OR REPLACE FUNCTION trpz.get_document_from_node(p_last_sync_doc_date in VARCHAR)
    RETURNS TABLE
            (
                ID          INTEGER,
                URL         VARCHAR,
                SITE_ID     INTEGER,
                STATUS      VARCHAR,
                PARENT_URL  VARCHAR,
                TITLE       VARCHAR,
                INSERT_DATE TIMESTAMP,
                SCAN_DATE   TIMESTAMP,
                HTTP_STATUS VARCHAR,
                LEVEL       INTEGER,
                CONTENT     VARCHAR(10000),
                NODE_ID     INTEGER
            )
    LANGUAGE plpgsql
AS
$function$
BEGIN
    SET SESSION TIMEZONE TO UTC;

    RETURN QUERY SELECT d.id,
                        d.url,
                        d.site_id,
                        d.status,
                        d.parent_url,
                        d.title,
                        d.insert_date,
                        d.scan_date,
                        d.http_status,
                        d.level,
                        d.content,
                        d.node_id
                 FROM trpz.document d
                 WHERE d.insert_date > CAST(p_last_sync_doc_date AS TIMESTAMP)
                 ORDER BY d.insert_date
                 LIMIT 50;

END
$function$;


