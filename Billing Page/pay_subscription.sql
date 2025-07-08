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