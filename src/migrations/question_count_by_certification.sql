-- Query to count questions by certification after 2026-03-15
SELECT 
  c.title AS certification_name,
  COUNT(q.id) AS question_count
FROM 
  public.certifications c
  LEFT JOIN public.topics t ON c.id = t.certification_id
  LEFT JOIN public.modules m ON t.topic_id = m.topic_id
  LEFT JOIN public.question q ON m.module_id = q.module_id
    AND q.created_at > '2026-03-15'::timestamp
    AND q.module_id IS NOT NULL
GROUP BY 
  c.id,
  c.title

UNION ALL

-- Total row
SELECT 
  'TOTAL' AS certification_name,
  COUNT(q.id) AS question_count
FROM 
  public.question q
WHERE 
  q.created_at > '2026-03-15'::timestamp
  AND q.module_id IS NOT NULL

ORDER BY 
  question_count DESC, 
  certification_name ASC;
