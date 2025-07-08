INSERT INTO Watchlist (profile_id, content_id)
VALUES (${profile_id}, ${content_id})
ON CONFLICT DO NOTHING;

--testing purposes--
-- SELECT * FROM Watchlist
-- WHERE profile_id = ${profile_id}