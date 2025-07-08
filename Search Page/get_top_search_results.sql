SELECT
    c.content_id,
    c.content_title,
    c.content_type,
    c.release_date,
    COUNT(w.profile_id) AS view_count
FROM Content c
         LEFT JOIN WatchHistory w ON c.content_id = w.content_id
WHERE c.content_title ILIKE '%' || ${keyword} || '%'
GROUP BY c.content_id, c.content_title, c.content_type, c.release_date
ORDER BY view_count DESC, c.release_date DESC
LIMIT 10;