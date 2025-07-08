SELECT DISTINCT c.content_id, c.content_title
FROM WatchHistory w
         JOIN ContentGenre cg ON w.content_id = cg.content_id
         JOIN Genre g ON cg.genre_id = g.genre_id
         JOIN Content c ON cg.content_id = c.content_id
WHERE cg.genre_id IN (
    SELECT cg2.genre_id
    FROM WatchHistory w2
             JOIN ContentGenre cg2 ON w2.content_id = cg2.content_id
    WHERE w2.profile_id = ${profile_id}
    GROUP BY cg2.genre_id
    ORDER BY COUNT(*) DESC
    LIMIT 3
)
  AND c.content_id NOT IN (
    SELECT content_id
    FROM WatchHistory
    WHERE profile_id = ${profile_id}
);