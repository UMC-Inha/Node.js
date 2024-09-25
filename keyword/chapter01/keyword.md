## 1. 외래키 (Foreign Key)

외래키는 한 테이블의 필드 중 다른 테이블의 기본키를 참조하는 필드입니다.

### 역할:

- 테이블 간 관계 설정
- 데이터 일관성 유지
- **참조 무결성 보장**: 왜래키가 참조하는 기본키는 항상 값이 있어야 하며, 기본키의 테이블이 수정되거나 삭제되면 왜래키의 테이블도 적절한 행위를 취해야 함

### 예시 (CustomerId) :

```sql
CREATE TABLE Orders (
    OrderID int NOT NULL,
    CustomerID int,
    OrderDate date,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

왜래키는 테이블을 연결해주는 유용한 도구입니다.

> "In other words: foreign keys put the “relational” in “relational database” – they help define the relationships between tables. They allow developers to maintain referential integrity across their database."
>
> \- www.cockroachlabs.com

## 2. 기본키 (Primary Key)

기본키는 데이터베이스 테이블에서 각 레코드를 고유하게 식별하는 열 또는 열의 집합입니다.

> "A primary key, also called a primary keyword, is a column in a relational database table that's distinctive for each record. It's a unique identifier, such as a driver's license number, telephone number with area code or vehicle identification number (VIN)."
>
> \- www.techtarget.com

## 예시 (OrderId) :

```sql
CREATE TABLE Orders (
    OrderID int NOT NULL,
    CustomerID int,
    OrderDate date,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

### 특징:

- 유일성: 테이블 내에서 중복될 수 없음
- 최소성: 꼭 필요한 최소한의 필드로 구성
- NULL 값 불가: 항상 값이 존재해야 함

> "A relational database must have only one primary key. Every row of data must have a primary key value and none of the rows can be null."

> \- www.techtarget.com

## 3. ER 다이어그램 (Entity-Relationship Diagram)

ER 다이어그램은 데이터베이스의 구조를 시각적으로 표현하는 도구입니다.

### 구성 요소:

ER 다이어그램을 그리는 방법은 사용하는 툴마다 다르지만, 일반적으로 다음과 같이 표현합니다:

- 엔티티 (Entity): 사각형으로 표현
- 속성 (Attribute): 타원으로 표현
- 관계 (Relationship): 마름모로 표현

![ER Diagram Example](https://d2slcw3kip6qmk.cloudfront.net/marketing/pages/chart/seo/ERD/discovery/erd-school.svg)

## 4. 복합 키 (Composite Key)

복합 키는 두 개 이상의 필드를 조합하여 생성된 기본키입니다.

### 사용 예:

- 학생-과목 수강 테이블에서 학번과 과목코드의 조합
- 주문-상품 테이블에서 주문번호와 상품코드의 조합

> "복합 키는 단일 필드로는 고유성을 보장할 수 없을 때 유용합니다."

## 5. 연관관계 (Relationships)

데이터베이스에서 테이블 간의 논리적 연결을 의미합니다.

### 주요 유형:

1. 일대일 (1:1) = one-to-one
2. 일대다 (1:N) = one-to-many, many-to-one
3. 다대다 (M:N) = many-to-many

> "적절한 연관관계 설정은 효율적인 데이터 관리와 조회의 핵심이다."

## 6. 정규화 (Normalization)

정규화는 데이터베이스 설계 과정에서 중복(Redundancy)을 최소화하고 데이터 일관성을 향상시키는 과정입니다.

> 데이터 중복이 없고, 불필요한 Null 값이 없을 때 Good Design

### 정규화 단계:

1. 제1정규형 (1NF)
2. 제2정규형 (2NF)
3. 제3정규형 (3NF)
4. 보이스-코드 정규형 (BCNF)
5. 제4정규형 (4NF)
6. 제5정규형 (5NF)

**정규화 단계가 높아질수록, Redundancy가 줄어들지만, 정보 손실이 일어날 수 있습니다.**

> 중복 (Redundancy)과 종속성 (dependency preserving)의 관계에서 원하는 목적에 우선순위를 두어야 한다.

## 7. 반정규화 (Denormalization)

반정규화는 정규화된 데이터베이스의 성능 향상을 위해 의도적으로 중복을 허용하는 기법입니다.

### 사용 상황:

- 데이터 조회 성능이 중요한 경우
- 데이터의 일관성보다 조회 속도가 우선시되는 경우

```sql
-- 반정규화 예시: 주문 테이블에 고객 이름 추가
CREATE TABLE Orders (
    OrderID int PRIMARY KEY,
    CustomerID int,
    CustomerName varchar(100),  -- 반정규화된 필드
    OrderDate date
);
```
