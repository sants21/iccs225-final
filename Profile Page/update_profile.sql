UPDATE Profile
SET name = :name,
    age_limit = :age_limit,
    avatar = :avatar
WHERE profile_id = :profile_id;