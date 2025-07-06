SELECT
  p.profile_id,
  p.name,
  p.age_limit,
  p.avatar,
  s.language,
  s.autoplay_next,
  s.subtitle_language,
  s.notification_opt_in
FROM Profile p
LEFT JOIN ProfileSetting s ON p.profile_id = s.profile_id
WHERE p.profile_id = :profile_id;