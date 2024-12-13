DROP FUNCTION trpz.get_all_documents();
CREATE OR REPLACE FUNCTION trpz.get_all_documents()
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
                 WHERE d.status = 'to_do'
                   AND (d.content IS NULL OR d.content = '')
                   AND d.level < 5
                   AND d.node_id = l_node_id
                 ORDER BY d.level
                 LIMIT 50;

END
$function$;


