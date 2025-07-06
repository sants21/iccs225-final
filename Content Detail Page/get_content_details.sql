SELECT
  c.content_id,
  c.title,
  c.description,
  c.type,
  c.release_year,
  c.language,
  c.duration,
  c.age_rating,
  GROUP_CONCAT(g.name SEPARATOR ', ') AS genres
FROM Content c
LEFT JOIN ContentGenre cg ON c.content_id = cg.content_id
LEFT JOIN Genre g ON cg.genre_id = g.genre_id
WHERE c.content_id = :content_id
GROUP BY c.content_id;