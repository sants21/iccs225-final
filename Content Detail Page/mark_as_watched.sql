INSERT INTO WatchHistory (profile_id, content_id, watched_at, progress_seconds)
VALUES (:profile_id, :content_id, NOW(), :progress_seconds)
ON DUPLICATE KEY UPDATE watched_at = NOW(), progress_seconds = :progress_seconds;