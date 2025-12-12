# Rails API + React アプリケーション

Rails 8 API バックエンドと React フロントエンド（Tailwind CSS付き）のプロジェクトです。

## 必要な環境

- Docker
- Ruby 3.0.6 以上
- Node.js 16 以上
- PostgreSQL（Docker経由で提供）

## セットアップ

### 方法1: 自動セットアップ（推奨）

```bash
./start.sh
```

このスクリプトは以下を自動的に実行します：
- PostgreSQLデータベースの起動
- Rails APIサーバーの起動（ポート3000）
- Reactアプリケーションの起動（ポート3001）

### 方法2: 手動セットアップ

#### 1. PostgreSQLデータベースの起動

```bash
docker-compose up -d db
```

#### 2. Rails APIバックエンドの起動

```bash
cd backend
bundle install
rails db:create
rails db:migrate
rails server
```

#### 3. React フロントエンドの起動

新しいターミナルウィンドウで：

```bash
cd frontend
npm install
npm start
```

## アクセスURL

- **Rails API**: http://localhost:3000
  - Welcome API: http://localhost:3000/api/v1/welcome
- **React アプリ**: http://localhost:3001

## プロジェクト構造

```
.
├── backend/         # Rails API
│   ├── app/
│   ├── config/
│   └── Gemfile
├── frontend/        # React アプリ
│   ├── src/
│   ├── public/
│   └── package.json
├── docker-compose.yml
└── start.sh
```

## 機能

- ✅ Rails 8 API モード
- ✅ PostgreSQL データベース
- ✅ React with TypeScript
- ✅ Tailwind CSS
- ✅ Welcome ページ
- ✅ CORS設定済み（フロントエンドからAPIへのアクセス許可）

## トラブルシューティング

### ポートが既に使用中の場合

```bash
# Rails API (ポート3000)
lsof -i :3000
kill -9 [PID]

# React (ポート3001)
lsof -i :3001
kill -9 [PID]

# PostgreSQL (ポート5432)
docker-compose down
```

### データベース接続エラー

```bash
docker-compose down
docker-compose up -d db
```

### OpenSSL エラー（Ruby）

DevContainerの使用を検討してください：
```bash
code .devcontainer
```