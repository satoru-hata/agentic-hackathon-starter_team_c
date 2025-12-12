# Employee Work Location System - Team C

従業員の勤務地管理システム。Rails API バックエンドと React フロントエンド（TypeScript + Tailwind CSS）を使用したフルスタックWebアプリケーションです。

## 機能

- **認証機能**: ユーザー登録、ログイン、ログアウト（JWT認証）
- **プロフィール管理**: 個人情報の登録・編集
- **勤務地ステータス管理**: 本社出社、リモート、外出・休暇の管理
- **ステータス一覧表示**: 全従業員の当日勤務地ステータス表示

## 現在の実装状態

### ✅ 実装済み
- Rails 7.1 API バックエンド（PostgreSQL使用）
- React フロントエンド（TypeScript + Tailwind CSS）
- JWT認証システム
- ユーザー登録・認証API
- プロフィール管理API
- 勤務地ステータス管理API
- Docker環境構築（複数言語対応）
- 完全なRSpecテストスイート（37テストケース）
- FactoryBot & API テストヘルパー

## 技術スタック

- **Backend**: Ruby on Rails 7.1 (API mode), PostgreSQL, JWT認証
- **Frontend**: React 18, TypeScript, Tailwind CSS
- **Testing**: RSpec, FactoryBot
- **Infrastructure**: Docker, Docker Compose
- **Multi-language Support**: TypeScript, Ruby, Python, Go, Java

## セットアップ

### 方法1: Docker Compose（推奨）

```bash
# 全サービスの起動
docker compose up -d

# データベースのマイグレーション（初回のみ）
docker compose exec backend rails db:migrate

# フロントエンドとバックエンドが自動で起動します
```

### 方法2: 個別サービス起動

#### 1. PostgreSQLデータベースの起動

```bash
docker compose up -d db
```

#### 2. Rails APIバックエンドの起動

```bash
# Docker使用
docker compose up -d backend
```

#### 3. React フロントエンドの起動

```bash
# Docker使用
docker compose up -d frontend
```

## アクセスURL

- **Rails API**: http://localhost:3000
  - Welcome API: http://localhost:3000/api/v1/welcome
  - 認証API: http://localhost:3000/api/v1/auth/*
  - プロフィールAPI: http://localhost:3000/api/v1/profile
  - 勤務地API: http://localhost:3000/api/v1/work_locations/*
- **React アプリ**: http://localhost:3001
- **PostgreSQL**: localhost:5432

## プロジェクト構造

```
.
├── backend/                    # Rails 7.1 API
│   ├── app/
│   │   ├── controllers/api/v1/ # API コントローラー
│   │   └── models/             # データモデル
│   ├── db/
│   │   ├── migrate/            # データベースマイグレーション
│   │   └── schema.rb
│   ├── spec/                   # RSpecテストスイート
│   │   ├── factories/          # FactoryBot ファクトリ
│   │   ├── requests/           # APIテスト
│   │   └── support/            # テストヘルパー
│   └── Gemfile
├── frontend/                   # React + TypeScript
│   ├── src/
│   │   ├── components/         # Reactコンポーネント
│   │   └── App.tsx
│   ├── public/
│   └── package.json
├── go/                        # Go言語サンプル
├── src/                       # TypeScript サンプル  
├── docker-compose.yml         # Docker構成
├── spec.md                    # システム仕様書
└── README.md
```

## API エンドポイント

### 認証
- `POST /api/v1/auth/register` - ユーザー登録
- `POST /api/v1/auth/login` - ログイン
- `DELETE /api/v1/auth/logout` - ログアウト
- `GET /api/v1/auth/current_user` - 現在のユーザー情報

### プロフィール管理
- `GET /api/v1/profile` - プロフィール取得
- `POST /api/v1/profile` - プロフィール作成
- `PUT /api/v1/profile` - プロフィール更新

### 勤務地管理
- `GET /api/v1/work_locations/today` - 当日の全従業員勤務地一覧
- `POST /api/v1/work_locations` - 当日の勤務地登録
- `PUT /api/v1/work_locations/:id` - 勤務地更新
- `GET /api/v1/work_locations/history` - 個人の勤務地履歴

## テスト実行

```bash
# バックエンドテスト（RSpec）
docker compose exec backend rspec

# 詳細出力でテスト実行
docker compose exec backend rspec --format documentation

# 特定のテストファイル実行
docker compose exec backend rspec spec/requests/api/v1/auth_spec.rb
```

## トラブルシューティング

### ポートが既に使用中の場合

```bash
# 全サービス停止
docker compose down
```

### データベース接続エラー

```bash
# コンテナの再起動
docker compose down
docker compose up -d db
docker compose exec backend rails db:migrate
```

### ログの確認

```bash
# 全サービスのログ
docker compose logs -f

# 特定サービスのログ
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f db
```

## 開発環境

### VS Code Dev Containers対応

複数言語開発環境に対応した Universal Dev Container を使用可能です。

**対応言語**: TypeScript, Ruby, Python, Go, Java

**起動方法**:
1. VS Codeでプロジェクトを開く
2. コマンドパレット → "Dev Containers: Reopen in Container"

## ライセンス

MIT