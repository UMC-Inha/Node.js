//진행 중, 진행 완료한 미션
SELECT missions.area_id, missions.mission_content, user_id, is_complete, updated_at
FROM user_missions
JOIN missions
ON user_missions.mission_id = missions.id
WHERE user_missions.user_id = 1 AND is_complete = 0
ORDER BY updated_at DESC LIMIT 10 OFFSET 3;

//리뷰 작성 페이지 불러오기
SELECT rating, content, user_id, users.username, updated_at
FROM reviews
JOIN users
ON reviews.user_id = users.id
WHERE reviews.shop_id = 1
ORDER BY rating DESC;

//리뷰에 레코드 추가하기
INSERT INTO reviews(user_id, shop_id, content, rating) VALUES (1, 1, '리뷰내용', 4.5);

//마이페이지 정보 불러오기
SELECT username, email, points, phone_num, phone_verify
FROM users
WHERE users.id = 1;

//홈화면 정보 불러오기 point 순으로 정렬
SELECT area.area_name, missions.mission_content, point
FROM area_mission
JOIN area ON area.id = area_mission.area_id
JOIN missions ON area_mission.mission_id = missions.id
WHERE area.id = 1
ORDER BY point DESC LIMIT 10 OFFSET 3;