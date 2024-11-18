- 미들웨어
    - 요청 오브젝트, 응답 오브젝트, 애플리케이션의 요청-응답 주기 중 그 다음의 미들웨어 함수 대한 액세스 권한을 갖는 함수임. 그 다음 미들웨어 함수는 일반적으로 next라는 변수로 표시됨.
    - 다음과 같은 미들웨어가 있음
        - 애플리케이션 레벨 미들웨어
        - 라운터 레벨 미들웨어
        - 오류 처리 미들웨어
        - 기본 제공 미들웨어
        - 써드파티 미들웨어
    - 애플리케이션 레벨 미들웨어 - app.use, app.METHOD() 함수를 이용해 애플리케이션 미들웨어를 앱 오브젝트의 인스턴스에 바인드할 수 있음.
        - 하나의 마운트 경로에 여러 미들웨어 함수들을 로드할 수 있음.
            
            ```jsx
            app.use('/user/:id', function(req, res, next) { //1번 함수
              console.log('Request URL:', req.originalUrl);
              next();
            }, function (req, res, next) { //2번 함수. 순차적으로 실행됨.
              console.log('Request Type:', req.method);
              next();
            });
            
            ```
            
        - 라우트 핸들러를 이용하면 하나의 경로에 대해 여러 라우트를 정의할 수 있음. 나머지 미들웨어 함수를 건너뛰려면 next(’route’)를 호출하면 됨.
            
            ```jsx
            app.get('/user/:id', function (req, res, next) {
              // if the user ID is 0, skip to the next route
              if (req.params.id == 0) next('route');
              // otherwise pass the control to the next middleware function in this stack
              else next(); //
            }, function (req, res, next) {
              // render a regular page
              res.render('regular');
            });
            
            // handler for the /user/:id path, which renders a special page
            app.get('/user/:id', function (req, res, next) {
              res.render('special');
            });
            ```
            
    - 라우터 레벨 미들웨어 - express.Router() 인스턴스에 바운드 됨. 애플리케이션 미들웨어와 상당히 유사함.
        
        ```jsx
        var app = express();
        var router = express.Router();
        
        // a middleware function with no mount path. This code is executed for every request to the router
        router.use(function (req, res, next) {
          console.log('Time:', Date.now());
          next();
        });
        
        // a middleware sub-stack shows request info for any type of HTTP request to the /user/:id path
        router.use('/user/:id', function(req, res, next) {
          console.log('Request URL:', req.originalUrl);
          next();
        }, function (req, res, next) {
          console.log('Request Type:', req.method);
          next();
        });
        
        // a middleware sub-stack that handles GET requests to the /user/:id path
        router.get('/user/:id', function (req, res, next) {
          // if the user ID is 0, skip to the next router
          if (req.params.id == 0) next('route');
          // otherwise pass control to the next middleware function in this stack
          else next(); //
        }, function (req, res, next) {
          // render a regular page
          res.render('regular');
        });
        
        // handler for the /user/:id path, which renders a special page
        router.get('/user/:id', function (req, res, next) {
          console.log(req.params.id);
          res.render('special');
        });
        
        // mount the router on the app
        app.use('/', router);
        ```
        
    - 오류 처리 미들웨어 - 4개의 인수(err, req, res, next)를 가짐.
        
        ```jsx
        app.use(function(err, req, res, next) {
          console.error(err.stack);
          res.status(500).send('Something broke!');
        });
        ```
        
- HTTP 상태 코드
    
    
    | 상태코드 | 상태 텍스트 | 의미 |
    | --- | --- | --- |
    | 100 | continue | 계속 진행 |
    | 101 | Switching Protocols | 프로토콜 전환 |
    | 102 | Processing | 처리 중(타임 아웃 발생 방지) |
    | 200 | OK | 요청 처리 성공 |
    | 201 | Created | 요청 처리 후 새로운 리소스 생성 |
    | 202 | Accepted | 요청은 접수되었으나 처리 미완료 |
    | 203 | Non-
    Authorative
    Information | 응답 헤더가 오리지널 서버로부터 제공되지 않음. 신뢰할 수 없는 정보 |
    | 204 | No Content | 처리 후 돌려줄 콘텐츠가 없음. |
    | 206 | Partial Content | 콘텐츠 일부만 전송 |
    | 207 | Multi-Status | 처리 결과의 스테이터스가 여러 개이다. |
    | 300 | Multiple Choices | 선택 항목이 여러 개 있음 |
    | 301 | Moved Permanently | 지정한 리소스가 새 URL로 이동 |
    | 302 | Found | 요청한 리소스를 다른 URL에서 찾음 |
    | 303 | See Other | 다른 위치로 요청 |
    | 304 | Not Modified | 수정되지 않음 |
    | 305 | Use Proxy | 리소스에 액세스하려면 프록시를 이용해야 함. |
    | 400 | Bad Request | 잘못된 요청 |
    | 401 | Unauthorized | 권한 없음 |
    | 402 | Payment Required | 결재 필요 |
    | 403 | Forbidden | 액세스 금지됨 |
    | 404 | Not Found | 리소스를 찾을 수 없음 |
    | 405 | Method Not Allowed | 지정한 메소드를 지원하지 않음 |
    | 406 | Not Acceptable | 클라이언트가 지정한 항목에 처리할 수 없음 |
    | 407 | Proxy
    Authentication
    Required | 클라이언트는 프록시 서버에 인증이 필요함 |
    | 408 | Request Timeout | 요청 시간초과 |
    | 409 | Conflict | 충돌 발생 |
    | 410 | Gone | 리소스가 사라짐 |
    | 411 | Length Required | 요청 헤더에 Content-Length 지정 |
    | 412 | Precondition Failed | 사전 조건이 서버와 일치하지 않음 |
    | 413 | Request Entity Too Large | 요청 메시지가 너무 큼 |
    | 414 | Reques-URI Too Large | 요청 URI가 너무 긺 |
    | 415 | Unsupported Media Type | 지원되지 않는 미디어 형식 |
    | 416 | Range Not Satisfiable | 처리할 수 없는 요청 범위 |
    | 417 | Expectation Failed | 클라이언트의 Expect 헤더를 인식 불가능 |
    | 422 | Unprocessable Entity | 클라이언트의 XML의 의미에 오류 있음 |
    | 423 | Locked | 리소스가 잠겨있음 |
    | 424 | Failed Dependency | 다른 작업 실패로 본 작업 실패 |
    | 426 | Upgrade Required | 클라이언트 프로토콜 업그레이드 필요 |
    | 428 | Precondition Required | 사전조건 지정 헤더 필요 |
    | 429 | Too Many Requests | 너무 많은 요청 |
    | 431 | Request Header Fields Too Large | 헤더의 길이가 너무 큼 |
    | 444 | Connection Closed
    Without Response | 응답 없이 연결 닫음 |
    | 451 | Unavailable For Legal Reasons | 법적 사유로 불가 |
    | 500 | Internal Server Error | 내부 서버 오류 |
    | 501 | Not Implemented | 구현되지 않음 |
    | 502 | Bad Gateway | 게이트웨이 또는 프록시 서버가 잘못된 응답을 받음 |
    | 503 | Service Unavailable | 현재 서버에서 서비스 불가 |
    | 504 | Gateway Timeout | 게이트웨이 또는 프록시 서버가 응답을 기다리다 타임아웃 발생 |
    | 505 | HTTP Version Not Supported | 클라이언트가 요청에 사용한 HTTP 버전을 지원하지 않음 |
    | 507 | Insufficient Storage | 서버 저장 공간 부족 |