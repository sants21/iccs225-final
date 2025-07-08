SELECT
    p.profile_id,
    p.profile_name,
    p.age_limit,
    p.avatar,
    s.display_language,
    s.autoplay,
    s.subtitle_language,
    s.notification
FROM Profile p
         LEFT JOIN ProfileSetting s ON p.profile_id = s.profile_id
WHERE p.profile_id = ${profile_id};