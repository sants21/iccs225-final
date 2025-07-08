SELECT
  content_id,
  title,
  description,
  duration,
  content_url,
  age_rating,
  language
FROM Content
WHERE content_id = :content_id AND type = 'movie';