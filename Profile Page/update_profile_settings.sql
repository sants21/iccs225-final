INSERT INTO ProfileSetting (profile_id, display_language, autoplay, subtitle_language, notification)
VALUES (${profile_id}, ${language}, ${autoplay_next}, ${subtitle_language}, ${notification_opt_in})
ON CONFLICT (profile_id)
    DO UPDATE SET
                  display_language = EXCLUDED.display_language,
                  autoplay = EXCLUDED.autoplay,
                  subtitle_language = EXCLUDED.subtitle_language,
                  notification = EXCLUDED.notification;