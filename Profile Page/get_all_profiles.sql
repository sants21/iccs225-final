SELECT
  p.profile_id,
  p.name,
  p.age_limit,
  p.avatar
FROM Profile p
WHERE p.user_id = :user_id;