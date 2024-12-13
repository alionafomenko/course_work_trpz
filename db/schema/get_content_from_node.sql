DROP FUNCTION IF EXISTS trpz.get_content_from_node(p_last_sync_doc_date IN VARCHAR);
CREATE OR REPLACE FUNCTION trpz.get_content_from_node(p_last_sync_doc_date IN VARCHAR)
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
                CONTENT     VARCHAR,
                NODE_ID     INTEGER
            )
    LANGUAGE plpgsql
AS
$function$
DECLARE
    l_node_id INTEGER;
BEGIN
    SET SESSION TIMEZONE TO UTC;

    SELECT n.id INTO l_node_id FROM trpz.node n WHERE is_local = TRUE;

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
                 WHERE d.scan_date > CAST(p_last_sync_doc_date AS TIMESTAMP)
                   AND d.status = 'scanned'
                   AND d.node_id = l_node_id
                 ORDER BY d.scan_date
                 LIMIT 50;

END
$function$;


