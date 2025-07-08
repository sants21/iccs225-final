INSERT INTO subscriptionplan (subscription_plan_id,name, price, resolution, max_streams)
VALUES (${subscription_plan_id}, ${name}, ${price}, ${resolution}, ${max_streams});

--testing purposes-
-- SELECT * FROM subscriptionplan
-- WHERE subscription_plan_id = ${subscription_plan_id};