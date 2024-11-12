# ORM

Object -Relatiobal Mapping 즉 , 객체와 관계형 데이터베이스 매핑의 줄임말입니다.

-객체 지향 프로그래밍은 클래스를 사용하고 ,관계형 데이터베이스는 테이블을 사용한다.

-객체 모델과 관계형 모델 간에 불일치가 존재한다.

-ORM을 통해 객체 간의 관계를 바탕으로 SQL을 자동으로 생성하여 불일치를 해결해준다.

# Prisma 문서 살펴보기

## ex.Prisma의 Connection Pool 관리 방법

커넥션 풀은 Prisma Data Platform에서 Prisma Accelerate가 제공하는 핵심 기능 중 하나이다.

기본적으로 Accelerate는 10으로 연결 제한이 있다. Prisma Accelerate는 Accelerate에서 사용되는 Prisma Schema당 데이터베이스에 최대 10개의 데이터베이스 연결을 연다.

## ex.Prisma의 Migration 관리 방법

Prisma Migrate는 DB schema를 변경할 수 있는 tool이다.

    개발 환경에서 Prisma Migrate를 시작하려면 Prisma 스키마를 만든다.

    ```prisma
    datasource db {
      provider = "postgresql"
      url      = env("DATABASE_URL")
    }

    model User {
      id    Int    @id @default(autoincrement())
      name  String
      posts Post[]
    }

    model Post {
      id        Int     @id @default(autoincrement())
      title     String
      published Boolean @default(true)
      authorId  Int
      author    User    @relation(fields: [authorId], references: [id])
    }
    ```

    1. **첫 번째 마이그레이션을 만든다**.
        ```bash
        $ prisma migrate dev --name init
        ```
        - 이제 Prisma 스키마가 데이터베이스에 스키마와 동기화되고, 마이그레이션 기록이 초기화된다.

    2. **스키마에 추가 필드가 생기면 두 번째 마이그레이션 생성**.
        ```bash
        $ prisma migrate dev --name added_job_title
        ```
        - Prisma 스키마가 다시 데이터베이스 스키마와 동기화되었을 시, 마이그레이션 기록에는 두 개의 마이그레이션이 포함되어 있다.

# ORM(Prisma)을 사용하여 좋은 점과 나쁜 점

## 장점

1. 별도의 sql문을 사용하지 않아도 객체 지향 프로그래밍 언어로 구현이 가능하며 이는 곧 생산성 증가로 이어진다.
2. 재사용 및 유지보수가 편리하다.
3. DBMS에 대한 종속성이 줄어든다.
4. DB의 마이그레이션을 쉽게 할 수 있다.

## 단점

1. 직접 SQL 작성하는 것보다 상대적으로 복잡할 수가 있고 프로젝트의 복잡성이 높아질 경우 난이도가 그 만큼 올라간다.
2. 기존의 기업들은 ORM을 고려하지 않은 DB를 사용하고 있어 ORM에 적합하게 변환하려면 많은 시간과 노력이 필요로 한다.
3. DB와 바로 연결하는 것보다 초기설정이 더 많아지거나 복잡해질 수 있다.
4. DB와 ORM프레임 워크, 내부 코드에 대한 충반한 이해가 없는 경우 문제 해결이 힘들다.
5. DB에 직접 Query문을 보내는 것이 아니기 때문에 성능저하가 발생한다 .

# 다양한 ORM 라이브러리 살펴보기

- ex.Sequelize
  Sequelize는 MySQL, PostgreSQL, MariaDB등 많은 RDBMS를 지원하고 Promise 기반으로 구현되었기에 비동기 로직을 편리하게 작성 가능

사용을 위해서 sequelize와 sequelize-cli 그리고 mysql2을 설치해주어야함

```
npm install sequelize sequelize-cli mysql2
```

```
squelize init
```

해당 명령어로 디렉터리와 파일이 생성된다.

config/config.json에서 db와 연결할 유저 , 비번, database 이름, db 서버 호스트,
db 타입등을 설정해준다.

```
squelize db:create
```

위 명령어로 config/config.json 파일을 읽은 후 , develpment 모드에 작성되어 있는 Ryan DB가 생성
이후 model.js 생성해주고 index.js를 통해 연결해준다.

- TypeORM
  TypeORM이라는 이름으로 인해 타입스크립트의 전용 ORM 같지만, 자바스크립트(ES5,ES6,ES7)도 지원한다.

TypeORM을 사용하여 개발 하면 Python의 SQLAlchemy와 같은 Data Mapper 패턴과 Rails와 같은 Active Record 패턴으로 개발 가능하다 .

1. Active Record 패턴

```
const user = new User();
user.firstName = "Timber";
user.lastName = "Saw";
user.isActive = true;
await user.save();

// example how to remove AR entity
await user.remove();

// example how to load AR entities
const users = await User.find({ skip: 2, take: 5 });
const newUsers = await User.find({ isActive: true });
const timber = await User.findOne({ firstName: "Timber", lastName: "Saw" });
const timber = await User.findByName("Timber", "Saw");

```

2. Data Mapper패턴

data mapper패턴은 분리된 클래스에 쿼리 메소드를 정의하는 방식이며 , repository를 이용하여 객체를 저장 , 제거 , 불러온다 .

Active Record 패턴과의 차이점은 모델에 접근하는 방식이 아닌 Repository에서 데이터에 접근한다는 것이다.

```
import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class User {
@PrimaryGeneratedColumn()
id: number;

@Column()
firstName: string;

@Column()
lastName: string;

@Column()
isActive: boolean;
}

```

정의한 클래스를 generic 타입을 이용하여 상속한다.

```
import { EntityRepository, Repository } from "typeorm";
import { User } from "../entity/User";

@EntityRepository()
export class UserRepository extends Repository<User> {
findByName(firstName: string, lastName: string) {
return this.createQueryBuilder("user")
.where("user.firstName = :firstName", { firstName })
.andWhere("user.lastName = :lastName", { lastName })
.getMany();
}
}

```
