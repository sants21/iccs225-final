SELECT c.content_id, c.content_title, c.content_type, c.release_date, c.content_description, c.duration
FROM Watchlist w
         JOIN Content c ON w.content_id = c.content_id
WHERE w.profile_id = ${profile_id};

--testing purposes--

-- SELECT * FROM Watchlist w
--          JOIN Content c ON w.content_id = c.content_id
-- WHERE w.profile_id = ${profile_id};