// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs
//dbdiagram.io라는 사이트에서 제작한 ERD입니다

Table users {
  id bigint [primary key]
  username varchar(20)
  password varchar(20)
  gender varchar(10)
  birth_date date
  address varchar(20)
  preferred_food text
  my_mission bigint
}

Table missions{
  id bigint [primary key]
  area_id bigint
  shop_id bigint
  point bigint
  mission_content text
}

Table user_missions{
  id bigint [primary key]
  mission_id bigint
  user_id bigint
  is_complete bool
  created_at datetime(6)
  updated_at datetime(6)
}

Table area{
  id bigint [primary key]
  area_name varchar(10)
  mission_complete_count bigint
}

Table shops{
  id bigint [primary key]
  area_id bigint
  shop_name varchar(20)
}

Table reviews{
  id bigint [primary key]
  user_id bigint
  shop_id bigint
  content text
  rating double
  created_at datetime(6)
  updated_at datetime(6)
}

Table area_mission{
  id bigint
  user_id bigint
  area_id bigint
  mission_id bigint
  complete_mission_count bigint
}

Table alarms{
  id bigint
  title varchar(30)
  content text
  user_id bigint
}

Table mission_alarms{
  id bigint
  alarm_id bigint
  mission_id bigint
  title varchar(20)
  body text
}

Table review_alarms{
  id bigint
  alarm_id bigint
  shop_id bigint
  title varchar(20)
  body text
}

Ref: missions.id > users.my_mission

Ref: area.id > missions.area_id

Ref: area.id > shops.area_id

Ref: users.id > reviews.user_id

Ref: shops.id > reviews.shop_id

Ref: shops.id > missions.shop_id

Ref: users.id > area_mission.user_id

Ref: area.id > area_mission.area_id

Ref: alarms.user_id > users.id

Ref: mission_alarms.alarm_id > alarms.id

Ref: review_alarms.alarm_id > alarms.id

Ref: users.my_mission < user_missions.id

Ref: user_missions.mission_id < missions.id

Ref: users.id > user_missions.user_id