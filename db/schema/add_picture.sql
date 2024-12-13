DROP FUNCTION trpz.add_picture(p_site_id IN INTEGER, p_link IN VARCHAR, p_parent_url IN VARCHAR);

CREATE OR REPLACE FUNCTION trpz.add_picture(p_site_id IN INTEGER, p_link IN VARCHAR, p_parent_url IN VARCHAR)
    RETURNS VOID
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_pic_count INTEGER;
    l_full_url  VARCHAR;
    l_domen_url VARCHAR;
BEGIN
    SET SESSION TIMEZONE TO UTC;
    SELECT s.url INTO l_domen_url FROM trpz.site s WHERE s.id = p_site_id;

    IF p_link LIKE 'http%' THEN
        l_full_url := p_link;
    ELSIF p_link LIKE '/%' THEN
        l_full_url := l_domen_url || p_link;
    ELSE
        l_full_url := l_domen_url || '/' || p_link;
    END IF;


    SELECT COUNT(1) INTO l_pic_count FROM trpz.picture p WHERE p.url = l_full_url;

    IF l_pic_count = 0 THEN
        INSERT INTO trpz.picture (site_id, url, parent_url, insert_date)
        VALUES (p_site_id, l_full_url, p_parent_url, CURRENT_TIMESTAMP);

        UPDATE trpz.site
        SET picture_count  = picture_count + 1,
            last_scan_date = CURRENT_TIMESTAMP
        WHERE id = p_site_id;
    END IF;


END
$function$;



