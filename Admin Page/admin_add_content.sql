INSERT INTO content (content_id, content_title, content_description, content_type, duration, genres, release_date, age_rating)
VALUES (${content_id}, ${content_title},${content_description}, ${content_type}, ${duration}, ${genres}, ${release_date}, ${age_rating});

--testing purposes--
-- SELECT * FROM content
-- WHERE content_id = ${content_id};