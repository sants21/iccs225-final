SELECT
    c.content_id,
    c.content_title,
    c.content_description,
    c.content_type,
    c.genres as primary_genre,
    c.duration,
    c.release_date,
    c.age_rating,
    STRING_AGG(g.genre_name, ', ') AS genres
FROM Content c
         LEFT JOIN ContentGenre cg ON c.content_id = cg.content_id
         LEFT JOIN Genre g ON cg.genre_id = g.genre_id
WHERE c.content_id = ${content_id}
GROUP BY c.content_id, c.content_title, c.content_description, c.content_type, c.release_date, c.genres, c.duration, c.age_rating;
