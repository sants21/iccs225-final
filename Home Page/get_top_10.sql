SELECT c.content_id, c.content_title, COUNT(*) AS views
FROM WatchHistory w
         JOIN Content c ON w.content_id = c.content_id
GROUP BY c.content_id, c.content_title
ORDER BY views DESC
LIMIT 10;