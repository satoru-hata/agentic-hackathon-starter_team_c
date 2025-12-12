
* 環境整備
    - 畑さん
* 仕様を決める
    - オフィスに出社した人がわかる
    - システムログインさせるには、ボタンでユーザー登録する→ベストはgoogleログイン、ワーストは会員登録的な
    - カレンダーAPI,KOT APIで取得する
    - 会員登録/ログイン/ログアウト・自分の情報登録・一覧画面(他社員の勤務地の表示)
      - 会員登録情報: username, password
      - 自分の情報登録: 名前, 所属部署, 今日の勤務地(オフィスにいるいない)
* ドキュメントに起こす
* AIへの指示とコーディング（ドライバー）
* DB設計まわりの整備
* その他ミドルウェアの活用検討

* 環境
  * Rails 8 の最新で API モード
  * React で tailwind CSS

* 初期状態で Welcome ページを表示する





bundle install
rails new . --force --skip-bundle
rails server


rails new . --force --skip-bundle --api
