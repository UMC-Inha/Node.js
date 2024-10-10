## REST
### REST(Representational State Transfer)란?
자원을 이름으로 구분하여 해당 자원의 상태를 주고받는 모든것을 의미

1. HTTP URI(Uniform Resource Identifier) 를 통해 자원(Resource)를 명시하고
2. HTTP Method(POST, GET, PUT, PATCH, DELETE 등)을 통해
3. 해당 자원(URI)에 대한 CRUD Operation을 적용하는 것을 의미한다.

### CRUD Operation
소프트웨어가 가지는 기본적인 데이터 처리기능인 Create, Read, Update, Delete를 묶어서 부르는 것이며 아래의 HTTP Method는 다음과 같이 CRUD에 해당한다.
- Create : POST
- Read : GET
- Update : PUT, PATCH
- Delete : DELETE

### REST의 특징
1. Server-Client(서버-클라이언트 구조)
    - 자원을 가진 쪽이 Server, 자원을 요청하는 쪽이 Client가 된다

2. Stateless(무상태)
    - HTTP 프로토콜이 Stateless Protocol 이므로 REST도 Stateless를 갖는다.
    - Client의 Context를 서버에 저장하지 않는다.
        - 세션, 쿠키 같은 context정보를 신경쓰지 않아도 된다
    - Server는 Client의 각 요청을 완전 별개의 것으로 인식하고 처리한다.
        - Client가 이전에 어떤 요청을 했다고 해서 그 요청과 어떠한 연관성도 가지지 않는다.
        - Server의 처리방식에 일관성을 부여하고 부담이 줄어드며, 서비스의 자유도가 높아진다.

3. Cacheable(캐시 처리 가능)
    - HTTP 프로토콜을 그대로 사용하기 때문에 HTTP의 가장 강력한 특징 중 하나인 캐싱기능을 적용할 수 있다.
    - Last-Modified 태그나 E-Tag를 이용해 캐싱구현이 가능하다
    - 대량의 요청을 효율적으로 처리하기위해 캐시가 필요된다.
    - 캐시 사용을 통해 응답시간이 빨라지고 REST Server 트랜잭션이 발생하지 않아 응답시간, 성능, 서버의 자원이용률을 향상 시킨다.
    - 캐시 메모리 처럼 반복되는 요청에 대한 데이터는 임시로 저장하여 서버까지 가지않도록 하는 것이다.

4. Layered System(계층화)
    - Client는 REST API Server만 호출 한다
    - REST Server는 여러 계층으로 구성될 수 있다.
    - Proxy, gateway 같은 네트워크 기반의 중간 매체를 사용할 수 있다.

5. Uniformed Interface(인터페이스 일관성)
    - URI로 지정한 Resource에 대한 조작을 통일되고 한정적인 인터페이스로만 수행한다.
---

## REST API
### API란?
프로그램간의 데이터를 주고받을 수 있도록, 상호작용이 가능하도록 하는 것
- 예시 : 어떤 프로그램에서 지도 정보를 사용하기위해 카카오맵의 API를 사용한다

### REST API란?
REST 기반으로 서비스 API를 구현한 것

### REST API의 특징
- HTTP표준을 기반으로 구현하기 때문에, HTTP를 지원하는 프로그래밍 언어(자바, C#, 웹 등)로 서버-클라이언트를 구현할 수 있다.

### REST API 설계 기본 규칙
- 참고 리소스 원형
    - 도큐먼트 : 객체 인스턴스나 DB 레코드와 비슷한 개념, 컬렉션에 있는 구체적인 멤버를 지칭함
    - 컬렉션 : 서버에서 관리하는 directory resource
    - 스토어 : 클라이언트에서 관리하는 리소스 저장소, 클라이언트에 종속

1. URI는 정보의 자원을 표현해야 한다.
    - resource는 동사보다는 명사, 대문자 보다는 소문자 사용
    - resource의 도큐먼트 이름으로는 단수명사를 사용해야 한다.
        - GET items/1
    - resource의 컬렉션 이름으로는 복수명사를 사용해야 한다.
        - GET items
    - resource의 스토어 이름으로는 복수명사를 사용해야 한다.

2. 자원에 대한 행위는 HTTP Method로 표현한다.
    - URI에 HTTP method가 들어가선 안된다.
    - URI에 행위에 대한 동사표현이 들어가선 안된다.
    - 경로부분중 변하는 부분은 유일한(unique) 값으로 대체한다(Path variable)


### REST API 설계 규칙
1. 슬래시 구분자(/)는 계층 관계를 나타내는데 사용한다.
2. URI 마지막 문자로 슬래시(/)를 포함하지 않는다.
    - GET http://umc.com/users/missions/ (x)
3. 하이픈(-)은 URI 가독성을 높이는데 사용한다.
4. 언더스코어(_)는 URI에 사용하지 않는다.
5. URI 경로에는 소문자를 사용한다.(대소문자가 구별이 되므로)
6. 파일확장자는 URI에 포함하지 않는다.
    - REST API에서 메시지 바디 내용을 포맷을 나타내기 위한 파일 확장자를 URI안에 포함시키지 않는다.
    - Accept header를 사용한다.
7. 리소스 간에는 연관 관계가 있는 경우
    - /리소스명/리소스ID/관계가 있는 다른 리소스명
    - ex) GET /users/{userid}/devices 


---
## RESTful API
### RESTful 이란?
- REST 원리를 따르는 시스템을 RESTful 하다 라고 지칭한다

- RESTful한 API를 구현하는 근본적인 목적이 성능 향상에 있는 것이 아니라 일관적인 컨벤션을 통한 API의 이해도 및 호환성을 높이는 것이 주 동기이니, 성능이 중요한 상황에서는 굳이 RESTful한 API를 구현할 필요는 없다.
    


