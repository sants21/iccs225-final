SELECT
  e.episode_id,
  e.content_id,
  e.title,
  e.season,
  e.episode_number,
  e.duration,
  e.content_url,
  c.title AS show_title,
  c.age_rating,
  c.language
FROM Episode e
JOIN Content c ON e.content_id = c.content_id
WHERE e.episode_id = :episode_id;