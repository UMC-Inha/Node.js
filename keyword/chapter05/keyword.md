### 환경변수

- 정의 : 프로세스가 컴퓨터에서 동작하는 방식에 영향을 미치는 동적인 값들의 모임

- 위 내용이 백과사전에 나온 환경변수에 대한 정의이며 노드작업에서의 환경변수의 의미는 웹 서버가 동작하는 코드 혹은 자바스크립트 코드는 실행환경에 관계없이 일정하게 각자의 환경에서 동작하려면 같아야한다. 하지만 코드는 같더라도 개개인의 시스템마다 실행환경이 다를 수 있는데 이러한 환경에 대한 정보를 담는 변수를 환경변수라고 하며 이는 프로그램의 종속되는 변수가 아닌 시스템에 종속되는 변수라고 생각하면 된다.

- 예를들어 DB에서 데이터를 가져오기 위한 repository 내에서의 자바스크립트 코드, SQL 코드는 같을지라도 어떤 DB에서 가져오느냐는 시스템마다 다르다 이를 시스템마다 정해줘야 하며 이부분은 개인적인 시스템의 대한 정보이기 때문에 gitHub와 같은 오픈소스로 올리면 보안 문제가 발생할 가능성이 매우크다

##

### CORS(Cross Origin Resource Sharing)
    - 브라우저의 경우 기본적으로 SOP 정책을 따른다
    - 이는 '같은 출처에서만 리소스를 공유가 가능하다'를 가진 규칙이다.
    - 이 때문에 브라우저는 같은 출처에서만 리소스를 공유가 가능한데 실제 개발을 하다보면 다른 출처의 API 서버를 두거나, 다른 출처의 외부 리소스를 가져다 쓰는 경우가 있다.
    - 다른 출처에 대한 리소스 공유를 허락하도록 하는 것이 CORS이다.

    - CORS란? 도메인이 다른 서버끼리 리소스를 주고 받을 때 보안을 위해 설정된 정책이다.

    - 예를 들어 어떤 A라는 웹사이트에서 B라는 서버로 부터 데이터를 가져오려고 할 때 서버 B에서 CORS 허용설정이 안되어 있으면 해당 웹 브라우저에서 API 접근이 거부 될 수 있다.

    - 같은 출처와 다른 출처를 구분하는 건 아래와 같다
    ```
    https://domain/path/...
    ```
    위와 같은 도메인주소가 있을 때 protocol, domain(host), port번호 위 3개가 일치했을 때 같은 출처(same-origin)인것이고 3개중에 하나 이상이 다르다면 이는 서로 다른 출처(cross-origin)인것이다.

    - 이러한 출처를 비교하는 로직은 서버가 아닌 브라우저에 구현되어있다. 그래서 브라우저가 api서버에 요청을 보내면 api 서버는 요청에 대한 응답을 보내지만 그걸 받은 브라우저는 서버로 부터 받은 데이터의 출처가 자신의 브라우저와 다른 출처이기 때문에 이를 버리게 된다.

    - 즉 서버는 CORS 정책이 위반되어도 응답을 정상적으로 해주나 그 응답을 파기할지 말지 결정하는 건 브라우저의 몫인 셈이다.

#### CORS의 동작원리

    - 웹 클라이언트에서 다른 출처의 리소스를 요청시 HTTP 프로토콜을 사용하여 요청을 보내게 되고, 브라우저는 요청헤더에 Origin 이라는 필드에 요청을 보내는 출처를 함께 보내준다

    - 이후 서버가 이 요청을 받고 응답할 때 응답헤더에 Access-Control-Allow-Origin 이라는 값에 "이 리소스를 접근하는 것이 허용된 출처"를 내려주고 응답을 받은 브라우저가 자신이 보냈던 요청의 Origin과 서버가 보내준 Access-Control-Allow-Origin 을 비교한후 이 응답이 유효한지 아닌지를 결정한다.

#### CORS의 3가지 동작시나리오
    1. Simple request
        - CORS 상황이 발생 할 때 해당 요청이 Simple request라면 브라우저는 CORS 정책검사를 실시하지 않는다.
        - Simple request의 경우는 다음과 같다
            1. 요청 메소드는 GET, HEAD, POST 중 하나이어야 한다
            2. Request Header에는 다음 속성만이 허용된다.
                - Accept, Accept-Language, Content-Language, Content-Type, DPR, Downlink, Save-Data, Viewport-Width, Width
            3. Content-type을 사용하는 경우에는 다음 값만이 허용된다.
                - application/x-www-form-urlencoded, multipart/form-data, text/plain
            4. 요청에 사용된 XMLHttpRequestUpload 객체에는 이벤트 리스너가 등록되어있지 않다. 이들은 XMLHttpRequest.upload 프로퍼티를 사용하여 접근한다.
            5. 요청에 ReadableStream 객체가 사용되지 않는다.
    
        - 일반적으로 웹 어플리케이션 개발을 할 때 대부분의 HTTP API는 text/xml 이나 application/json 의 Content-type을 가지기 때문에 simple request의 상황으로 보기는 어렵다.

        - 또한 위 헤더들 뿐만아니라 추가적인 헤더들 예를들어 Authorization과 같은 인증 토큰에 대한 헤더를 사용하면 simple request가 아니기 때문에 이경우는 거의 드물다고 보면된다.

    2. preflight request
        - 웹 어플리케이션을 개발할 때 가장 흔히 마주치는 시나리오이며 이 때는 브라우저가 요청을 한번에 보내지 않고 예비요청 / 본요청으로 나누어서 서버에 전송한다.

        - 요청이 simple-request가 아니라면 브라우저는 서버에 preflight request(예비요청)을 보낸다.
        
        - 예비요청에는 HTTP 메소드중 OPTIONS 메소드가 사용하며 이 역할은 본 요청을 보내기 전에 브라우저 스스로 이 요청을 보내는 것이 안전한지 확인하는 것이다.

        - OPTIONS 요청을 받은 서버는 응답 헤더에 서버가 허용할 옵션을 설정하여 브라우저에게 전달한다.
            - 예를들어 응답헤더에 Access-Control-Allow-Origin이라는 항목을 추가하여 허용할 도메인을 지정할 수 있다
        
        - 브라우저는 서버가 보낸 예비요청에 대한 응답정보를 이용하여 허용되지 않은 요청이면 405에러를 발생시키고 본 요청은 서버로 전달하지 않는다. 반대로 허용되는 요청이면 본 요청을 보낸다.

    3. Credential Request
        - 이 시나리오는 헤더에 인증과 관련된 정보(쿠키, 토큰)을 담아서 보내는 인증된 요청을 사용하는 방법이다.

        - 요청에 인증과 관련된 정보가 담기게 되면 Credentialed Request 허용이 되어야한다. 즉, 인증과 관련된 정보를 담을 수 있게 해주는 옵션 'credential'을 줘야하는데, 이 때 서버쪽에서 응답헤더에 Access-Control-Allow-Credential: true를 보내주지 않으면 브라우저에서 응답을 받는 것을 거부하게 된다.

        - 이 credential 옵션에는 3가지의 값이 사용될 수 있는데 
            1. same-origin(기본값) : 같은 출처 간 요청에만 인증정보를 담을 수 있다.

            2. include : 모든 요청에 인증 정보를 담을 수 있다.

            3. omit : 모든 요청에 인증 정보를 담지 않는다.

        - 만약 same-origin이나 include 의 옵션을 사용하여 리소스 요청에 인증정보가 포함되면, 브라우저는 다른 출처의 리소스를 요청할 때 단순히 Access-Control-Allow-Origin만 확인하는 것이 아니라 더 빡빡한 검사 조건을 추가하게된다.

        - 요청에 인증정보가 담겨있는 상태에서 다른 출처의 리소스를 요청하게 되면 브라우저는 CORS 정책위반 여부를 검사하는 로직에 다음 2가지를 추가하게 된다.
            1. Access-Control-Allow-Origin에는 *를 사용할 수 없으며 명시적인 URL이어야한다.

            2. 응답 헤더에는 반드시 Access-Control-Allow-Credential: true 가 존재해야한다.




##

### DB Connection, DB Connection Pool

- 웹 서버에서 DB를 접근할 때 무수히 많은요청을 전부 백그라운드에서 실행 하게 되면 서버자체 성능이 매우 안좋아지게 되는데 그래서 DB 접근이 가능한 커넥션의 개수를 제한해서 최대한 서버의 성능을 일정하게 유지하게 하는 기능이다.

- 커넥션의 개수는 설정이 가능하며 최대 커넥션의 수를 넘어가게되면 요청을 대기하는 큐에 넣어두다가 커넥션의 수가 줄면 대기 큐에있던 요청이 들어가는 방식이 connection방식이다.

- 서버는 각 DB에서 가져올수 있는 여러 커넥션을 관리하는 객체를 Pool이라는 것을 사용하며 Pool을 통해 연결하고자 하는 커넥션을 받아주고 해당 커넥션이 DB접근을 완료하면 다른 커넥션이 사용가능하게 release를 해주는 기능을 갖고있다.

##

### async/await
- 비동기란?
    - 동시에 일어나지 않는다는 의미를 가지며 프로그래밍에서의 비동기는 작업이 순차적으로가 아닌 독립적으로 실행이 되며 어떤 작업이 완료여부와 상관없이 다른 작업을 실행 할 수 있음을 의미합니다.
    
- 동기/비동기, 블로킹/논블로킹
    - 두 범주의 용어가 노드에서는 혼용되다시피 하는데 용어가 다른만큼 차이가 있다
    - 동기/비동기 : 백그라운드 작업 완료 확인 여부에 대한 용어로 동기는 백그라운드 작업이 완료가 되어야 다음 작업이 진행되는 순차형식을 띤다면 비동기는 백그라운드에서 어떤 작업이 끝나는지에 대한 여부와는 상관없이 여러 작업이 백그라운드에서 동시에 작업이 이뤄진다.
    - 블로킹/논블로킹 : 함수가 바로 return 되는지에 대한 여부를 구분하는 용어로 블로킹은 함수가 바로 return되지않고 함수내의 모든 일을 처리해야 return이 되기 때문에 다음으로 넘어 갈수 없지만 논블로킹은 함수가 실행되면 해당 함수가 백그라운드로 넘어가고 바로 함수 콜스택에서 리턴이 되기 때문에 다른 코드가 바로 실행이 가능하다.

- 노드에서는 동기-블로킹 혹은 비동기-논블로킹 방식이 대부분이며 동기-논블로킹, 비동기-블로킹 방식은 없다고 보면 된다.

- 동기-블로킹 : 백그라운드 작업 완료 여부를 계속 확인 하며, 호출한 함수가 바로 return 되지 않고 백그라운드 작업이 끝나야 return을 한다.

- 비동기-논블로킹 : 호출한 함수가 바로 return 되어 다음 작업으로 넘어가고 백그라운드 작업완료 여부는 신경쓰지않고 나중에 백그라운드가 알림을 줄 때 처리한다.



- 노드에서 비동기 프로그래밍을 할 때 사용하는 것으로 이전의 Promise가 콜백지옥을 해결 해주었지만 Promise를 사용해도 여전히 코드자체의 길이가 너무 길다
- 왜냐하면 then~catch~finally 문이 계속 반복되기 때문이다. 이를 좀더 간단하게 줄인 것이 async/await 문법이다.

    - 아래의 코드는 Promise를 활용한 코드이다.
    ```
    function findAndSaveUser(Users) {
      Users.findOne({})
        .then((user) => {
          user.name = 'zero';
          return user.save();
        })
        .then((user) => {
          return Users.findOne({gender: 'm'});
        })
        .then((user) => {
          // 생략
        })

        .catch((err) => {
          console.error(err);
        });
    }
    ```

    - 다음의 코드는 위의 프로미스 코드를 async/await로 바꾼것이다.
    ```
    async function findAndSaveUser(Users){
        let user = await Users.findOne({});
        user.name = 'zero';
        user = await user.save();
        user = await Users.findOne({gender: 'm'});
        // 생략
    }
    ```
    - 이처럼 더욱 간결해진걸 볼 수 있다. 함수 선언부를 async로 바꾸었고 프로미스 앞에 await를 붙인걸 알 수 있다. 이 함수는 해당 프로미스 resolve 될 때 까지 기다렸다가 resolve 되면 다음으로 넘어간다.

    - 그러나 위에서는 에러처리를 해주지않았기에 에러처리를 하려면 다음과 같이 진행 하면된다.

    ```
    try {
        async function findAndSaveUser(Users){
        let user = await Users.findOne({});
        user.name = 'zero';
        user = await user.save();
        user = await Users.findOne({gender: 'm'});
        // 생략
        }
    }
    catch (error){
        console.error(error);
    }
    ```

    - 이렇게 try/catch 문으로 감싸주면 된다.

    - 앞으로 중첩되는 콜백함수가 있다면 이를 Promise를 거쳐 async/await 문법을 사용해보자 그러면 코드가 훨씬 간결해진다.

##

### try/catch/finally

  - 에러처리를 위한 구문으로 
    ```
    try{

    }catch(e){

    }finally{

    }
    ```
    위의 문법으로 이루어지며 try 에서는 에러가 발생가능한 로직이 실행이 되며 노드에서는 await, promise 객체가 있는 함수를 try문 안에서 처리한다.
    catch에서는 await 함수에서의 에러나 promise 객체에서 reject에 담긴 에러를 잡아 에러처리를 진행 시키고
    finally는 try문 혹은 catch문이 전부 진행되면 finally를 통해 무조건 실행 하도록 한다.

    위의 예를 간단히 말하자면 try문 내에서 DB 접속에 관한 await 함수를 실행 시켜주고 DB 접속에 문제가 있다(예를들어 커넥션이 전부 쓰여서 접속이 불가한 경우 등)면 이를 catch 문에서 에러 처리를 해주고 finally에서는 커넥션을 놔주는 release작업을 진행해주면 된다.



