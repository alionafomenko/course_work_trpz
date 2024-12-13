DROP FUNCTION trpz.get_all_sites();
CREATE OR REPLACE FUNCTION trpz.get_all_sites()
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
                 WHERE s.status = 'approved'
                 ORDER BY s.title;

END
$function$;



