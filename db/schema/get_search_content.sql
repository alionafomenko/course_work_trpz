DROP FUNCTION IF EXISTS trpz.get_search_content(p_search_termin IN VARCHAR);
CREATE OR REPLACE FUNCTION trpz.get_search_content(p_search_termin IN VARCHAR)
    RETURNS TABLE
            (
                SITE_URL   VARCHAR,
                SITE_TITLE VARCHAR,
                DOC_URL    VARCHAR,
                DOC_TITLE  VARCHAR,
                CONTENT    VARCHAR,
                ID         INTEGER
            )
    LANGUAGE plpgsql
AS
$function$
BEGIN

    RETURN QUERY SELECT s.url                                                            AS site_url,
                        s.title                                                          AS site_title,
                        d.url                                                            AS doc_url,
                        d.title                                                          AS doc_title,
                        TS_HEADLINE('english', d.content, websearch_to_tsquery(p_search_termin),
                                    'MaxFragments=3, MaxWords=15, MinWords=10')::VARCHAR AS content,
                        s.id

                 FROM trpz.document d
                          LEFT JOIN trpz.site s ON d.site_id = s.id
                 WHERE d.status = 'scanned'
                   AND d.http_status = '200'
                   AND trpz.gen_search_vector(d.content, d.title) @@ websearch_to_tsquery(p_search_termin)
                 ORDER BY TS_RANK_CD(trpz.gen_search_vector(d.content, d.title),
                                     websearch_to_tsquery(p_search_termin)) DESC
                 LIMIT 10;

END
$function$;
