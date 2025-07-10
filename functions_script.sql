CREATE OR REPLACE FUNCTION get_top_search_results()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        c.content_id,
        c.content_title,
        c.content_type,
        c.release_date,
        COUNT(w.profile_id) AS view_count
    FROM Content c
             LEFT JOIN WatchHistory w ON c.content_id = w.content_id
    WHERE c.content_title ILIKE '%' || ${keyword} || '%'
    GROUP BY c.content_id, c.content_title, c.content_type, c.release_date
    ORDER BY view_count DESC, c.release_date DESC
    LIMIT 10;
END;
$$;


CREATE OR REPLACE FUNCTION remove_from_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Watchlist
    WHERE profile_id = ${profile_id} AND content_id = ${content_id};

    --testing purposes--

    -- SELECT * FROM Watchlist
    -- WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, c.content_type, c.release_date, c.content_description, c.duration
    FROM Watchlist w
             JOIN Content c ON w.content_id = c.content_id
    WHERE w.profile_id = ${profile_id};

    --testing purposes--

    -- SELECT * FROM Watchlist w
    --          JOIN Content c ON w.content_id = c.content_id
    -- WHERE w.profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_all_profiles()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        p.profile_id,
        p.profile_name,
        p.age_limit,
        p.avatar
    FROM Profile p
    WHERE p.user_id = :user_id;
END;
$$;


CREATE OR REPLACE FUNCTION update_profile_settings()
    RETURNS VOID
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ProfileSetting (profile_id, display_language, autoplay, subtitle_language, notification)
    VALUES (${profile_id}, ${language}, ${autoplay_next}, ${subtitle_language}, ${notification_opt_in})
    ON CONFLICT (profile_id)
        DO UPDATE SET
                      display_language = EXCLUDED.display_language,
                      autoplay = EXCLUDED.autoplay,
                      subtitle_language = EXCLUDED.subtitle_language,
                      notification = EXCLUDED.notification;
END;
$$;


CREATE OR REPLACE FUNCTION update_profile()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Profile
    SET profile_name  = ${profile_name},
        age_limit = ${age_limit},
        avatar = ${avatar}
    WHERE profile_id = ${profile_id};

    --testing purposes--
    -- SELECT * FROM Profile
    -- WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_profile()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
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
END;
$$;


CREATE OR REPLACE FUNCTION delete_profile()
    RETURNS VOID
    LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Profile
    WHERE profile_id = :profile_id;
END;
$$;


CREATE OR REPLACE FUNCTION get_top_10()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, COUNT(*) AS views
    FROM WatchHistory w
             JOIN Content c ON w.content_id = c.content_id
    GROUP BY c.content_id, c.content_title
    ORDER BY views DESC
    LIMIT 10;
END;
$$;

CREATE OR REPLACE FUNCTION get_top_search_results()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        c.content_id,
        c.content_title,
        c.content_type,
        c.release_date,
        COUNT(w.profile_id) AS view_count
    FROM Content c
             LEFT JOIN WatchHistory w ON c.content_id = w.content_id
    WHERE c.content_title ILIKE '%' || ${keyword} || '%'
    GROUP BY c.content_id, c.content_title, c.content_type, c.release_date
    ORDER BY view_count DESC, c.release_date DESC
    LIMIT 10;
END;
$$;


CREATE OR REPLACE FUNCTION remove_from_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Watchlist
    WHERE profile_id = ${profile_id} AND content_id = ${content_id};

    --testing purposes--

    -- SELECT * FROM Watchlist
    -- WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, c.content_type, c.release_date, c.content_description, c.duration
    FROM Watchlist w
             JOIN Content c ON w.content_id = c.content_id
    WHERE w.profile_id = ${profile_id};

    --testing purposes--

    -- SELECT * FROM Watchlist w
    --          JOIN Content c ON w.content_id = c.content_id
    -- WHERE w.profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_all_profiles()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        p.profile_id,
        p.profile_name,
        p.age_limit,
        p.avatar
    FROM Profile p
    WHERE p.user_id = :user_id;
END;
$$;


CREATE OR REPLACE FUNCTION update_profile_settings()
    RETURNS VOID
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ProfileSetting (profile_id, display_language, autoplay, subtitle_language, notification)
    VALUES (${profile_id}, ${language}, ${autoplay_next}, ${subtitle_language}, ${notification_opt_in})
    ON CONFLICT (profile_id)
        DO UPDATE SET
                      display_language = EXCLUDED.display_language,
                      autoplay = EXCLUDED.autoplay,
                      subtitle_language = EXCLUDED.subtitle_language,
                      notification = EXCLUDED.notification;
END;
$$;


CREATE OR REPLACE FUNCTION update_profile()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Profile
    SET profile_name  = ${profile_name},
        age_limit = ${age_limit},
        avatar = ${avatar}
    WHERE profile_id = ${profile_id};

    --testing purposes--
    -- SELECT * FROM Profile
    -- WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_profile()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
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
END;
$$;


CREATE OR REPLACE FUNCTION delete_profile()
    RETURNS VOID
    LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Profile
    WHERE profile_id = :profile_id;
END;
$$;


CREATE OR REPLACE FUNCTION get_top_10()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, COUNT(*) AS views
    FROM WatchHistory w
             JOIN Content c ON w.content_id = c.content_id
    GROUP BY c.content_id, c.content_title
    ORDER BY views DESC
    LIMIT 10;
END;
$$;


CREATE OR REPLACE FUNCTION get_recommendations()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
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
END;
$$;


CREATE OR REPLACE FUNCTION get_new_releases()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT content_id, content_title, release_date
    FROM Content
    ORDER BY release_date DESC, content_id DESC
    LIMIT 10;
END;
$$;


CREATE OR REPLACE FUNCTION get_continue_watching()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, w.timestamp, c.duration
    FROM WatchHistory w
             JOIN Content c ON w.content_id = c.content_id
    WHERE w.profile_id = ${profile_id}
      AND w.timestamp < c.duration * 60
    ORDER BY w.watched_at DESC;

    --timestamp is in seconds, duration is in minutes--
END;
$$;


CREATE OR REPLACE FUNCTION get_featured_content()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, c.content_description, c.content_type, c.release_date, c.genres, c.age_rating
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
    ORDER BY c.release_date DESC, c.content_id DESC
    LIMIT 1;
END;
$$;


CREATE OR REPLACE FUNCTION get_movie_playback_data()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        content_id,
        content_title,
        content_description,
        duration,
        release_date,
        age_rating,
        genres,
        content_type
    FROM Content
    WHERE content_id = ${content_id} AND content_type = 'Movie';
END;
$$;


CREATE OR REPLACE FUNCTION get_episode_playback_data()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        e.episode_id,
        e.content_id,
        e.title,
        e.season,
        e.episode_number,
        e.duration,
        e.episode_url,
        c.content_title AS show_title,
        c.age_rating
    FROM Episode e
             JOIN Content c ON e.content_id = c.content_id
    WHERE e.episode_id = ${episode_id};
END;
$$;


CREATE OR REPLACE FUNCTION mark_as_watched()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO WatchHistory (history_id, profile_id, content_id, watched_at, timestamp)
    VALUES (${history_id}, ${profile_id}, ${content_id}, NOW(), ${progress_seconds})
    ON CONFLICT (profile_id, content_id)
        DO UPDATE
        SET watched_at = NOW(),
            timestamp = EXCLUDED.timestamp;

    --testing purposes---
    --     SELECT * FROM WatchHistory
    --     WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION is_in_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) > 0 AS is_saved
    FROM Watchlist
    WHERE profile_id = ${profile_id} AND content_id = ${content_id};


    --testing purposes--
    -- SELECT * FROM Watchlist
    -- WHERE profile_id = ${profile_id} AND content_id = ${content_id}
END;
$$;


CREATE OR REPLACE FUNCTION get_episode_list()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT episode_id, title, season, episode_number, duration, episode_url
    FROM Episode
    WHERE content_id = ${content_id}
    ORDER BY season, episode_number;
END;
$$;


CREATE OR REPLACE FUNCTION get_content_details()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        c.content_id,
        c.content_title,
        c.content_description,
        c.content_type,
        c.genres as primary_genre,
        c.duration,
        c.release_date,
        c.age_rating,
        STRING_AGG(g.genre_name, ', ') AS genres
    FROM Content c
             LEFT JOIN ContentGenre cg ON c.content_id = cg.content_id
             LEFT JOIN Genre g ON cg.genre_id = g.genre_id
    WHERE c.content_id = ${content_id}
    GROUP BY c.content_id, c.content_title, c.content_description, c.content_type, c.release_date, c.genres, c.duration, c.age_rating;
END;
$$;

CREATE OR REPLACE FUNCTION get_top_search_results()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        c.content_id,
        c.content_title,
        c.content_type,
        c.release_date,
        COUNT(w.profile_id) AS view_count
    FROM Content c
             LEFT JOIN WatchHistory w ON c.content_id = w.content_id
    WHERE c.content_title ILIKE '%' || ${keyword} || '%'
    GROUP BY c.content_id, c.content_title, c.content_type, c.release_date
    ORDER BY view_count DESC, c.release_date DESC
    LIMIT 10;
END;
$$;


CREATE OR REPLACE FUNCTION remove_from_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Watchlist
    WHERE profile_id = ${profile_id} AND content_id = ${content_id};

    --testing purposes--

    -- SELECT * FROM Watchlist
    -- WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, c.content_type, c.release_date, c.content_description, c.duration
    FROM Watchlist w
             JOIN Content c ON w.content_id = c.content_id
    WHERE w.profile_id = ${profile_id};

    --testing purposes--

    -- SELECT * FROM Watchlist w
    --          JOIN Content c ON w.content_id = c.content_id
    -- WHERE w.profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_all_profiles()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        p.profile_id,
        p.profile_name,
        p.age_limit,
        p.avatar
    FROM Profile p
    WHERE p.user_id = :user_id;
END;
$$;


CREATE OR REPLACE FUNCTION update_profile_settings()
    RETURNS VOID
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ProfileSetting (profile_id, display_language, autoplay, subtitle_language, notification)
    VALUES (${profile_id}, ${language}, ${autoplay_next}, ${subtitle_language}, ${notification_opt_in})
    ON CONFLICT (profile_id)
        DO UPDATE SET
                      display_language = EXCLUDED.display_language,
                      autoplay = EXCLUDED.autoplay,
                      subtitle_language = EXCLUDED.subtitle_language,
                      notification = EXCLUDED.notification;
END;
$$;


CREATE OR REPLACE FUNCTION update_profile()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Profile
    SET profile_name  = ${profile_name},
        age_limit = ${age_limit},
        avatar = ${avatar}
    WHERE profile_id = ${profile_id};

    --testing purposes--
    -- SELECT * FROM Profile
    -- WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION get_profile()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
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
END;
$$;


CREATE OR REPLACE FUNCTION delete_profile()
    RETURNS VOID
    LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Profile
    WHERE profile_id = :profile_id;
END;
$$;


CREATE OR REPLACE FUNCTION get_top_10()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, COUNT(*) AS views
    FROM WatchHistory w
             JOIN Content c ON w.content_id = c.content_id
    GROUP BY c.content_id, c.content_title
    ORDER BY views DESC
    LIMIT 10;
END;
$$;


CREATE OR REPLACE FUNCTION get_recommendations()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
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
END;
$$;


CREATE OR REPLACE FUNCTION get_new_releases()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT content_id, content_title, release_date
    FROM Content
    ORDER BY release_date DESC, content_id DESC
    LIMIT 10;
END;
$$;


CREATE OR REPLACE FUNCTION get_continue_watching()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, w.timestamp, c.duration
    FROM WatchHistory w
             JOIN Content c ON w.content_id = c.content_id
    WHERE w.profile_id = ${profile_id}
      AND w.timestamp < c.duration * 60
    ORDER BY w.watched_at DESC;

    --timestamp is in seconds, duration is in minutes--
END;
$$;


CREATE OR REPLACE FUNCTION get_featured_content()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.content_id, c.content_title, c.content_description, c.content_type, c.release_date, c.age_rating, c.genres
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
    ORDER BY c.release_date DESC, c.content_id DESC
    LIMIT 1;
END;
$$;


CREATE OR REPLACE FUNCTION get_movie_playback_data()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        content_id,
        content_title,
        content_description,
        duration,
        release_date,
        age_rating,
        genres,
        content_type
    FROM Content
    WHERE content_id = ${content_id} AND content_type = 'Movie';
END;
$$;


CREATE OR REPLACE FUNCTION get_episode_playback_data()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        e.episode_id,
        e.content_id,
        e.title,
        e.season,
        e.episode_number,
        e.duration,
        e.episode_url,
        c.content_title AS show_title,
        c.age_rating
    FROM Episode e
             JOIN Content c ON e.content_id = c.content_id
    WHERE e.episode_id = ${episode_id};
END;
$$;


CREATE OR REPLACE FUNCTION mark_as_watched()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO WatchHistory (history_id, profile_id, content_id, watched_at, timestamp)
    VALUES (${history_id}, ${profile_id}, ${content_id}, NOW(), ${progress_seconds})
    ON CONFLICT (profile_id, content_id)
        DO UPDATE
        SET watched_at = NOW(),
            timestamp = EXCLUDED.timestamp;

    --testing purposes---
    --     SELECT * FROM WatchHistory
    --     WHERE profile_id = ${profile_id};
END;
$$;


CREATE OR REPLACE FUNCTION is_in_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) > 0 AS is_saved
    FROM Watchlist
    WHERE profile_id = ${profile_id} AND content_id = ${content_id};


    --testing purposes--
    -- SELECT * FROM Watchlist
    -- WHERE profile_id = ${profile_id} AND content_id = ${content_id}
END;
$$;


CREATE OR REPLACE FUNCTION get_episode_list()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT episode_id, title, season, episode_number, duration, episode_url
    FROM Episode
    WHERE content_id = ${content_id}
    ORDER BY season, episode_number;
END;
$$;


CREATE OR REPLACE FUNCTION get_content_details()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        c.content_id,
        c.content_title,
        c.content_description,
        c.content_type,
        c.genres as primary_genre,
        c.duration,
        c.release_date,
        c.age_rating,
        STRING_AGG(g.genre_name, ', ') AS genres
    FROM Content c
             LEFT JOIN ContentGenre cg ON c.content_id = cg.content_id
             LEFT JOIN Genre g ON cg.genre_id = g.genre_id
    WHERE c.content_id = ${content_id}
    GROUP BY c.content_id, c.content_title, c.content_description, c.content_type, c.release_date, c.genres, c.duration, c.age_rating;
END;
$$;


CREATE OR REPLACE FUNCTION add_to_watchlist()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Watchlist (profile_id, content_id)
    VALUES (${profile_id}, ${content_id})
    ON CONFLICT DO NOTHING;

    --testing purposes--
    -- SELECT * FROM Watchlist
    -- WHERE profile_id = ${profile_id}
END;
$$;


CREATE OR REPLACE FUNCTION get_available_plans()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT subscription_plan_id, name, price, resolution, max_streams
    FROM subscriptionplan;
END;
$$;


CREATE OR REPLACE FUNCTION pay_subscription()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    -- INSERT into Payment
    INSERT INTO Payment (user_id, plan_id, paid_amount, payment_date, expiry_date)
    SELECT ${user_id}, ${plan_id}, s.price, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month'
    FROM subscriptionplan s
    WHERE s.subscription_plan_id = ${plan_id};

    -- UPDATE the user's subscription plan
    UPDATE "User"
    SET subscription_plan_id = ${plan_id}
    WHERE user_id = ${user_id};

    -- testing purposes, we can check if the payment was inserted correctly
    -- SELECT *
    -- FROM Payment
    -- WHERE user_id = 1
    -- ORDER BY payment_date DESC;
END;
$$;


CREATE OR REPLACE FUNCTION get_invoice_history()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        i.invoice_id,
        i.issued_date,
        i.total_amount,
        i.tax_amount,
        i.invoice_file_url
    FROM Invoice i
             JOIN Payment p ON i.payment_id = p.payment_id
    WHERE p.user_id = ${user_id}
    ORDER BY i.issued_date DESC;
END;
$$;


CREATE OR REPLACE FUNCTION get_subscription()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    SELECT
        u.user_id,
        s.subscription_plan_id AS plan_id,
        s.name AS plan_name,
        s.price,
        s.resolution,
        s.max_streams,
        p.expiry_date
    FROM "User" u
             JOIN subscriptionplan s ON u.subscription_plan_id = s.subscription_plan_id
             LEFT JOIN payment p ON p.user_id = u.user_id
    WHERE u.user_id = ${user_id}
    ORDER BY p.expiry_date DESC
    LIMIT 1;
END;
$$;


CREATE OR REPLACE FUNCTION admin_upload_episode()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Episode (episode_id, content_id, title, season, episode_number, duration, episode_url)
    VALUES (${episode_id}, ${content_id}, ${title}, ${season}, ${episode_number}, ${duration}, ${episode_url});

    --testing purposes--
    -- SELECT * FROM Episode
    -- WHERE episode_id = ${episode_id};
END;
$$;


CREATE OR REPLACE FUNCTION admin_assign_genres()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ContentGenre (content_id, genre_id)
    VALUES
        (${content_id}, ${genre_id});

    --testing purposes--
    -- SELECT * FROM ContentGenre
    -- WHERE content_id = ${content_id}
END;
$$;


CREATE OR REPLACE FUNCTION admin_add_subscription_plan()
    RETURNS TABLE(result RECORD)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO subscriptionplan (name, price, resolution, max_streams)
    VALUES ( ${name}, ${price}, ${resolution}, ${max_streams});

    --testing purposes-
    -- SELECT * FROM subscriptionplan
    -- WHERE subscription_plan_id = ${subscription_plan_id};
END;
$$;


CREATE OR REPLACE FUNCTION admin_add_content(
    p_admin_id INT,
    p_title VARCHAR,
    p_description TEXT,
    p_type VARCHAR,
    p_duration INT,
    p_genres VARCHAR,
    p_release_date DATE,
    p_age_rating VARCHAR
) RETURNS VOID AS $$
DECLARE
    new_content_id INT;
BEGIN
    -- Insert new content
    INSERT INTO Content (
        content_title, content_description, content_type,
        duration, genres, release_date, age_rating
    )
    VALUES (
               p_title, p_description, p_type,
               p_duration, p_genres, p_release_date, p_age_rating
           )
    RETURNING content_id INTO new_content_id;

    -- Log the upload action
    INSERT INTO ContentUploadLog (admin_id, content_id)
    VALUES (p_admin_id, new_content_id);
END;
$$ LANGUAGE plpgsql;

