# 仕様
## ユーザー機能  
  mailアドレスとパスワードで管理、非ログイン者は全機能使用不可   
  管理者権限を持つユーザーのみ管理画面へアクセス可

## タスク管理機能  
  自身の作成したタスクのみ管理可能  
  一覧画面（root）から以下の操作が可能  
  * ラベル付与、削除  
    * 同ラベルの重複登録不可
  * ステータス更新  
    * 未着手→着手中→完了のStepのみステータス遷移が可能
  * 詳細検索   
    * タイトル、ステータス、終了期間、付与ラベル
  * タスクの新規作成画面へ遷移  
    * タイトル：30字以内  
    * 内容：500字以内  
    * 予定終了期間：未来の日付
  * タスクの編集画面へ遷移
  * タスクの削除

## ラベル管理機能  
  ヘッダーメニューのラベル管理から操作可能  
  ラベルデータは全ユーザーが共通して使用、削除できる
  * ラベル名とイメージカラーで登録
    * ラベル名：9字以内
  * 一覧表示、削除


## 管理者機能
  管理者権限を持つユーザーのみ「ヘッダーメニュー→アカウント→管理画面」へアクセス  
  以下の機能が使用可能
  * ユーザー管理  
    * ユーザー作成、削除、編集、権限操作、各ユーザーの作成タスク確認
  * ラベル管理  
      * 登録ラベルの確認、付与タスク数の確認
  
  

# 環境
  ```
   ruby -v → ruby 2.5.0
   rails -v → Rails 5.1.5
  ```

# ローカル操作
## Clone
``` git clone https://github.com/almeila/task_management_system.git ```

## 初期データ準備
```bundle exec rake db:migrate```   
```bundle exec rake db:seed```

## 管理ユーザー
```
Email：testmail@first.com
Pass ：password
```