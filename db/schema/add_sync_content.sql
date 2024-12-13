DROP FUNCTION IF EXISTS trpz.add_sync_content (p_url IN VARCHAR, p_title IN VARCHAR, p_scan_date IN VARCHAR,
                                               p_content IN VARCHAR, p_site_id IN INTEGER, p_insert_date IN VARCHAR,
                                               p_parent_url IN VARCHAR, p_level IN INTEGER, p_node_id IN INTEGER,
                                               l_msg OUT VARCHAR);
CREATE OR REPLACE FUNCTION trpz.add_sync_content(p_url IN VARCHAR, p_title IN VARCHAR, p_scan_date IN VARCHAR,
                                                 p_content IN VARCHAR, p_site_id IN INTEGER, p_insert_date IN VARCHAR,
                                                 p_parent_url IN VARCHAR, p_level IN INTEGER, p_node_id IN INTEGER,
                                                 l_msg OUT VARCHAR)
    RETURNS VARCHAR
    LANGUAGE plpgsql
AS

$function$

BEGIN
    SET SESSION TIMEZONE TO UTC;


    INSERT INTO trpz.document (site_id, url, parent_url, insert_date, scan_date, title, content, level, node_id,
                               http_status, status)
    VALUES (p_site_id, p_url, p_parent_url, p_insert_date::TIMESTAMP, p_scan_date::TIMESTAMP, p_title, p_content,
            p_level,
            p_node_id, '200', 'scanned')
    ON CONFLICT (url)
        DO UPDATE
        SET title     = excluded.title,
            scan_date = excluded.scan_date,
            content   = excluded.content;


    l_msg := NULL;


END
$function$;



