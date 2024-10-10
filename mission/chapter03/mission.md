# 미션 API 설계

### 홈 화면
1.  홈 화면 보여주기
       - API Endpoint :
        ```
        GET http://umc.com/home
        ```
       -  Request Header :
        ```
        Bearer Token
        ```
2. 미션 도전
      - API Endpoint :
       ```
       POST http://umc.com/missions/{mission-id} 
       ```
      - Path variable : 
       ```
       mission-id
       ```
      - Request Header :
       ```
       Bearer Token
       ```

---


### 마이페이지 리뷰 작성
1. 리뷰 작성하기
      - API Endpoint :
       ```
       POST http://umc.com/users/reviews 
       ```
      - Request body :
         ```
         {
           "score" : ,
           "content" : ,
           "images" : [
                        { 
                          "URL" : ,
                        }, ...
                      ]
         }
         ```
      - Request Header :
       ```
       Bearer Token,
       content-type : Application/json
       ```
2. 내가 작성한 리뷰
      - API Endpoint :
       ```
       GET http://umc.com/users/reviews 
       ```
      - Request Header :
       ```
       Bearer Token
       ```

---

### 미션 목록 조회
1. 진행 중인 미션 조회
      - API Endpoint :
       ```
       GET http://umc.com/users/missions
       ```
      - Query string :
       ```
       status=1
       ```
      - Request Header :
       ```
       Bearer Token
       ```
2. 완료된 미션 조회
      - API Endpoint :
       ```
       GET http://umc.com/users/missions
       ```
      - Query string :
       ```
       status=2
       ```
      - Request Header :
       ```
       Bearer Token
       ```

---
### 미션 성공 누르기
1. 미션 성공
      - API Endpoint :
       ```
       PATCH http://umc.com/users/missions/{mission-id}
       ```
      - Request body :
        ```
        {
           "status" : "2"
        }
        ```
      - Path variable :
       ```
       mission-id
       ```
      - Request Header :
       ```
       Bearer Token
       ```
---
### 회원가입
1. 회원가입
      - API Endpoint :
       ```
       POST http://umc.com/users
       ```
      - Request body :
         ```
         {
           "name" : ,
           "gender" : ,
           "birth" : ,
           "address" : ,
           "food_categories" : [
               { 
                 "food_category_id" : ,
               }, ...
           ]
         }
         ```
      - Request Header :
       ```
       content-type : Application/json
       ```

