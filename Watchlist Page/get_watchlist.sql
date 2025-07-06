SELECT c.content_id, c.title, c.type, c.release_year, c.language, c.duration
FROM Watchlist w
JOIN Content c ON w.content_id = c.content_id
WHERE w.profile_id = :profile_id;