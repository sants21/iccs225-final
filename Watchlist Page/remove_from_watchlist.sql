DELETE FROM Watchlist
WHERE profile_id = ${profile_id} AND content_id = ${content_id};

--testing purposes--

-- SELECT * FROM Watchlist
-- WHERE profile_id = ${profile_id};