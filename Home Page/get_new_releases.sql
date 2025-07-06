SELECT content_id, title, release_year
FROM Content
ORDER BY release_year DESC, content_id DESC
LIMIT 10;