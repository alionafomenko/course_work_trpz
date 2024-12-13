DROP FUNCTION IF EXISTS trpz.add_sync_pics (p_site_id IN INTEGER, p_url IN VARCHAR, p_parent_url IN VARCHAR,
                                            p_insert_date IN VARCHAR,
                                            l_msg OUT VARCHAR);
CREATE OR REPLACE FUNCTION trpz.add_sync_pics(p_site_id IN INTEGER, p_url IN VARCHAR, p_parent_url IN VARCHAR,
                                              p_insert_date IN VARCHAR,
                                              l_msg OUT VARCHAR)
    RETURNS VARCHAR
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_pic_count INTEGER;
BEGIN
    SET SESSION TIMEZONE TO UTC;

    SELECT COUNT(1) INTO l_pic_count FROM trpz.picture d WHERE d.url = p_url;

    IF l_pic_count = 0 THEN
        INSERT INTO trpz.picture (url, site_id, parent_url, insert_date)
        VALUES (p_url, p_site_id, p_parent_url, p_insert_date::TIMESTAMP);

        UPDATE trpz.site
        SET picture_count = site.picture_count + 1,
            last_scan_date = CURRENT_TIMESTAMP
        WHERE id = p_site_id;
        l_msg := NULL;
    ELSE
        l_msg := 'such_doc_exists';
    END IF;


END
$function$;



