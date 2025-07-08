-- This script creates the database schema and insert dummy values ---
DROP TABLE IF EXISTS SubscriptionPlan CASCADE;
CREATE TABLE SubscriptionPlan (
                                  subscription_plan_id INT PRIMARY KEY,
                                  name VARCHAR(100),
                                  price DECIMAL(5,2),
                                  resolution VARCHAR(50),
                                  max_streams INT
);

DROP TABLE IF EXISTS "User" CASCADE;
CREATE TABLE "User" (
                        user_id INT PRIMARY KEY,
                        username VARCHAR(20),
                        email_address VARCHAR(40),
                        phone_number VARCHAR(20),
                        subscription_plan_id INT,
                        hashed_password VARCHAR(255),
                        FOREIGN KEY (subscription_plan_id) REFERENCES SubscriptionPlan(subscription_plan_id)
);

DROP TABLE IF EXISTS Profile CASCADE;
CREATE TABLE Profile (
                         profile_id INT PRIMARY KEY,
                         user_id INT,
                         profile_name VARCHAR(100),
                         age_limit INT,
                         avatar VARCHAR(255),
                         FOREIGN KEY (user_id) REFERENCES "User"(user_id)
);

DROP TABLE IF EXISTS ProfileSetting CASCADE;
CREATE TABLE ProfileSetting (
                                setting_id INT PRIMARY KEY,
                                profile_id INT,
                                display_language VARCHAR(20),
                                subtitle_language VARCHAR(20),
                                autoplay BOOLEAN,
                                notification BOOLEAN,
                                FOREIGN KEY (profile_id) REFERENCES Profile(profile_id)
);

DROP TABLE IF EXISTS Content CASCADE;
CREATE TABLE Content (
                         content_id INT PRIMARY KEY,
                         content_title VARCHAR(255),
                         content_description TEXT,
                         content_type VARCHAR(20),
                         duration INT,
                         genres VARCHAR(45),
                         release_date DATE,
                         age_rating VARCHAR(10)
);

DROP TABLE IF EXISTS Episode CASCADE;
CREATE TABLE Episode (
                         episode_id INT PRIMARY KEY,
                         content_id INT,
                         title VARCHAR(255),
                         season INT,
                         episode_number INT,
                         duration INT,
                         episode_url VARCHAR(255),
                         FOREIGN KEY (content_id) REFERENCES Content(content_id)
);

DROP TABLE IF EXISTS Genre CASCADE;
CREATE TABLE Genre (
                       genre_id INT PRIMARY KEY,
                       genre_name VARCHAR(50)
);

DROP TABLE IF EXISTS ContentGenre CASCADE;
CREATE TABLE ContentGenre (
                              content_id INT,
                              genre_id INT,
                              PRIMARY KEY (content_id, genre_id),
                              FOREIGN KEY (content_id) REFERENCES Content(content_id),
                              FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

DROP TABLE IF EXISTS Watchlist CASCADE;
CREATE TABLE Watchlist (
                           content_id INT,
                           profile_id INT,
                           PRIMARY KEY (content_id, profile_id),
                           FOREIGN KEY (content_id) REFERENCES Content(content_id),
                           FOREIGN KEY (profile_id) REFERENCES Profile(profile_id)
);

DROP TABLE IF EXISTS WatchHistory CASCADE;
CREATE TABLE WatchHistory (
                              history_id INT PRIMARY KEY,
                              profile_id INT,
                              content_id INT,
                              timestamp INT,
                              watched_at timestamp,
                              FOREIGN KEY (profile_id) REFERENCES Profile(profile_id),
                              FOREIGN KEY (content_id) REFERENCES Content(content_id)
);

DROP TABLE IF EXISTS Payment CASCADE;
CREATE TABLE Payment (
                         payment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                         user_id INT NOT NULL,
                         plan_id INT NOT NULL,
                         paid_amount DECIMAL(5,2),
                         payment_date DATE,
                         expiry_date DATE,
                         FOREIGN KEY (user_id) REFERENCES "User"(user_id),
                         FOREIGN KEY (plan_id) REFERENCES SubscriptionPlan(subscription_plan_id)
);

DROP TABLE IF EXISTS Invoice CASCADE;
CREATE TABLE Invoice (
                         invoice_id INT PRIMARY KEY,
                         payment_id INT,
                         issued_date DATE,
                         total_amount DECIMAL(5,2),
                         tax_amount DECIMAL(5,2),
                         billing_address TEXT,
                         invoice_file_url VARCHAR(255),
                         FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);

INSERT INTO SubscriptionPlan (subscription_plan_id, name, price, resolution, max_streams)
VALUES
    (1, 'Basic', 7.99, '480p', 1),
    (2, 'Standard', 12.99, '720p', 2),
    (3, 'Premium', 15.99, '1080p', 4),
    (4, 'Ultra', 18.99, '4K', 4),
    (5, 'Student', 19.23, '1080p', 3),
    (6, 'Family', 6.37, '720p', 3),
    (7, 'Mini', 9.04, '480p', 1),
    (8, 'Mini', 19.67, '480p', 2),
    (9, 'Student', 17.31, '480p', 3),
    (10, 'Mini', 18.71, '480p', 2);

INSERT INTO "User" (user_id, username, email_address, phone_number, subscription_plan_id, hashed_password)
VALUES
    (1, 'ruizkristin', 'jeremybrennan@gmail.com', 6396092409, 3, 'a172bf180b80583c2450905889ce759233d4aaeb77a239445e9322277fb7ae53'),
    (2, 'john60', 'lisa75@hamilton.info', 4080030440, 8, '485e6621fe1b1d875e529f4605714bcfdcfa3b123e8ae8b2d1341dc36aed7ceb'),
    (3, 'tony78', 'donnagordon@garcia.com', 8751780170, 1, 'cea37aec1b79f8f9d2a10db4800e881182dcb49535938303c170d9005328bf5b'),
    (4, 'diazdanny', 'davidtiffany@mays.net', 4634303969, 2, '42302e6268e5330d0ee407740e6ef7093ce410c2b951e5de74e57ffc8026c6d3'),
    (5, 'kyle07', 'tammyjacobs@morton.org', 6195335518, 4, 'b3e17e855f375fe012daf4096b0b26fcfa0f4c58cca87a0e40792914424040bd'),
    (6, 'ericmeyers', 'nicholasdorsey@gmail.com', 3955464602, 3, '5535129f324b1defcf080e27e5c66c59f9d9cf6f1b2d08d567a724e45a3089f2'),
    (7, 'donald53', 'susanmaldonado@hotmail.com', 9186761388, 5, '6e48b3cde402c364e7088b96e5c2c6ebfd5d65b474c690ed3d30e9601fba6171'),
    (8, 'raypowers', 'kristin14@hotmail.com', 3802927283, 6, 'c9b878bc2723fece2992146564ec746d9e4da519754093f322de7e2a31cf170e'),
    (9, 'jennifer88', 'ucook@gmail.com', 3142027023, 9, 'cff5904fb60c2fd9078912c7b76c2bc02cc5c91fccfb514838499e10abef28b7'),
    (10, 'dylan95', 'wramos@fischer.net', 9884424208, 7, '8cc0028c9729392579c6cafb5c65ba4ee45fee9fed1f9fa60189d68346d88545');

INSERT INTO Profile (profile_id, user_id, profile_name, age_limit, avatar)
VALUES
    (1, 8, 'Kayla', 7, 'https://www.lorempixel.com/793/280'),
    (2, 10, 'Shelley', 13, 'https://placekitten.com/157/204'),
    (3, 10, 'Mary', 13, 'https://placekitten.com/579/779'),
    (4, 9, 'William', 16, 'https://dummyimage.com/290x41'),
    (5, 8, 'Carol', 13, 'https://dummyimage.com/463x587'),
    (6, 10, 'Shane', 18, 'https://www.lorempixel.com/955/682'),
    (7, 2, 'Sarah', 13, 'https://placeimg.com/623/121/any'),
    (8, 7, 'Susan', 16, 'https://www.lorempixel.com/338/472'),
    (9, 4, 'Laurie', 18, 'https://www.lorempixel.com/684/805'),
    (10, 1, 'Brett', 13, 'https://placekitten.com/263/358');

INSERT INTO ProfileSetting (setting_id, profile_id, display_language, subtitle_language, autoplay, notification)
VALUES
    (1, 1, 'fr', 'fr', FALSE, FALSE),
    (2, 2, 'en', 'fr', FALSE, TRUE),
    (3, 3, 'es', 'de', TRUE, TRUE),
    (4, 4, 'de', 'de', TRUE, FALSE),
    (5, 5, 'de', 'de', TRUE, TRUE),
    (6, 6, 'de', 'de', FALSE, TRUE),
    (7, 7, 'fr', 'en', TRUE, FALSE),
    (8, 8, 'es', 'de', FALSE, TRUE),
    (9, 9, 'en', 'de', TRUE, FALSE),
    (10, 10, 'de', 'es', TRUE, TRUE);

INSERT INTO Content (content_id, content_title, content_description, content_type, duration, genres, release_date, age_rating)
VALUES
    (1, 'Stranger Things', 'A group of kids uncover supernatural mysteries in a small town.', 'Series', 62, 'Action', '2017-11-12', 'PG'),
    (2, 'Breaking Bad', 'A chemistry teacher turns to making meth after a terminal diagnosis.', 'Series', 46, 'Historical', '2022-11-19', 'PG-13'),
    (3, 'The Witcher', 'A mutated monster hunter struggles to find his place in a twisted world.', 'Series', 52, 'Crime', '2023-06-18', 'G'),
    (4, 'Money Heist', 'A criminal mastermind leads a heist on the Royal Mint of Spain.', 'Series', 54, 'Thriller', '2019-04-21', 'PG'),
    (5, 'Narcos', 'A DEA agent tracks the rise of the cocaine trade in Colombia.', 'Series', 60, 'Sci-Fi', '2017-11-25', 'R'),
    (6, 'Inception', 'A thief who steals corporate secrets through dream-sharing is given a task to plant an idea.', 'Movie', 124, 'Historical', '2020-08-16', 'PG'),
    (7, 'The Irishman', 'An aging hitman recalls his past involvement with the mob.', 'Movie', 109, 'Thriller', '2015-09-21', 'G'),
    (8, 'Parasite', 'A poor family schemes to become employed by a wealthy household.', 'Movie', 155, 'Historical', '2015-10-14', 'R'),
    (9, 'The Social Network', 'The story behind the creation of Facebook.', 'Movie', 173, 'Sci-Fi', '2020-03-19', 'PG'),
    (10, 'Interstellar', 'A team travels through a wormhole in search of a new home for humanity.', 'Movie', 114, 'Crime', '2016-02-05', 'R');

INSERT INTO Episode (episode_id, content_id, title, season, episode_number, duration, episode_url)
VALUES
    (1, 1, 'Stranger Things - Episode 6', 1, 6, 62, 'https://sutton.info/'),
    (2, 2, 'Breaking Bad - Episode 3', 1, 3, 46, 'https://www.moran-mitchell.net/'),
    (3, 3, 'The Witcher - Episode 1', 1, 1, 52, 'http://rocha.com/'),
    (4, 4, 'Money Heist - Episode 8', 1, 8, 54, 'https://www.martinez-serrano.com/'),
    (5, 5, 'Narcos - Episode 2', 1, 2, 60, 'https://anderson-rasmussen.net/'),
    (6, 6, 'Inception', 1, 1, 124, 'http://wilkinson-thompson.com/'),
    (7, 7, 'The Irishman', 1, 1, 109, 'https://gonzalez.com/'),
    (8, 8, 'Parasite', 1, 1, 155, 'http://wise.com/'),
    (9, 9, 'The Social Network', 1, 1, 173, 'http://www.hopkins.com/'),
    (10, 10, 'Interstellar', 1, 1, 114, 'https://freeman-miles.com/');

INSERT INTO Genre (genre_id, genre_name)
VALUES
    (1, 'Action'),
    (2, 'Drama'),
    (3, 'Comedy'),
    (4, 'Thriller'),
    (5, 'Horror'),
    (6, 'Sci-Fi'),
    (7, 'Romance'),
    (8, 'Fantasy'),
    (9, 'Animation'),
    (10, 'Documentary');

INSERT INTO ContentGenre (content_id, genre_id)
VALUES
    (1, 6),  -- Stranger Things → Sci-Fi
    (1, 5),  -- Stranger Things → Horror
    (2, 1),  -- Breaking Bad → Action
    (2, 4),  -- Breaking Bad → Thriller
    (3, 8),  -- The Witcher → Fantasy
    (3, 1),  -- The Witcher → Action
    (4, 1),  -- Money Heist → Action
    (4, 4),  -- Money Heist → Thriller
    (5, 1),  -- Narcos → Action
    (5, 2),  -- Narcos → Drama
    (6, 6),  -- Inception → Sci-Fi
    (6, 4),  -- Inception → Thriller
    (7, 1),  -- Irishman → Action
    (7, 2),  -- Irishman → Drama
    (8, 2),  -- Parasite → Drama
    (8, 4),  -- Parasite → Thriller
    (9, 2),  -- Social Network → Drama
    (10, 6), -- Interstellar → Sci-Fi
    (10, 2); -- Interstellar → Drama

INSERT INTO Watchlist (content_id, profile_id)
VALUES
    (8, 7),
    (7, 3),
    (3, 7),
    (10, 1),
    (3, 3),
    (9, 10),
    (7, 8),
    (5, 6),
    (4, 4),
    (6, 4);

INSERT INTO WatchHistory (history_id, profile_id, content_id, timestamp, watched_at)
VALUES
    (1, 10, 1, 3690, '2025-07-04 15:37:40'),
    (2, 1, 5, 2748, '2021-10-01 00:09:27'),
    (3, 8, 1, 97, '2025-03-21 07:54:28'),
    (4, 10, 8, 5770, '2022-09-29 11:00:17'),
    (5, 2, 8, 5625, '2020-03-10 21:38:32'),
    (6, 1, 10, 1069, '2024-01-03 04:09:36'),
    (7, 1, 10, 6344, '2025-03-05 05:17:40'),
    (8, 5, 2, 1682, '2024-07-19 23:12:39'),
    (9, 5, 4, 2850, '2022-07-30 11:40:26'),
    (10, 9, 8, 5110, '2024-06-24 14:34:52');

INSERT INTO Payment (user_id, plan_id, paid_amount, payment_date, expiry_date)
VALUES -- now omit payment_id since it is auto-generated
    (7, 9, 17.31, '2023-10-06', '2025-03-01'),
    (3, 10, 18.71, '2023-06-18', '2024-06-12'),
    (7, 1, 7.99, '2023-11-06', '2024-08-01'),
    (8, 3, 15.99, '2021-01-20', '2023-09-12'),
    (6, 1, 7.99, '2023-12-07', '2024-04-06'),
    (5, 9, 17.31, '2020-05-03', '2024-08-25'),
    (7, 8, 19.67, '2021-06-01', '2021-12-01'),
    (8, 2, 12.99, '2024-06-17', '2025-05-03'),
    (9, 7, 9.04, '2023-02-08', '2023-05-02'),
    (6, 7, 9.04, '2022-02-18', '2023-12-16');

INSERT INTO Invoice (invoice_id, payment_id, issued_date, total_amount, tax_amount, billing_address, invoice_file_url)
VALUES
    (1, 1, '2024-07-29', 17.31, 2.13, '476 Gray Mews, Lake Stephanie, OK 78445', 'http://www.rodriguez.com/'),
    (2, 2, '2023-08-17', 18.71, 1.25, '16767 Noah Square, East Matthewfort, AR 69173', 'http://www.day-lara.com/'),
    (3, 3, '2024-06-07', 7.99, 0.98, '3936 Anna Street Suite 498, Hicksborough, WA 19799', 'http://ayers-conley.com/'),
    (4, 4, '2022-12-28', 15.99, 2.11, '054 Taylor Isle, Taylorberg, RI 52164', 'http://www.simmons.com/'),
    (5, 5, '2024-02-22', 7.99, 1.05, '5972 Janet Ranch Suite 533, North Rachel, HI 79938', 'http://alvarez.com/'),
    (6, 6, '2024-02-19', 17.31, 2.33, '77579 Simmons Falls, West Judy, AR 70171', 'https://www.marquez-larson.com/'),
    (7, 7, '2021-06-01', 19.67, 2.09, '92947 Sweeney Valleys, Campbellton, CA 72672', 'https://www.newton.biz/'),
    (8, 8, '2024-12-15', 12.99, 0.75, '25791 Wendy Wall, Kristenburgh, IA 65438', 'http://nguyen.org/'),
    (9, 9, '2023-03-22', 9.04, 1.05, '963 Newton Isle, Turnermouth, NM 78277', 'https://torres-dunn.com/'),
    (10, 10, '2023-04-21', 9.04, 0.56, '63113 Anthony Ports, North Jenniferbury, LA 25858', 'https://cantu.com/');
