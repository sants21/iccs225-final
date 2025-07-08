INSERT INTO Episode (episode_id, content_id, title, season, episode_number, duration, episode_url)
VALUES (${episode_id}, ${content_id}, ${title}, ${season}, ${episode_number}, ${duration}, ${episode_url});

--testing purposes--
-- SELECT * FROM Episode
-- WHERE episode_id = ${episode_id};