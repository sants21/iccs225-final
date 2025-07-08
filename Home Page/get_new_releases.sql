SELECT content_id, content_title, release_date
FROM Content
ORDER BY release_date DESC, content_id DESC
LIMIT 10;