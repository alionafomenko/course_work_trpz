DROP FUNCTION trpz.get_all_nodes();
CREATE OR REPLACE FUNCTION trpz.get_all_nodes()
    RETURNS TABLE
            (
                ID                INTEGER,
                IP                VARCHAR,
                PORT              VARCHAR,
                STATUS            VARCHAR,
                SYNC_DOC_DATE     VARCHAR,
                SYNC_PIC_DATE     VARCHAR,
                SYNC_CONTENT_DATE VARCHAR,
                SYNC_SITE_DATE    VARCHAR
            )
    LANGUAGE plpgsql
AS
$function$
BEGIN
    SET SESSION TIMEZONE TO UTC;

    RETURN QUERY SELECT s.id,
                        s.ip,
                        s.port,
                        s.status,
                        TO_CHAR(s.sync_doc_date, 'yyyy-mm-dd hh24:mi:ss')::VARCHAR     AS sync_doc_date,
                        TO_CHAR(s.sync_pic_date, 'yyyy-mm-dd hh24:mi:ss')::VARCHAR     AS sync_pic_date,
                        TO_CHAR(s.sync_content_date, 'yyyy-mm-dd hh24:mi:ss')::VARCHAR AS sync_content_date,
                        TO_CHAR(s.sync_site_date, 'yyyy-mm-dd hh24:mi:ss')::VARCHAR    AS sync_site_date
                 FROM trpz.node s
                 WHERE is_local = FALSE;

END
$function$;



