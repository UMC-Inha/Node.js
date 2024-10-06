-- 내가 진행중, 진행 완료한 미션 모아서 보는 쿼리(페이징 포함)
SELECT 
	m.mission_id, 
	s.store_name, 
	m.mission_description, 
	m.points, 
	um.status,
	um.completed_at
FROM user_missions AS um
JOIN missions AS m ON um.mission_id = m.mission_id
JOIN stores AS s ON m.store_id = s.store_id
WHERE um.user_id = {user_id} AND um.status = 'complete'
LIMIT 10 OFFSET {offset};

-- 리뷰 작성하는 쿼리,
INSERT INTO reviews (user_id, mission_id, store_id, rating, review_text)
VALUES ({user_id}, {mission_id}, {store_id}, {rating}, {review_text});

SELECT r.rating, r.review_text, r.created_at
FROM review AS r
WHERE r.user_id = {user_id}
LIMIT 10 OFFSET {offset}

-- 홈 화면 쿼리(현재 선택 된 지역에서 도전이 가능한 미션 목록, 페이징 포함)
SELECT m.mission_id, s.store_name, m.mission_description, m.points
FROM missions as m
JOIN stores AS s ON m.store_id = s.store_id
WHERE s.region_id = {region_id}
  AND m.mission_id NOT IN (
    SELECT mission_id 
    FROM user_missions 
    WHERE user_id = {user_id}
  )
ORDER BY m.points DESC
LIMIT 10 OFFSET {offset};

-- 마이 페이지 화면 쿼리
SELECT 
  u.username, u.email, u.points, (
  SELECT r.rating, r.review_text, r.created_at
  FROM review AS r
  WHERE r.user_id = u.user_id
  )
FROM users u
WHERE u.user_id = {user_id}
