DROP FUNCTION IF EXISTS trpz.get_sites_from_node(p_last_sync_doc_date IN VARCHAR);
CREATE OR REPLACE FUNCTION trpz.get_sites_from_node(p_last_sync_doc_date IN VARCHAR)
    RETURNS TABLE
            (
                ID             INTEGER,
                URL            VARCHAR,
                TITLE          VARCHAR,
                INSERT_DATE    TIMESTAMP,
                LAST_SCAN_DATE VARCHAR,
                DOCUMENT_COUNT INTEGER,
                PICTURE_COUNT  INTEGER,
                STATUS         VARCHAR,
                ADMIN_ID       INTEGER


            )
    LANGUAGE plpgsql
AS
$function$
BEGIN
    SET SESSION TIMEZONE TO UTC;

    RETURN QUERY SELECT s.id,
                        s.url,
                        s.title,
                        s.insert_date,
                        s.last_scan_date::DATE::VARCHAR AS last_scan_date,
                        s.document_count,
                        s.picture_count,
                        s.status,
                        s.admin_id
                 FROM trpz.site s
                 WHERE s.insert_date > CAST(p_last_sync_doc_date AS TIMESTAMP)
                   AND s.status = 'approved'
                 ORDER BY s.insert_date
                 LIMIT 50;

END
$function$;


