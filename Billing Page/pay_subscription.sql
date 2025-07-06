INSERT INTO Payment (user_id, plan_id, amount, payment_date, expiry_date)
SELECT :user_id, :plan_id, s.price, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
FROM SubscriptionPlan s
WHERE s.plan_id = :plan_id;

UPDATE User
SET subscription_plan_id = :plan_id
WHERE user_id = :user_id;