## ORM

### ORM 이란?

- ORM은 Object Relational Mapping의 의미로 각 테이블의 스키마를 객체 Model과 연결하여 데이터 접근시 추가, 삭제, 조회 등을 사용자가 직접 SQL 언어가 아닌 함수를 통해 가능하도록 하는 모듈을 말한다.

- ORM은 여러 종류가 존재하며 대표적으로는 Java 에서의 Hybernate, JPA  Nodejs에서의 Sequalize, Prisma 등이 존재한다.

![alt text](<SQL 언어.png>)
위 사진이 Nodejs 에서 DB에 직접 쿼리문을 작성해서 날려주는 방식이고

![alt text](<SQL 언어.png>)
위 사진이 Prisma를 활용해 쿼리문을 직접 작성하지 않고 함수를 이용해 간접적으로 DB를 접근하게 해주는 모습이다.

### Prisma의 Connection Pool 관리 방법

![alt text](<mysql 커넥션 풀.png>)
위 사진은 Mysql의 커넥션 풀을 사용하는 방식인데
사용자가 쿼리를 사용하기 직전에 conn = pool.getConnection을 통해 커넥션을 가져오고
conn.query를 통해 해당 커넥션으로 쿼리문을 실행하고
마지막에 conn.release를 통해 커넥션을 반납해줘야 하지만

![alt text](<prisma 커넥션 풀.png>)
prisma의 경우는 prisma 클라이언트를 통해 사용자가 직접 커넥션을 받아오고 나중에 반납할 필요 없이
prisma.model.함수 를 통해 DB작업을 할 수 있으며 처음 쿼리문을 날릴 때 커넥션을 생성하고 해당 커넥션으로 계속 사용하게 알아서 조절 한다.

prisma의 커넥션의 개수는 num_physical_cpus * 2 + 1 이 default 로 설정이 되어있는데 만약 커넥션의 개수를 개발자가 조정하고 싶다면 

.env 파일에서 설정한 DATABASE_URL 값에 mysql://USER:PASSWORD@HOST:PORT/DATABASE?connection_limit=5
쿼리스트링으로 connection_limit을 넣어주면 임의로 설정이 가능하다.

### Prisma의 마이그레이션 관리방법

1. 기존의 Schema.prisma를 수정한다
2. 마이그레이션 파일 생성
    - 기존 DB의 Schema와 방금 수정한 Prisma schema를 비교해서 변경사항을 DB에 적용할수 있게 SQL로 작성된 파일을 말한다.
    - npx prisma migrate dev 명령어를 통해 수행이 된다.
    - 위 명령어를 통해 sql파일이 만들어지고 바로 DB에 적용이 되므로 상황에 맞게 SQLd을 수정할 수는 없다.
    - DB에 바로 적용하지 않고 SQL 파일만 생성하려면 --create-only 라는 flag를 주면 된다.
3. 마이그레이션 파일 확인 및 수정
    - 수정할 부분이 없다면 넘어가면 되고
    - 수정할 부분이 있다면 추가로 SQL문을 작성 하면된다.

4. 해당 마이그레이션 파일을 DB에 적용
    DATABASE_URL='적용할 DB URL' npx prisma migrate dev

마이그레이션이 성공하게된다면 프로젝트상의 prisma의 마이그레이션 히스토리와 실제 DB에 적용된 마이그레이션 히스토리를 비교해서 적용되지 않은 파일들은 적용한다.

성공하게 되면 _prisma_migrations라는 테이블에 finished_at에 migration을 마친 시간과, migration_name에 위에서 생성한 마이그레이션 파일의 이름이 저장된다.

실패하게 되면 finished_at 컬럼이 null로 되어있다

실패한 마이그레이션에서 스키마를 되돌리려면 
```
DATABASE_URL='적용할 DB URL' npx prisma migrate resolve --rolled-back 롤백할 마이그레이션 파일 이름
```
위의 명령어를 사용해서 되돌린후 마이그레이션 파일을 수정하여 다시 진행하면 된다.



### ORM을 사용하여 좋은 점과 나쁜 점
    - 좋은 점
        - SQL 언어를 직접 쓰지않기 때문에 잘 몰라도 DB를 조작할 수 있다. 또한 이 덕분에 코드의 가독성이 높아진다.
        - 테이블간의 관계를 위해 JOIN연산을 SQL 쿼리에 써야하는데 prisma는 JOIN을 개발자가 사용할 필요없이 직관적으로 사용할 수 있게 해준다.
        - Prisma의 경우 커넥션을 알아서 관리해주기 때문에 개발자가 직접 커넥션을 관리하지 않아도 된다.
        - DBMS 에 대한 종속성이 줄어든다.

    - 나쁜 점
        - ORM 만으로는 구현하기가 어려운 경우가 있다.
        - 잘 못 구현된 경우 속도저하 및 일관성 파괴 문제등이 발생한다.
        - 특정 데이터베이스의 고유의 기능을 활용하기가 어렵다.
        - 대량의 데이터를 처리하는 경우 성능에 문제가 발생할 수 있다.


### Sequelize
    - 설치 
    ```
    npm install sequelize // 시퀄라이즈 설치
    npm install mysql2 // mysql2 설치
    npm install -g sequelize-cli // sequelize-cli를 전역으로 설치한다.
    ```
    
    ```
    sequelize init 
    ```
    위 명령어를 통해 config, models, migrations, seeders라는 폴더가 생성된다.

    models 폴더안에 index.js라는 파일이 생성되고 해당 파일에서 models 폴더내에 있는 파일들을 읽고 그것들을 모델로 정의한다.

    모델을 정의 할 때는 model명.js 파일로 만들어준후 그 파일내에서 모델을 정의하면 테이블이 만들어 진다.

    ![alt text](<Sequelize 모델 생성.png>)
    위 방식으로 모델을 생성할 수 있다.

    - 관계에 대한 정의는 다음과 같이 이뤄진다.
        ```
        // 일대다 관계
        db.User.hasMany(db.Post);
        db.Post.belongsTo(db.User);

        // 다대다 관계
        db.Post.belongsToMany(db.User,{through:'usermemo',});
        db.Hashtag.belongsToMany(db.Memo,{through: 'usermemo'});
        ```

        위 관계정의는 models/index.js에서 작성을 해준다.

    - CRUD 사용
        CREATE
        ```
        Model.create({
            field1:,
            field2,
        })
        ```

        READ
        ```
        Model.findOne({
            where:{}
        })

        Model.findAll({
            where:{}
        })
        ```

        UPDATE
        ```
        Model.update({
            field: updateValue,
        }, {
            where : {}
        })
        ```

        DELETE
        ```
        Model.destory({
            where : {}
        })
        ```

### TypeORM
    - TypeORM의 특징

        - 모델 정의 방식
            1. Active Record 패턴

                ![alt text](<TypeORM 모델 정의.png>)
                각 모델들이 BaseEntity를 상속하게 하여 BaseEntity가 가지고 있는 메소드와 static으로 만들어내는 커스텀 메소드를 이용할 수 있다.

                위 방식으로 모델을 정의하면
                ![alt text](<typeorm 모델정의 1.png>)
                다음과 같이 new라는 키워드를 이용해 새로운 인스턴스를 만들어 사용이 가능하다
            
            2. Data Mapper 패턴
                Repository를 통해 객체를 저장, 제거, 조회를 한다.
                위와의 차이점은 모델에 직접 접근하는 방식이 아닌 Repository를 통해 데이터에 접근을 하게 된다.

                ![alt text](<typeorm 모델정의 2.png>)
                다음과 같이 모델을 위한 클래스를 정의하고 
                
                ![alt text](<typeorm 모델정의 3.png>)
                정의한 클래스를 Generic 타입을 이용해 상속하게 한다.

                ![alt text](<typeorm 모델정의 4.png>)
                다음과 같이 getRepository()를 사용해 만들어진 모델을 사용한다.

        위 두가지 모델 방식은 각각의 상황에 따라 사용하면 된다
            - Active Record 방식은 규모가 작은 app에서 적합하고 간단히 사용이 가능하다

            - Data Mapper 방식은 규모가 큰 app에서 적합하고 유지보수에 효과적이다.





            













