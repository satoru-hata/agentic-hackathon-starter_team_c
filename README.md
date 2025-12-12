# Agentic Hackathon Starter - Team C

ハッカソン用のスターターテンプレート。Rails 8 API バックエンドと React フロントエンド（Tailwind CSS付き）のプロジェクトです。

## 現在の実装状態

### ✅ 実装済み
- Rails 8 API モード（PostgreSQL使用）
- React フロントエンド（TypeScript + Tailwind CSS）
- Docker環境構築
- Welcome API エンドポイント
- CORS設定

## 必要な環境

- Docker
- Ruby 3.0.6 以上
- Node.js 16 以上
- PostgreSQL（Docker経由で提供）

## セットアップ

### 方法1: Docker Compose（推奨）

```bash
# サービスの起動
docker-compose up -d

# Reactフロントエンドの起動
cd frontend
npm install
npm start
```

### 方法2: 手動セットアップ

#### 1. PostgreSQLデータベースの起動

```bash
docker-compose up -d db
```

#### 2. Rails APIバックエンドの起動

```bash
docker-compose up -d backend
# または
cd backend
bundle install
rails db:create
rails db:migrate
rails server
```

#### 3. React フロントエンドの起動

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
└── README.md
```

## 今後の実装予定（spec.md参照）

- ユーザー認証機能（JWT）
- 従業員プロフィール管理
- 勤務地ステータス管理
- リアルタイムステータス更新

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

Dockerコンテナを使用してください：
```bash
docker-compose up -d backend
```

## 開発環境（オリジナル）

VS Code Dev Containersにも対応しています。

### 事前準備

- Docker Desktop
- VS Code + Dev Containers拡張機能

### 起動方法

1. VS Codeでプロジェクトを開く
2. コマンドパレット → "Dev Containers: Reopen in Container"

## ライセンス

MIT