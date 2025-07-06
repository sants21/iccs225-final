SELECT c.content_id, c.title, w.progress_seconds, c.duration
FROM WatchHistory w
JOIN Content c ON w.content_id = c.content_id
WHERE w.profile_id = :profile_id
AND w.progress_seconds < c.duration
ORDER BY w.watched_at DESC;