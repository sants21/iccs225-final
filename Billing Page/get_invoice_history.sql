SELECT
  i.invoice_id,
  i.issued_date,
  i.total_amount,
  i.tax_amount,
  i.invoice_file_url
FROM Invoice i
JOIN Payment p ON i.payment_id = p.payment_id
WHERE p.user_id = :user_id
ORDER BY i.issued_date DESC;