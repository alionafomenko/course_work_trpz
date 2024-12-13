--DROP FUNCTION trpz.gen_search_vector(p_content in VARCHAR, p_doc_title in VARCHAR);

CREATE OR REPLACE FUNCTION trpz.gen_search_vector(p_content IN VARCHAR, p_doc_title IN VARCHAR)
    RETURNS TSVECTOR
    LANGUAGE plpgsql
    IMMUTABLE
AS

$function$

BEGIN

    IF p_content LIKE '<p>%' THEN
        RETURN SETWEIGHT(TO_TSVECTOR(p_doc_title), 'A')
            || SETWEIGHT(TO_TSVECTOR(REPLACE(REPLACE(p_content, '<p>', ' '), '</p>', ' ')), 'B');
    ELSE
        RETURN TO_TSVECTOR('');
    END IF;


END
$function$;



