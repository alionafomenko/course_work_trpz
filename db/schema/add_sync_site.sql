DROP FUNCTION IF EXISTS trpz.add_sync_site (p_site_id IN INTEGER, p_url IN VARCHAR, p_title IN VARCHAR,
                                                p_insert_date IN TIMESTAMP,
                                                p_count_doc IN INTEGER, p_count_pic IN INTEGER,
                                                l_msg OUT VARCHAR);
CREATE OR REPLACE FUNCTION trpz.add_sync_site(p_site_id IN INTEGER, p_url IN VARCHAR, p_title IN VARCHAR,
                                                  p_insert_date IN VARCHAR,
                                                  p_count_doc IN INTEGER, p_count_pic IN INTEGER,
                                                  l_msg OUT VARCHAR)
    RETURNS VARCHAR
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_site_count INTEGER;
BEGIN
    SET SESSION TIMEZONE TO UTC;

    SELECT COUNT(1) INTO l_site_count FROM trpz.site s WHERE s.url = p_url;

    IF l_site_count = 0 THEN
        INSERT INTO trpz.site (id, url, title, insert_date , document_count,  picture_count)
        VALUES (p_site_id, p_url, p_title, p_insert_date::TIMESTAMP, p_count_doc, p_count_pic);

        l_msg := NULL;
    ELSE
        l_msg := 'such_doc_exists';
    END IF;


END
$function$;



