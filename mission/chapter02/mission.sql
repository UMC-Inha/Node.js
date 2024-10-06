-- 마이페이지

SELECT
    username,
    email,
    phone_number,
    point

FROM    
     users
WHERE   
    username='nickname012';


--리뷰 작성 쿼리
INSERT INTO stores_reviews (store_id,user_id,rating,review_text,created_at,updated_at)
VALUES (store_id , user_id ,rating , review_text ,now(),now());


--홈 화면 쿼리
SELECT
    m.id,
    m.title,
    s.store_name,
    m.body,
    m.created_at,
    um.status,
    m.status,
    CASE 
        WHEN um.status = 'completed' THEN '미션 완료'
        ELSE '미션 도전!'
    END
FROM 
    mission m
JOIN 
    stores s ON m.store_id = s.store_id
JOIN 
    region r ON s.store_id = r.id
JOIN 
    user_Mission um ON m.id = um.mission_id
JOIN 
    users u ON um.user_id = u.id
WHERE 
    r.name = '안암동'
AND 
    um.status <> 'completed'
ORDER BY 
    m.created_at DESC
LIMIT 10;
 

--미션 모아서 보는 쿼리 

SELECT 
    um.mission_id,
    m.title,
    m.body,
    s.store_name,
    um.status,  -- '진행중', '진행 완료'
    um.created_at
FROM 
    user_Mission um
JOIN 
    mission m ON um.mission_id = m.id
JOIN 
    stores s ON m.store_id = s.store_id
JOIN 
    users u ON um.user_id = u.id
ORDER BY 
    um.created_at DESC 
LIMIT 6 OFFSET 0;
