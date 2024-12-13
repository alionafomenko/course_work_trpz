DROP FUNCTION IF EXISTS trpz.get_pics_from_node(p_last_sync_pic_date IN VARCHAR);
CREATE OR REPLACE FUNCTION trpz.get_pics_from_node(p_last_sync_pic_date IN VARCHAR)
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

    RETURN QUERY SELECT p.id,
                        p.site_id,
                        p.url,
                        p.parent_url,
                        p.insert_date::DATE AS insert_date
                 FROM trpz.picture p
                 WHERE p.insert_date > CAST(p_last_sync_pic_date AS TIMESTAMP)
                 ORDER BY p.insert_date
                 LIMIT 50;

END
$function$;


