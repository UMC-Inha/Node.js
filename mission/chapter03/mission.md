1. 회원 가입 API
   - Endpoint: POST /api/users
   - Request Body:
     ```json
     {
     	"username": "string",
     	"email": "string",
     	"password": "string"
     }
     ```
   - Response: 201 Created
2. 미션 목록 조회 (홈)
   - Endpoint: GET /api/missions
   - Query Parameters:
     - status: "ongoing" | "completed"
   - Request Header:
     - Authorization: Bearer {token}
   - Response: 200 OK
3. 미션 성공 누르기 API
   - Endpoint: PUT /api/missions/{mission_id}/complete
   - Path Variable: mission_id
   - Request Header:
     - Authorization: Bearer {token}
   - Response: 200 OK
4. 마이 페이지 정보 조회 API (토큰으로 구별)
   - Endpoint: GET /api/users/my
   - Request Header:
     - Authorization: Bearer {token}
   - Response: 200 OK
5. 리뷰 작성 API
   - Endpoint: POST /api/reviews
   - Request Header:
     - Authorization: Bearer {token}
   - Request Body:
     ```json
     {
     	"mission_id": "integer",
     	"store_id": "integer",
     	"rating": "integer",
     	"review_text": "string"
     }
     ```
   - Response: 201 Created
6. 사용자 포인트 조회 API
   - Endpoint: GET /api/users/my/points
   - Request Header:
     - Authorization: Bearer {token}
   - Response: 200 OK
7. 지역별 미션 목록 조회 API
   - Endpoint: GET /api/missions/regions/{region_id}
   - Path Variable: region_id
   - Query Parameters:
     - status: "ongoing" | "completed"
   - Request Header:
     - Authorization: Bearer {token}
   - Response: 200 OK
8. 사용자 알림 조회 API
   - Endpoint: GET /api/users/my/notifications
   - Request Header:
     - Authorization: Bearer {token}
   - Response: 200 OK
