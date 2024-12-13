DROP FUNCTION trpz.save_content(p_doc_id IN INTEGER,  p_title in VARCHAR, p_content IN VARCHAR,
                                             p_status in VARCHAR, p_http_status in VARCHAR);
CREATE OR REPLACE FUNCTION trpz.save_content(p_doc_id IN INTEGER, p_title in VARCHAR, p_content IN VARCHAR,
                                             p_status in VARCHAR, p_http_status in VARCHAR)
    RETURNS VOID
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_level INTEGER;
    l_site_id INTEGER;
BEGIN
    SET SESSION TIMEZONE TO UTC;

    SELECT d.level, d.site_id INTO l_level, l_site_id FROM trpz.document d WHERE d.id = p_doc_id;

    if l_level = 0 then
        UPDATE trpz.site s
        SET title = p_title
        WHERE s.id = l_site_id;
    END IF;

    IF p_status = 'error' and p_http_status = '0' then
            p_status := 'to_do';
    END IF;

    UPDATE trpz.document d
    SET content = p_content,
        status = p_status,
        scan_date = CURRENT_TIMESTAMP,
        http_status = p_http_status,
        title = substr(p_title, 1, 250)
    WHERE id = p_doc_id;


END
$function$;



