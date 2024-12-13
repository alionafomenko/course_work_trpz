DROP FUNCTION trpz.add_document(p_site_id IN INTEGER, p_url IN VARCHAR, p_parent_url IN VARCHAR, p_status IN VARCHAR,
                                p_level IN INTEGER, l_msg OUT VARCHAR);
CREATE OR REPLACE FUNCTION trpz.add_document(p_site_id IN INTEGER, p_url IN VARCHAR, p_parent_url IN VARCHAR,
                                             p_status IN VARCHAR,
                                             p_level IN INTEGER, l_msg OUT VARCHAR)
    RETURNS VARCHAR
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_site_domen     VARCHAR;
    l_doc_count      INTEGER;
    l_full_url       VARCHAR;
    l_sha1_signature VARCHAR;
    l_last_two_bytes VARCHAR;
    l_decimal_value  INTEGER; -- Десятичное значение из последних двух байт SHA1
    l_node_count     INTEGER; -- Количество нод из другой таблицы
    l_k              NUMERIC;
    l_node_id        INTEGER;
BEGIN
    SET SESSION TIMEZONE TO UTC;
    SELECT s.url INTO l_site_domen FROM trpz.site s WHERE s.id = p_site_id;

    IF p_status = 'to_do' THEN
        l_full_url := l_site_domen || p_url;
    ELSIF p_status = 'external_link' THEN
        l_full_url := p_url;
    END IF;

    SELECT COUNT(1) INTO l_doc_count FROM trpz.document d WHERE d.url = l_full_url;

    IF l_doc_count = 0 and l_full_url IS NOT NULL THEN

        l_node_id := trpz.get_node_id_by_url(l_full_url);

        INSERT INTO trpz.document (url, site_id, parent_url, status, level, insert_date, node_id)
        VALUES (l_full_url, p_site_id, p_parent_url, p_status, p_level, CURRENT_TIMESTAMP, l_node_id);

        UPDATE trpz.site
        SET document_count = document_count + 1,
            last_scan_date = CURRENT_TIMESTAMP
        WHERE id = p_site_id;
        l_msg := NULL;
    ELSE
        l_msg := 'such_doc_exists';
    END IF;


END
$function$;



