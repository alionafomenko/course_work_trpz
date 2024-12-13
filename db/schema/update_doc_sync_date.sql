DROP FUNCTION trpz.update_doc_sync_date(p_node_id IN INTEGER, p_last_sync_date IN TIMESTAMP);
CREATE OR REPLACE FUNCTION trpz.update_doc_sync_date(p_node_id IN INTEGER, p_last_sync_date IN TIMESTAMP)
    RETURNS VOID
    LANGUAGE plpgsql
AS

$function$
DECLARE
BEGIN
    SET SESSION TIMEZONE TO UTC;

    UPDATE trpz.node
    SET sync_doc_date = p_last_sync_date
    WHERE id = p_node_id;

END
$function$;



