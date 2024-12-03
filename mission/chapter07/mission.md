## error.js

Error 클래스 생성

![alt text](error_js.png)

각 Repository 단에서 에러 발생시 에러 객체 생성

## User Repository

- 유저 생성시 에러처리

![alt text](addUser_error.png)

- 유저 조회시 에러처리

![alt text](getUser_error.png)

- 선호음식 설정시 에러처리

![alt text](setPreference_error.png)

- 선호음식 조회시 에러처리

![alt text](getPreference_error.png)

### add_user api 결과

- 성공시 모습

![alt text](add_user_api_result_success.png)

- 이메일이 이미 존재 하는 경우

![alt text](add_user_api_result_fail.png)
상태코드도 400 Bad Request로 처리하였다.


## Store Repository

- 가게 생성시 에러처리

![alt text](add_store_error.png)

- 가게 조회시 에러처리

![alt text](get_store_error.png)

### add_store api 결과

- 성공시 모습

![alt text](add_store_api_result_success.png)

- 없는 location_id를 body로 넘겨 주었을 때

![alt text](add_store_api_result_fail.png)

이 경우 아쉬운 점은 body로 잘못된 값으로 요청을 할 때 DB오류로 내보내고있다.
이보다는 해당 body를 DTO로 감싸 service에 제공하기전에 유효성 검사를 통해 DTO에서 에러처리를 한다면 더 좋을 것 같다.


## Review Repository

- 리뷰 생성시 에러처리

![alt text](add_review_error.png)

- 리뷰 조회시 에러처리

![alt text](get_review_error.png)

- 특정 가게의 리뷰 조회시 에러처리

![alt text](get_review_store_error.png)

- 특정 유저의 리뷰 조회시 에러처리

![alt text](get_review_user_error.png)

### add_review api 결과

- 성공시 모습

![alt text](add_review_api_result_success.png)
HTTP 상태코드도 201 CREATED로 잘 되어있다.

- 실패시 모습(없는 유저로 등록 할 때)

![alt text](add_review_api_result_fail.png)
이 경우도 위처럼 Bad Request처리를 DTO 에서 하면 좋을 것같다.
아니면 Repository에서 체크를 해도 될것같긴하다.

### get_reviews_from_store api 결과

- 성공시 모습

![alt text](get_review_store_api_success.png)

- 실패시 모습(없는 가게의 리뷰조회)

![alt text](get_review_store_api_fail.png)

이 경우는 사실 17번 가게 자체가 없고 그러므로 그에 해당하는 리뷰도 당연히 없으니까 404 NOT FOUND를 내보내고있다
엄밀하게는 17번이 없기 때문에 Bad request를 내는것이 맞고 어떤 가게가 존재하지만 리뷰가 하나도 없을 때 404 NOT FOUND를 내는 것이 맞는 것 같다.

### get_reviews_from_user api 결과

- 성공시 모습

![alt text](get_review_user_api_success.png)

- 실패시 모습(없는 유저의 리뷰조회)

![alt text](get_review_user_api_fail.png)
이 경우도 위와 마찬가지로 15번 유저 자체가 DB상에 없으므로 Bad Request 를 내보내는 것이 맞고 15번 유저가 있지만 그 유저가 쓴 리뷰자체가 없을 때 404 Not Found를 내보내는 것이 맞는 것같다.


## Mission Repository

- 미션 생성시 에러처리

![alt text](add_mission_error.png)

- 미션 조회시 에러처리

![alt text](get_mission_error.png)

- 미션 도전시 에러처리

![alt text](try_mission_error.png)

- 특정 유저의 미션 조회시 에러처리

![alt text](get_mission_user_error.png)

- 특정 가게의 미션 조회시 에러처리

![alt text](get_mission_store_error.png)


### add_mission api 결과

- 성공시 모습

![alt text](add_mission_result_success.png)

- 실패시 모습(없는 가게로 미션추가)

![alt text](add_mission_result_fail.png)
이 경우도 먼저 가게가 있는지 에러처리를 해주는게 좋은거 같다.


### try_mission api 결과

- 성공시 모습

![alt text](try_mission_api_result_success.png)

- 실패시 모습(이미 도전중일 때)

![alt text](try_mission_api_result_fail.png)
잘못된 요청이므로 Bad Request를 내보내고 있다.


### get_store_missions api 결과

- 성공시 모습

![alt text](get_store_missions_api_result_success.png)

- 실패시 모습(아무런 미션이 없을 때)

![alt text](get_store_missions_api_result_fail.png)


### get_user_missions api 결과

- 성공시 모습(해당유저의 모든 미션 조회)

![alt text](get_user_missions_api_result_success_1.png)

- 성공시 모습(해당 유저의 도전중인 미션만 조회)

![alt text](get_user_missions_api_result_success_2.png)

- 실패시 모습(없는 유저에 대한 미션 조회)

![alt text](get_user_missions_api_result_fail.png)
이 경우도 유저자체가 없기 때문에 유저가 있는지 파악하는 함수에서 Bad request를 요청하는 것이 좋을 것같다.


## 깃허브 링크
https://github.com/GodUser1005/UMC-7th-Nodejs/tree/feature/mission-07






