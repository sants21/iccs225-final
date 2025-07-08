SELECT c.content_id, c.content_title, w.timestamp, c.duration
FROM WatchHistory w
         JOIN Content c ON w.content_id = c.content_id
WHERE w.profile_id = ${profile_id}
  AND w.timestamp < c.duration * 60
ORDER BY w.watched_at DESC;

--timestamp is in seconds, duration is in minutes--