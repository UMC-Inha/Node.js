- ORM
    - Object Relational Mapping - 객체로 연결은 해준다 - 어플리케이션과 데이터베이스 연결 시 SQL 언어가 아닌 어플리케이션 개발언어로 데이터베이스를 접근할 수 있게 해주는 툴이다.
    - SQL 대신 어플리케이션의 개발언어를 그대로 사용할 수 있음. 일관성과 가독성을 올려줌.
    - Django - ORM cookbook, Node.js - Sequalize, Java - Hibernate, JPA 등이 있음
- Prisma 문서 살펴보기
    - 프리즈마 - 오픈소스 ORM. 크게 다음과 같은 기능들이 있음
        - Prisma Client - Node.js와 TypeScript에서 사용가능한 쿼리빌더
        - Prisma Migrate - 마이그레이션 시스템
        - Prisma Studio - 데이터베이스 관리할 수 있는 GUI
    - Prisma schema - 어플리케이션 모델을 직관적인 데이터 모델 언어로 표현 가능함. 데이터베이스 연결과 클라이언트 생성을 관리할 수 있다.
    - ex. Prisma의 Connection Pool 관리 방법
        - 프리즈마 클라이언트가 데이터베이스에 첫 커넥션을 하는 순간 풀이 생성됨. - connect() 함수를 호출하거나 쿼리문을 실행(자동으로 connect()호출)하면 됨.
        - 풀에는 접속 제한과 제한 시간이 정해져 있음.
        - connection limit(접속 제한)은 기본값이 (하드웨어의 cpu 개수)*2 + 1이다. 바꾸려면 데이터베이스 접속 URL 파라미터에 데이터를 입력해야 한다.
        
        ```jsx
        datasource db {
          provider = "postgresql"
          url      = "postgresql://johndoe:mypassword@localhost:5432/mydb?connection_limit=5"
        }
        ```
        
        - time out(제한 시간)은 기본값이 10초이다. 이 시간동안 데이터베이스와 성공적인 통신이 되지 않으면 예외를 발생시킨다. 이것도 파라미커에 값을 넣어서 설정 가능하다.
        - 아예 0으로 만들면 timeout을 없앨 수도 있다. 큰 데이터값(오래 걸리는 값)을 불러 올 때 사용한다.
        
        ```jsx
        datasource db {
          provider = "postgresql"
          url      = "postgresql://johndoe:mypassword@localhost:5432/mydb?connection_limit=5&pool_timeout=2"
        }
        ```
        
    - ex. Prisma의 Migration 관리 방법
        - Migration - 데이터베이스 스키마의 구조를 수정하고 진화시키는 변경 사항 집합. 데이터베이스 스키마를 업데이트하는 데 도움이 됨. 테이블 열 추가 변경, 제약 조건등을 정할 수 있다. Prisma schema를 사용할 때 압도적으로 편리함.
        - 데이터베이스의 상태를 추적할 수 있는 상태 관리 기능을 제공하고 특정 시점의 데이터베이스 상태를 복제해올 수 있다. 살짝 데이터베이스 버전 깃헙이랑 비슷하다고 보면 될 듯.
- ORM(Prisma)을 사용하여 좋은 점과 나쁜 점
    - 장점: 간단한 문법으로 데이터베이스를 관리할 수 있고 복잡한 쿼리문을 쓰지 않기 때문에 코드 가독성이 높아진다.
    - Migration으로 데이터베이스의 관리를 쉽게할 수 있고 데이터베이스의 상태를 쉽게 알아내고, 원하는 데이터베이스의 상태를 불러오거나 변경할 수 있다.
    - TypeScript를 지원하여 타입 안정성을 보장함.
    - 단점: 복잡한 쿼리문의 경우 프리즈마가 만들어내는 쿼리 레이어가 성능 저하를 불러올 수 있다. 데이터베이스 응답 시간이 늦어지며 빠른 연산이 필요한 어플리케이션일수록 이러한 단점이 두드러진다.
    - 프리즈마 쿼리 함수의 반환 결과값의 데이터 구조가 쓸데없이 복잡하다. 경우에 따라 중첩 객체 형태로 받아오며, 이렇게 되면 따로 해당 데이터를 가공해주는 기능을 구현해야 하고, 유지보수가 더 어려워진다.
- 다양한 ORM 라이브러리 살펴보기
    - ex. Sequelize
        - Promise 기반의 ORM. 비동기 로직을 편리하게 작성 가능하다. 프리즈마와 유사하게 자바스크립트 문법처럼 쿼리를 보낼 수 있다. model을 정의하여 데이터베이스와 객체 간의 매핑을 설정할 수 있다. 데이터 모델링, 연관 관계 설정, 소프트 deletion과 같은 기능을 제공한다.
    - ex. TypeORM
        - Active Record 페턴과 Data Mapper 패턴 형식이 있다. Active Record는 모델 그 자체에 쿼리 메소드를 정의하고 모델의 메소드를 사용하여 객체를 저장, 제거, 불러오기를 할 수 있다.
        - Data Mapper는 분리된 클래스에 쿼리 메소드를 정의하고 Repository를 이용하여 객체에 접근한다. 모델에 접근하지 않고 Repository를 통하여 데이터에 접근한다.
    
    얘네 다 Migration은 기본으로 탑재되어 있음.
    
- 페이지네이션을 사용햐는 다른 API 찾아보기
    - ex. https://docs.github.com/en/rest/using-the-rest-api/using-pagination-in-the-rest-api?apiVersion=2022-11-28
        - link 헤더 방식
            - 헤더에 아래와 같은 link 헤더를 추가한다. 이전 페이지, 다음 페이지, 마지막 페이지, 첫 번째 페이지로 갈 수 있는 URL 정보를 담고 있다.
            - 여기에 per_page와 같은 파라미터를 더 넣어서 페이지당 게시글 수를 정할 수도 있다.
            - octokit과 같은 라이브러리를 이용하여 페이지네이션을 구현할 수도 있다.
            
            ```jsx
            link: <https://api.github.com/repositories/1300192/issues?page=2>; rel="prev", 
            <https://api.github.com/repositories/1300192/issues?page=4>; rel="next", 
            <https://api.github.com/repositories/1300192/issues?page=515>; rel="last", 
            <https://api.github.com/repositories/1300192/issues?page=1>; rel="first"
            ```
            
    - ex. https://developers.notion.com/reference/intro#pagination