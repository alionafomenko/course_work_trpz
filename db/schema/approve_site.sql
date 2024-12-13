DROP FUNCTION trpz.approve_site(p_admin_id IN INTEGER, p_site_id IN INTEGER);
CREATE OR REPLACE FUNCTION trpz.approve_site(p_admin_id IN INTEGER, p_site_id IN INTEGER)
    RETURNS VOID
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_url VARCHAR;
BEGIN
    SET SESSION TIMEZONE TO UTC;
    UPDATE trpz.site
    SET status   = 'approved',
        admin_id = p_admin_id
    WHERE id = p_site_id;

    SELECT s.url INTO l_url FROM trpz.site s WHERE s.id = p_site_id;

    PERFORM trpz.add_document(p_site_id , '', l_url, 'to_do',0);




END
$function$;



