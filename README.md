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
- Docker Compose

## セットアップ

### Docker Compose（推奨）

すべてのサービスをコンテナで起動します：

```bash
# すべてのサービスの起動（データベース、バックエンド、フロントエンド）
docker-compose up -d

# ログを確認
docker-compose logs -f

# 特定のサービスのログを確認
docker-compose logs -f frontend
docker-compose logs -f backend
```

### 手動セットアップ

個別にサービスを起動する場合：

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
docker-compose up -d frontend
# または
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
# すべてのコンテナを停止
docker-compose down

# 特定のポートを使用しているプロセスを確認
lsof -i :3000  # Rails API
lsof -i :3001  # React Frontend
lsof -i :5432  # PostgreSQL
```

### データベース接続エラー

```bash
docker-compose down
docker-compose up -d db
# 少し待ってからバックエンドを起動
docker-compose up -d backend
```

### コンテナの再ビルドが必要な場合

依存関係を変更した場合は、コンテナを再ビルドしてください：
```bash
docker-compose down
docker-compose build
docker-compose up -d
```

### フロントエンドのホットリロードが動作しない場合

環境変数 `CHOKIDAR_USEPOLLING=true` が設定されているか確認してください（docker-compose.ymlに設定済み）。

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