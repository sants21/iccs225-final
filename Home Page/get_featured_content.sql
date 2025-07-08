SELECT c.content_id, c.title, c.description, c.type, c.release_year, c.language, c.age_rating
FROM Content c
JOIN ContentGenre cg ON c.content_id = cg.content_id
WHERE cg.genre_id IN (
    SELECT cg2.genre_id
    FROM WatchHistory w
    JOIN ContentGenre cg2 ON w.content_id = cg2.content_id
    WHERE w.profile_id = :profile_id
    GROUP BY cg2.genre_id
    ORDER BY COUNT(*) DESC
    LIMIT 2
)
AND c.content_id NOT IN (
    SELECT content_id
    FROM WatchHistory
    WHERE profile_id = :profile_id
)
ORDER BY c.release_year DESC, c.content_id DESC
LIMIT 1;