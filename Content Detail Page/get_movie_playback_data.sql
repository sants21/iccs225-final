SELECT
    content_id,
    content_title,
    content_description,
    duration,
    release_date,
    age_rating,
    genres,
    content_type
FROM Content
WHERE content_id = ${content_id} AND content_type = 'Movie';