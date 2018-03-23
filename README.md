# 環境
  ```
   ruby -v → ruby 2.5.0
   rails -v → Rails 5.1.5
  ```

# 想定テーブル

## User
  * name(string)
  * email(string)
  * password_digest(string)
  * remember_digest(string)
  * admin(boolean)
  * thumbnail(string)

## Task
  * title(string)
  * content(text)
  * status(string)
  * user_id(integer)
  * position(integer)
  * end_period(datetime)

## Label
  * name(string)
  * task_id(integer)

## GroupUser
  * group_id(integer)
  * user_id(integer)

## GroupTask
  * group_id(integer)
  * task_id(integer)

## Group
  * name(string)


# Herokuのデプロイ
```heroku create```

```git push heroku master```

```heroku run rake db:migrate```

```heroku open```