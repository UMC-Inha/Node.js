# JOIN

- Inner Join

```sql
SELECT <열 목록>
FROM <첫 번째 테이블>
    INNER JOIN <두 번째 테이블>
    ON <조인 조건>
[WHERE 검색 조건]
```

테이블을 조인하려 할 때 지정한 열의 데이터가 모든 테이블에 있어야한다.

Inner Join을 그냥 Join이라고만 적어도 자동으로 Inner로 인식한다.

가장 많이 사용하는 Join

- Outer Join

```sql
SELECT <열 목록>
FROM <첫 번째 테이블(LEFT 테이블)>
    <LEFT | RIGHT | FULL> OUTER JOIN <두 번째 테이블(RIGHT 테이블)>
     ON <조인 조건>
[WHERE 검색 조건]
```

Outer Join은 한쪽 테이블에 열의 데이터가 없어도 강제로 Join해버린다.

Outer Join은 테이블을 Join하는 방향에 따라 Left, Right, Full로 나뉜다.

Left는 왼쪽 테이블의 데이터를 모두 보여주고, Right는 오른쪽 테이블, Full은 모든 테이블의 데이터를 보여준다.

- Cross Join

```sql
SELECT *
FROM <첫 번째 테이블>
    CROSS JOIN <두 번째 테이블> 
```

Cross Join은 한쪽 테이블의 모든 행과 다른 한쪽의 모든 행을 전부 연결시켜버리는 Join이다.

따라서 n개의 행의 테이블과 m개의 행의 테이블을 Cross Join하면 최종 결과물은 n*m의 행을 가지게 된다.

- Self Join

```sql
SELECT <열 목록>
FROM <테이블> 별칭A
    INNER JOIN <테이블> 별칭B
[WHERE 검색 조건]
```

자기 자신을 조인하는 연산

이걸 어따 씀??

# 이번 주 미션때 사용한 다른 SQL 문법

```sql
INSERT INTO reviews(user_id, shop_id, content, rating) VALUES (1, 1, '리뷰내용', 4.5);
```

단순한 INSERT 문법

```sql
WHERE user_missions.user_id = 1 AND is_complete = 0
```

WHERE 다중 조건문 (AND, OR 등등)

```sql
alter table reviews
    modify updated_at timestamp default CURRENT_TIMESTAMP not null on update current_timestamp;
```

ALTER TABLE로 테이블 정보 바꾸기, default와 on update에 current_timestamp로 값 설정해서 자동으로 생성일자와 수정일자 기록하기