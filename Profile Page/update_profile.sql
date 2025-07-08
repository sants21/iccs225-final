UPDATE Profile
SET profile_name  = ${profile_name},
    age_limit = ${age_limit},
    avatar = ${avatar}
WHERE profile_id = ${profile_id};

--testing purposes--
-- SELECT * FROM Profile
-- WHERE profile_id = ${profile_id};