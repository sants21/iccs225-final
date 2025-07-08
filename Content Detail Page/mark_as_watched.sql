INSERT INTO WatchHistory (history_id, profile_id, content_id, watched_at, timestamp)
VALUES (${history_id}, ${profile_id}, ${content_id}, NOW(), ${progress_seconds})
ON CONFLICT (profile_id, content_id)
    DO UPDATE
    SET watched_at = NOW(),
        timestamp = EXCLUDED.timestamp;

--testing purposes---
--     SELECT * FROM WatchHistory
--     WHERE profile_id = ${profile_id};