DROP FUNCTION trpz.get_site_pictures_1_page(p_site_id IN INTEGER, p_page_number IN INTEGER);
CREATE OR REPLACE FUNCTION trpz.get_site_pictures_1_page(p_site_id IN INTEGER, p_page_number IN INTEGER)
    RETURNS TABLE
            (
                ID          INTEGER,
                SITE_ID     INTEGER,
                URL         VARCHAR,
                PARENT_URL  VARCHAR,
                INSERT_DATE DATE
            )
    LANGUAGE plpgsql
AS
$function$
BEGIN
    SET SESSION TIMEZONE TO UTC;

    RETURN QUERY SELECT p.id, p.site_id, p.url, p.parent_url, p.insert_date::DATE AS insert_date
                 FROM trpz.picture p
                 WHERE p.site_id = p_site_id
                 ORDER BY p.insert_date
                 LIMIT 50 OFFSET (p_page_number - 1) * 50;

END
$function$;



