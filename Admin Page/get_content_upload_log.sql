SELECT
  l.admin_id,
  a.username,
  c.title,
  l.uploaded_at
FROM ContentUploadLog l
JOIN AdminUser a ON l.admin_id = a.admin_id
JOIN Content c ON l.content_id = c.content_id
ORDER BY l.uploaded_at DESC;