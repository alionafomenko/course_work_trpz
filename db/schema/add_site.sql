DROP FUNCTION trpz.add_site(p_url IN VARCHAR, p_title IN VARCHAR, l_msg OUT VARCHAR);
CREATE OR REPLACE FUNCTION trpz.add_site(p_url IN VARCHAR, p_title IN VARCHAR, l_msg OUT VARCHAR)
    RETURNS VARCHAR
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_site_count INTEGER;
    l_url        VARCHAR;
BEGIN
    SET SESSION TIMEZONE TO UTC;
    l_url := TRIM(TRAILING '/' FROM TRIM(BOTH ' ' FROM LOWER(p_url)));

    IF l_url NOT LIKE 'http://%' AND l_url NOT LIKE 'https://%' THEN
        l_url := 'https://' || l_url;
    END IF;


    SELECT COUNT(1) INTO l_site_count FROM trpz.site s WHERE s.url = l_url;


    IF l_site_count = 0 THEN
        INSERT INTO trpz.site (url, title, insert_date, status) VALUES (l_url, p_title, CURRENT_TIMESTAMP, 'not_approved');

    ELSE
        l_msg := 'such_site_exists';
    END IF;


END
$function$;



