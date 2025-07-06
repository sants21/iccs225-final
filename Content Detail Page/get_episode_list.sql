SELECT episode_id, title, season, episode_number, duration, content_url
FROM Episode
WHERE content_id = :content_id
ORDER BY season, episode_number;