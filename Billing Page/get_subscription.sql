SELECT
  u.user_id,
  s.name AS plan_name,
  s.price,
  s.resolution,
  s.max_streams,
  p.expiry_date
FROM User u
JOIN SubscriptionPlan s ON u.subscription_plan_id = s.plan_id
LEFT JOIN Payment p ON p.user_id = u.user_id
WHERE u.user_id = :user_id
ORDER BY p.expiry_date DESC
LIMIT 1;