DROP FUNCTION IF EXISTS trpz.add_sync_document (p_site_id IN INTEGER, p_url IN VARCHAR, p_parent_url IN VARCHAR,
                                                p_status IN VARCHAR,
                                                p_level IN INTEGER, p_insert_date IN TIMESTAMP, p_node_id IN INTEGER,
                                                   l_msg OUT VARCHAR);
CREATE OR REPLACE FUNCTION trpz.add_sync_document(p_site_id IN INTEGER, p_url IN VARCHAR, p_parent_url IN VARCHAR,
                                                  p_status IN VARCHAR,
                                                  p_level IN INTEGER, p_insert_date IN VARCHAR, p_node_id IN INTEGER,
                                                  l_msg OUT VARCHAR)
    RETURNS VARCHAR
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_doc_count INTEGER;
BEGIN
    SET SESSION TIMEZONE TO UTC;

    SELECT COUNT(1) INTO l_doc_count FROM trpz.document d WHERE d.url = p_url;

    IF l_doc_count = 0 THEN
        INSERT INTO trpz.document (url, site_id, parent_url, status, level, insert_date, node_id)
        VALUES (p_url, p_site_id, p_parent_url, p_status, p_level, CAST(p_insert_date AS TIMESTAMP), p_node_id);

        UPDATE trpz.site
        SET document_count = document_count + 1,
            last_scan_date = CURRENT_TIMESTAMP
        WHERE id = p_site_id;
        l_msg := NULL;
    ELSE
        l_msg := 'such_doc_exists';
    END IF;


END
$function$;



