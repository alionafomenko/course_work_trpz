DROP FUNCTION trpz.get_node_id_by_url(p_url IN VARCHAR, p_node_id OUT INTEGER);
CREATE OR REPLACE FUNCTION trpz.get_node_id_by_url(p_url IN VARCHAR, p_node_id OUT INTEGER)
    RETURNS INTEGER
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_sha1_signature VARCHAR;
    l_last_two_bytes VARCHAR;
    l_decimal_value  INTEGER; -- Десятичное значение из последних двух байт SHA1
    l_node_count     INTEGER; -- Количество нод из другой таблицы
    l_k              NUMERIC;
    l_node_id        INTEGER;
BEGIN
    SET SESSION TIMEZONE TO UTC;


    l_sha1_signature := digest(p_url, 'md5');
    l_last_two_bytes := SUBSTRING(l_sha1_signature FROM LENGTH(l_sha1_signature) - 1 FOR 2);
    l_decimal_value := ('0x' || l_last_two_bytes)::NUMERIC + 1;

    SELECT COUNT(1) INTO l_node_count FROM trpz.node;
    IF l_node_count = 0 THEN
        RAISE EXCEPTION 'No nodes available in trpz.nodes';
    END IF;

    l_k = 256::NUMERIC / l_node_count::NUMERIC;

    p_node_id := CEIL(l_decimal_value / l_k);
    IF p_node_id > l_node_count THEN
        p_node_id := l_node_count;
    END IF;


END
$function$;



