SELECT
    e.episode_id,
    e.content_id,
    e.title,
    e.season,
    e.episode_number,
    e.duration,
    e.episode_url,
    c.content_title AS show_title,
    c.age_rating
FROM Episode e
         JOIN Content c ON e.content_id = c.content_id
WHERE e.episode_id = ${episode_id};