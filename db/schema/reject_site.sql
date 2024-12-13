DROP FUNCTION trpz.reject_site( p_site_id IN INTEGER);
CREATE OR REPLACE FUNCTION trpz.reject_site( p_site_id IN INTEGER)
    RETURNS VOID
    LANGUAGE plpgsql
AS

$function$
DECLARE
BEGIN

   DELETE FROM trpz.site WHERE id = p_site_id;

END
$function$;



