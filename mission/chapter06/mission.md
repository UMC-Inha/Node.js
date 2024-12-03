## 각 api 마다 이슈 생성
![alt text](이슈생성.png)

## 내가 작성한 리뷰 목록 구현하기

### 이슈
![alt text](<6번 이슈 및 브랜치 생성.png>)

### Controller
![alt text](6_controller.png)

### Service
![alt text](6_service.png)

### Repository
![alt text](6_repository.png) 

### DTO
![alt text](6_dto.png)

### 결과

#### 초기 데이터
아래는 리뷰에 대한 데이터이다.
![alt text](6_init_data.png)
11번 유저가 13번 가게에 3개의 리뷰를 남겼다.
12번 유저가 13번 가게에 1개의 리뷰를 남겼다.

#### Postman 실행 결과

아래는 성공 했을때의 모습
![alt text](6_result.png)

없는 유저를 입력했을 때
![alt text](6_result_fail.png)



## 특정 가게의 미션 목록 구현하기

### 이슈
![alt text](<7번 이슈 및 브랜치 생성.png>)

### Controller
![alt text](7_controller.png)

### Service
![alt text](7_service.png)

### Repository
![alt text](7_repository.png)

### DTO
![alt text](7_dto.png)

### 결과

#### 초기 데이터
아래는 미션에 대한 데이터이다.
![alt text](7_init_data.png)
13번 가게의 미션이 여러개 있다.


#### Postman 실행 결과
아래는 성공 했을 때의 모습이다.
![alt text](7_result.png)

아래는 없는 가게의 미션을 가져오려할 때의 모습이다.
![alt text](7_result_fail.png)



## 내가 진행중인 미션목록 구현하기

### 이슈
![alt text](<8번 이슈 및 브랜치 생성.png>)

### Controller
![alt text](8_controller.png)

### Service
![alt text](8_service.png)

### Repository
![alt text](8_repository.png)

### DTO
![alt text](8_dto.png)

### 결과

#### 초기 데이터
아래는 미션에 대한 데이터이다.
![alt text](8_init_data.png)

현재 12번 유저가 4번 미션을 진행하고있으며(1) 11번 미션은 이미 완료한 상태이다(2)

#### Postman 실행 결과

아래는 12번 유저의 진행중인 미션을 불러왔다.
![alt text](8_result_1.png)
쿼리스트링으로 status=ongoing을 주었다.

아래는 아무런 쿼리를 주지않았을 때이며 유저의 모든 미션을 보여준다.
![alt text](8_result_2.png)

없는 유저를 입력했을 때는 다음과 같다.
![alt text](8_result_fail.png)


## 진행중인 미션을 미션완료로 바꾸기



#### 깃허브 레포지토리
https://github.com/GodUser1005/UMC-7th-Nodejs/tree/feature/mission-06