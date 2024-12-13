DROP FUNCTION trpz.login_admin(login IN VARCHAR, password IN VARCHAR);
CREATE OR REPLACE FUNCTION trpz.login_admin(p_login IN VARCHAR, p_password IN VARCHAR)
    RETURNS TABLE
            (
                ID       INTEGER,
                LOGIN    VARCHAR,
                PASSWORD VARCHAR
            )
    LANGUAGE plpgsql
AS

$function$
DECLARE
    l_password VARCHAR;
BEGIN

    SELECT a.password INTO l_password FROM trpz.admin a WHERE a.login = p_login;
    IF l_password IS NOT NULL AND l_password = p_password THEN
        RETURN QUERY SELECT a.id,
                            a.login,
                            a.password
                     FROM trpz.admin a
                     WHERE a.login = p_login;
    ELSE
        RETURN QUERY SELECT a.id,
                           NULL::VARCHAR, NULL::VARCHAR FROM trpz.admin a;
    END IF;


END
$function$;



