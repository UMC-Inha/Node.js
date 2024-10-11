### 🎯 핵심 키워드
---
1. **Rest(REpresentational State Transfer)**
    - 웹 서비스가 어떻게 동작해야 하는지에 대한 아키텍처 스타일(설계 원칙)
    - 클라이언트와 서버 간의 상호작용을 규정하며 여러 원칙과 제약 조건들을 가지고 있다.
2. **Restful API**
    - REST 아키텍처 스타일을 따르는 웹 API
    > 💡 **REST vs RESTful API**<br/>
    > REST: 이론적 원칙과 가이드 라인<br/>
    RESTful API: REST 원칙 및 가이드라인을 실제로 적용(구현)한 API
3. **HTTP 응답 상태 코드**
    - 200: OK , 요청이 성공적으로 처리되었다.
    - 201: Created, 요청이 성공적으로 처리되었으며 서버에서 새로운 리소스가 생성되었다.
    - 400: Bad Request, 클라이언트가 보낸 요청이 잘못되었거나 서버가 요청을 처리할 수 없을 정도로 문제가 있다.
    - 401: Unauthorized, 인증이 필요한 리소스에 대해 인증되지 않은 사용자가 접근하였다.
    - 404: Not Found, 클라이언트가 요청한 리소스를 서버에서 찾을 수 없다.
    - 500: Internal Server Error, 서버 내부에서 예상치 못한 오류가 발생하였다.
4. **Request Body (요청 본문)**
    - 클라이언트가 서버로 데이터를 전송할 때 해당 데이터를 포함하는 부분
    - 주로 POST, PUT, PATCH 메서드에서 사용되며 클라이언트가 서버에 전달하고자 하는 정보를 담고 있다.
    - ex. 회원가입 요청 시 사용자의 정보(이름, 전화번호 등과 같은 데이터)를 서버로 보내기 위해 JSON 형태로 Request Body에 포함한다.
        ```json
         {
        	 "name": "string",
        	 "phoneNumber": "string",
        	 "email": "string",
         }
        ```
5. **Request Header (요청 헤더)**
    - 클라이언트가 서버에 요청을 보낼 때 요청 자체에 대한 추가적인 정보(클라이언트 정보, 인증 정보 등과 같은 메타데이터)를 담는 부분
    - 서버가 데이터를 어떤 형식으로 받아야 할지, 사용자의 인증 상태가 어떤지 등을 전달한다.
    - 주요 헤더
        - Content-Type
            - 클라이언트가 서버로 보내는 데이터의 형식
            - JSON 형식으로 데이터 전송 시 → application/json 사용
            - HTML 문서 전송 시 → text/html 사용
            - ex. 회원가입(사용자 생성)을 할 경우
                ```json
                POST /members
                Content-Type: application/json
                ```
        - Authorization
            - 서버에 인증 정보를 전달하는 헤더
            - 주로 Bearer 토큰을 사용하여 사용자 인증을 수행한다.
                - ex. OAuth 2.0에서 Bearer 토큰을 통해 엑세스 토큰을 전달한다.
            - ex. 특정 사용자의 정보를 조회할 경우
                ```json
                GET /members/1
                Authorization: Bearer adkjhlKgaAdJIHKJHKhkjKRTYvhkHFYHGFt...
                ```
        - User-Agent
            - 요청을 보내는 클라이언트의 정보(브라우저, OS 등)
6. **Access Token**
    - 사용자가 인증을 완료한 후, 서버로부터 발급받아 클라이언트와 서버 간에 요청을 보낼 때 사용되는 임시적인 인증 정보
    - 이 토큰은 일정 시간이 지나면 만료되며, 서버는 이 토큰을 통해 사용자의 신원을 확인한다.
    - ex. 사용자가 로그인하면 서버로부터 액세스 토큰을 발급받는다.
7. **Bearer Token** 
    - 액세스 토큰을 HTTP 요청의 Authorization 헤더에 포함하여 서버에 전달하는 방식
    - 서버는 이 토큰을 통해 요청한 사용자가 인증된 상태인지 확인한다.
    - ex. 로그인 이후 사용자는 API 요청을 할 때마다 발급받은 엑세스 토큰을 Bearer 방식으로 헤더에 추가해 서버에 전송한다.
8. **Response Body (응답 본문)**
    - 서버가 클라이언트로 보낸 요청을 처리한 후, 결과 데이터를 담아 응답할 때 사용하는 부분
    - 클라이언트가 요청한 리소스나 처리 결과를 Response Body에 포함하여 보낸다.
    - 주로 JSON, XML, HTML 형식의 데이터를 전송합니다.
        ```json
        {
        	"message": "로그인 성공",
        	"token": "adkjhlKgaAdJIHKJHKhkjKRTYvhkHFYHGFt..."
        }
        ```
        - 여기서 반환된 token은 사용자의 인증 상태를 나타내는 엑세스 토큰이다.
9. **Parameter(매개변수)**
    - 클라이언트가 서버에 요청할 때, 추가적인 데이터나 필터링 정보를 전달하는 방법
    - Path Variable,  Query String, Request Header, Request Body에 포함될 수 있다.
    - ex. 특정 사용자의 프로필을 조회할 경우
        ```json
        GET /memberss/1/profile
        ```
        - 사용자 ID인 1을 경로 매개변수로 전달하였다.

### 📦 실습
---
1. localhost:3000 접속 화면
    ![images/실습1-hello-world.png](images/실습1-hello-world.png)
    - Express 공식 예제를 ES Module 방식으로 바꾸어 실행해주었다.
1. package.json의 scripts에 npm install --save-dev nodemon 추가
    ![images/실습2-nodemon.png](images/실습2-nodemon.png)
    - 프로젝트를 수정하고 저장할 때마다 서버를 자동으로 재시작하게 만들어 주었다.

**⚡ 작은 트러블 슈팅**
1. **이슈**<br/>
    프로젝트 중 기존에 설치해둔 node, npm 버전이 각각 20.16.0, 10.8.3인 걸 확인한 후 워크북에 명시된 대로 “npm install express@^5.0.0-0”을 입력해 express@^5.0.0-0을 설치하려 했는데 사진과 같은 에러가 발생하며 설치에 실패했다.
    ![images/트러블슈팅-에러.png](images/트러블슈팅-에러.png)
2. **문제 & 해결**
    ![images/트러블슈팅-문제탐색-1.png](images/트러블슈팅-문제탐색-1.png)
    검색을 해보았더니 한 사이트에서 express@5.x는 아직 정식 릴리스된 게 아니어서 해당 에러가 발생한 것이라는 글을 보았지만 npm 홈페이지에서 5.x 버전이 정식 릴리즈 된 것을 확인하였다.
    ![images/트러블슈팅-문제탐색-2.png](images/트러블슈팅-문제탐색-2.png)
    ![images/트러블슈팅-문제해결.png](images/트러블슈팅-문제해결.png)
    그래서 express@^5.0.0-0이 아닌 express@5.0.0(npm 홈페이지에 나와있었음)을 설치해보았더니 성공적으로 설치가 되었다. 버전 끝에 “-0”이 붙느냐의 차이었고 찾아보니 “-0”는 프리릴리즈(pre-release) 태그를 나타내며 일반적으로 버전 뒤에 붙는 -0 태그는 해당 패키지가 아직 정식 릴리즈가 아닌 개발 버전임을 의미한다고 한다. 즉, express@5.0.0-0는 5.0.0 정식 버전이 나오기 전에 배포된 테스트 버전인 것이다. 워크북이 만들어질 당시에는 5.0.0이 프리릴리즈였나 보다. 
