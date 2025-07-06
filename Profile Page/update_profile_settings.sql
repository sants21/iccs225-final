INSERT INTO ProfileSetting (profile_id, language, autoplay_next, subtitle_language, notification_opt_in)
VALUES (:profile_id, :language, :autoplay_next, :subtitle_language, :notification_opt_in)
ON DUPLICATE KEY UPDATE
  language = :language,
  autoplay_next = :autoplay_next,
  subtitle_language = :subtitle_language,
  notification_opt_in = :notification_opt_in;