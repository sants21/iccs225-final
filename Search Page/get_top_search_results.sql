SELECT
  c.content_id,
  c.title,
  c.type,
  c.release_year,
  COUNT(w.profile_id) AS view_count
FROM Content c
LEFT JOIN WatchHistory w ON c.content_id = w.content_id
WHERE c.title LIKE CONCAT('%', :keyword, '%')
GROUP BY c.content_id, c.title, c.type, c.release_year
ORDER BY view_count DESC, c.release_year DESC
LIMIT 10;