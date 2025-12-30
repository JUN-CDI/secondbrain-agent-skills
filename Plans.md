# Plans - タスク管理

このファイルは Claude Code Harness のタスク管理ファイルです。
Solo モードで運用中。

---

## 🎯 プロジェクト: 法人ターゲット抽出アプリ（BtoB営業支援）

### 概要
- **目的**: 株主優待・福利厚生・退職記念品・ユニフォーム等のBtoB需要が見込める企業を自動抽出し、優先度付けして営業リスト化
- **対象**: 小規模チーム（5名以下）
- **参考**: 複数の公開データ（法人番号、上場銘柄、認定制度、公式サイト、プレスリリース）を統合
- **スコープ**: フル機能（生成AI含む）

### 技術スタック
- **フロントエンド**: Next.js 15
- **バックエンド**: FastAPI (Python)
- **データベース**: PostgreSQL
- **ジョブスケジューラ**: Celery + Redis
- **生成AI**: OpenAI API (Structured Outputs)
- **スクレイピング**: httpx + BeautifulSoup4
- **デプロイ**: Docker Compose (開発) → Vercel (フロント) + VPS (バックエンド)

---

## 🔴 フェーズ1: 基盤構築（インフラ・DB設計） `cc:TODO`

### 1.1 プロジェクト初期化
- [ ] プロジェクトディレクトリ構成
  - backend/ (FastAPI)
  - frontend/ (Next.js)
  - docs/ (設計書)
  - scripts/ (ユーティリティ)
- [ ] 環境構築
  - Python 3.11+ + Poetry
  - Node.js 20+ + pnpm
  - Docker & Docker Compose
- [ ] Git初期化 & 初回コミット
- [ ] .gitignore, .env.example 作成

### 1.2 データベース設計 `[feature:tdd]`
- [ ] PostgreSQL 初期化（Docker Compose）
- [ ] マイグレーションツール導入（Alembic）
- [ ] テーブル定義実装
  - organizations（企業マスタ）
  - signals（根拠・シグナル）
  - scores（スコア）
  - region_groups / region_group_members（エリア管理）
  - org_sites（公式サイトURL管理）
  - raw_sources（RSS/プレスURL収集）
  - page_texts（公式サイト本文保管）
  - ingestion_runs（取り込みログ）
- [ ] インデックス設定（corp_number, organization_id, observed_at等）
- [ ] マイグレーション実行

### 1.3 基本セットアップ
- [ ] linter/formatter (ruff, prettier)
- [ ] pre-commit hooks
- [ ] CI/CD準備（GitHub Actions設定）
- [ ] 環境変数管理（.env, pydantic-settings）

---

## 🟡 フェーズ2: データ取り込み基盤（必須シグナル） `cc:TODO`

### 2.1 法人番号データ取り込み `[feature:tdd]`
- [ ] NTA（国税庁法人番号API）全件取得
  - API クライアント実装
  - 法人番号 → organizations へ upsert
- [ ] NTA 差分取り込みジョブ（日次）
  - Celery タスク実装
  - ingestion_runs にログ記録
- [ ] 名寄せロジック実装（優先順位）
  - 法人番号一致（最優先）
  - 証券コード一致
  - 正規化社名 + 都道府県一致
  - provisional / duplicate_suspect フラグ

### 2.2 上場銘柄取り込み `[feature:tdd]`
- [ ] JPX（東証）月次取得
  - 上場銘柄一覧 CSV ダウンロード
  - organizations へ is_listed_tse, security_code 付与
- [ ] NSE（名証）取り込み（手動 or 低頻度）

### 2.3 認定制度取り込み `[feature:tdd]`
- [ ] 健康経営優良法人（Excel/PDF）
  - パーサー実装（openpyxl or tabula-py）
  - signals へ type=health_white500 等で保存
- [ ] えるぼし・くるみん等（公開一覧）
  - 公式サイトから取得
  - signals へ type=eruboshi, kurumin で保存
- [ ] 女性活躍推進企業DB（参照URL）
  - signals へ evidence_url 付きで保存

### 2.4 エリアフィルタ定義 `[feature:tdd]`
- [ ] region_groups テーブル設定
  - 関西（大阪、京都、兵庫等）
  - 名古屋（愛知中心）
  - 関東近郊（東京、神奈川、埼玉、千葉等）
- [ ] hq_in_target_region 計算ロジック

---

## 🟢 フェーズ3: 公式サイト探索＋生成AI判定 `cc:TODO`

### 3.1 公式サイトURL管理 `[feature:security]`
- [ ] org_sites テーブル設計・実装
  - 手入力/CSVインポート機能（管理画面）
  - AI候補生成 → 承認フロー
- [ ] site_discovery ジョブ（週次）
  - 会社名 + 所在地 + 証券コード → URL候補生成
  - 候補を org_sites へ仮登録（要承認）

### 3.2 公式サイト限定探索（Scoped Crawl） `[feature:security]`
- [ ] site_scoped_crawl ジョブ（週次）
  - robots.txt チェック実装
  - レート制限実装（1ドメインあたり毎分N件）
  - 優先パス（/recruit, /careers, /company, /benefits等）
  - 30日キャッシュ（page_texts へ保存）
  - 上位N社（例:300社）に限定
  - HTML → テキスト抽出（BeautifulSoup）
- [ ] エラーハンドリング
  - 失敗はブラックリスト化（管理画面で管理）
  - ingestion_runs にエラーログ

### 3.3 生成AI: 公式サイト制度タグ付与 `[feature:tdd]`
- [ ] OpenAI API クライアント実装
  - Structured Outputs 対応
  - input_hash によるキャッシュ（ai_outputs テーブル）
- [ ] site_policy_tagging スキーマ実装
  - JSON Schema 定義（設計書の例を参照）
  - welfare_strength, uniform_presence, award_program 等
- [ ] ai_site_tagging ジョブ（週次）
  - page_texts → AI判定 → org_tags / signals 更新
  - 失敗時は human_review キューへ
- [ ] コスト管理
  - 月間トークン上限設定
  - 超過時キュー停止 + アラート

### 3.4 プレスリリースRSS取り込み `[feature:tdd]`
- [ ] press_rss_ingest ジョブ（毎日 or 週次）
  - PR TIMES, @Press, ValuePress RSS取得
  - raw_sources へURL保存

### 3.5 生成AI: 消費者キャンペーン判定 `[feature:tdd]`
- [ ] consumer_campaign スキーマ実装
  - JSON Schema 定義（設計書の例を参照）
  - campaign_type, period, winners_count, prize_type 等
- [ ] ai_campaign_classify ジョブ（毎日 or 週次）
  - raw_sources → AI判定 → signals 更新
  - is_active フラグ + valid_until 管理（TTL: 90日）
  - 企業への紐付け（ドメイン一致、社名正規化一致）

---

## 🔵 フェーズ4: スコアリング＋CSV出力 `cc:TODO`

### 4.1 スコア計算エンジン `[feature:tdd]`
- [ ] flag_500_equivalent 判定ロジック
  - 東証上場 or 健康経営上位区分 or 求人勤務地複数＋制服キーワード
- [ ] カテゴリ別スコア計算
  - score_shareholder（株主優待）
  - score_welfare（福利厚生）
  - score_retirement（退職記念品/表彰）
  - score_uniform（ユニフォーム）
  - score_consumer_campaign（消費者キャンペーン）
- [ ] score_total 計算（重み付き平均）
- [ ] recommended_pitch 生成（ルールベース）
- [ ] score_compute ジョブ（週次 or 日次）
  - signals 集計 → scores 更新

### 4.2 営業向け要約生成（オプション） `[feature:tdd]`
- [ ] ai_rationale_summary ジョブ（週次 or オンデマンド）
  - 企業別の根拠集計 → 1段落の要約
  - rationale_summary → scores テーブルへ保存
  - 上位N社のみ実行（コスト最適化）

### 4.3 CSV出力機能 `[feature:tdd]`
- [ ] csv_export ジョブ（週次）
  - エリアフィルタ適用
  - 必須列（社名、法人番号、都道府県、スコア等）
  - 任意列（根拠URL、最終観測日等）
  - 件数上限（例:1,000社）
- [ ] 差分CSV機能
  - exports テーブル（前回エクスポート記録）
  - 新規追加 / スコア上昇 / スコア下降 の検出
  - score_delta_total 計算
  - 別ファイル方式 or 1ファイル + change_flag

---

## 🟣 フェーズ5: 管理画面（Next.js） `cc:TODO`

### 5.1 基本画面
- [ ] ダッシュボード `[feature:a11y]`
  - ジョブ実行状況（成功/失敗）
  - 最新更新日時（各ソース別）
  - 今週の追加/上昇/下降ターゲット数
  - AI予算使用量（当月/上限）
- [ ] 企業一覧 `[feature:a11y]`
  - フィルタ（エリア、上場区分、500相当、スコア帯、タグ、最終観測日）
  - ソート（総合、カテゴリ別、最終観測日）
  - 一括アクション（上位N件CSV、選択CSV）
- [ ] 企業詳細 `[feature:a11y]`
  - スコアカード5枚
  - 推奨提案順
  - 根拠タイムライン（signals、フィルタ可能）

### 5.2 管理機能
- [ ] CSVエクスポート画面 `[feature:a11y]`
  - 条件設定（エリア、上場、スコア閾値等）
  - 列選択
  - 差分CSV設定（閾値、出力方式）
  - エクスポート履歴
- [ ] 辞書管理 `[feature:a11y]`
  - カテゴリ別キーワード追加/無効化
  - 重み変更
  - 変更履歴（監査）
- [ ] ジョブログ `[feature:a11y]`
  - ingestion_runs 一覧
  - 失敗ジョブの再実行
- [ ] 名寄せレビュー `[feature:a11y]`
  - needs_review=TRUE の企業一覧
  - アクション（確定/統合/除外）
  - 公式サイトURL（org_sites）確定

### 5.3 生成AI拡張機能（オプション） `[feature:a11y]`
- [ ] タグ設計・承認画面
  - 商材選択 → AI提案（タグ案/辞書案/重み案）
  - プレビュー（ヒット社数、上位入替）
  - 承認ワークフロー（tag_rules）
- [ ] human_review キュー
  - AI判定の保留/却下
  - 再実行（モデル変更、入力短縮）
- [ ] AIコスト管理画面
  - 当月使用量/上限/超過予測
  - ジョブ別内訳
  - キュー停止/再開
- [ ] 鮮度・有効期限設定（TTL管理）
  - consumer_campaign_ttl_days 設定
  - 影響プレビュー（active件数差分、上位入替数）

### 5.4 認証・権限 `[feature:security]`
- [ ] 簡易認証（メール/パスワード or SSO準備）
- [ ] 役割管理（管理者/営業）

---

## 🔷 フェーズ6: 自動化・ジョブスケジューリング `cc:TODO`

### 6.1 Celeryセットアップ
- [ ] Celery + Redis 設定
- [ ] Celery Beat（スケジューラ）設定
- [ ] Flower（モニタリング）導入

### 6.2 ジョブスケジュール定義
- [ ] 日次（平日）: nta_diff_ingest
- [ ] 週次（月曜早朝）:
  - site_scoped_crawl
  - ai_site_tagging
  - press_rss_ingest
  - ai_campaign_classify
  - score_compute
  - csv_export
- [ ] 月次: jpx_monthly_ingest
- [ ] 随時: certifications_ingest（認定更新時）

### 6.3 失敗時ポリシー
- [ ] リトライロジック（指数バックオフ）
- [ ] エラー通知（Slack/メール）
- [ ] human_review キューへのエスカレーション

---

## 🟤 フェーズ7: フィードバックループ（受注連携） `cc:TODO`

### 7.1 SFA/CRM連携
- [ ] feedback_imports テーブル実装
- [ ] org_outcomes テーブル実装
- [ ] CSV/API取り込み機能
  - organization_id or corp_number
  - outcome（won/negotiating/approached/not_approached）
  - 商材カテゴリ、受注金額

### 7.2 分析機能
- [ ] スコア帯別の受注率・商談化率集計
- [ ] 受注企業の共通シグナルパターン抽出
- [ ] 未接触高スコア件数の確認

### 7.3 改善反映
- [ ] スコア重み調整（管理画面）
- [ ] タグ設計の改善（tag_rules）
- [ ] 影響範囲プレビュー（ヒット社数、上位入替）

---

## 🔶 フェーズ8: 仕上げ・デプロイ `cc:TODO`

### 8.1 テスト `[feature:tdd]`
- [ ] バックエンドユニットテスト（pytest）
  - データ取り込みロジック
  - スコア計算ロジック
  - AI判定（モック使用）
- [ ] フロントエンドテスト（Jest/Vitest）
  - コンポーネントテスト
- [ ] E2Eテスト（Playwright）
  - CSV出力フロー
  - 企業一覧 → 詳細 → CSV

### 8.2 セキュリティチェック `[feature:security]`
- [ ] SSRF対策（公式サイト探索）
- [ ] SQLインジェクション対策（parameterized query）
- [ ] XSS対策（Next.js デフォルト）
- [ ] 環境変数の秘匿化（.env → secrets manager）
- [ ] レート制限（API エンドポイント）

### 8.3 パフォーマンス最適化
- [ ] DB クエリ最適化（EXPLAIN ANALYZE）
- [ ] インデックスチューニング
- [ ] Celery タスクの並列実行
- [ ] フロントエンドのコード分割（Next.js dynamic import）

### 8.4 ドキュメント整備
- [ ] README.md（プロジェクト概要、セットアップ手順）
- [ ] API ドキュメント（FastAPI自動生成）
- [ ] 運用マニュアル
  - ジョブ管理
  - 名寄せレビュー手順
  - AI予算管理
- [ ] トラブルシューティングガイド

### 8.5 デプロイ
- [ ] Docker Compose（開発環境）
- [ ] Vercel（Next.js フロントエンド）
- [ ] VPS（FastAPI + PostgreSQL + Redis + Celery）
- [ ] 環境変数設定（本番）
- [ ] ヘルスチェックエンドポイント
- [ ] ログ集約（CloudWatch or 自前）

### 8.6 動作確認
- [ ] ローカルでフルフロー確認
- [ ] ステージング環境でジョブ実行確認
- [ ] 本番環境で初回データ取り込み
- [ ] CSV出力の検証（営業チームへ共有）

---

## 📦 将来的な拡張（ロードマップ） `cc:TODO`

- [ ] ハローワークAPI連携（求人シグナル強化）
- [ ] 商材カタログ管理（product_catalog テーブル）
- [ ] AI提案の高度化（GPT-4o-mini → GPT-4o）
- [ ] 多言語対応（UI/CSV出力）
- [ ] モバイルアプリ（React Native）
- [ ] Slack/Teams 通知（週次レポート自動送信）
- [ ] SFA完全統合（Salesforce/HubSpot連携）

---

## 参考

- [設計書](Calendar/inbox/法人ターゲット抽出アプリ_設計書_v_1_（無料データ／csv出力） (2).md)
- [AGENTS.md](./AGENTS.md) - エージェント運用ガイド
- [CLAUDE.md](./CLAUDE.md) - Claude Code 設定

## 技術参考リンク

### アーキテクチャ
- [FastAPI + Next.js + PostgreSQL Boilerplate](https://github.com/Nneji123/fastapi-nextjs)
- [Next.js vs FastAPI for Modern SaaS](https://nightcoders.id/blogs/next-js-vs-fastapi-for-modern-saas-the-perfect-stack-for-mvps)
- [Deploying Next.js, FastAPI, and PostgreSQL in 2025](https://medium.com/@zafarobad/ultimate-guide-to-deploying-next-js-d57ab72f6ba6)

### 生成AI
- [OpenAI Structured Outputs Documentation](https://platform.openai.com/docs/guides/structured-outputs)
- [JSON Schema for LLMs Complete Guide](https://superjson.ai/blog/2025-08-17-json-schema-structured-output-apis-complete-guide/)

### スクレイピング
- [Web Scraping Legal Issues 2025](https://groupbwt.com/blog/is-web-scraping-legal/)
- [Robots.txt Scraping Compliance Guide](https://www.promptcloud.com/blog/robots-txt-scraping-compliance-guide/)
- [Ethical Web Scraping Guide](https://scrapingapi.ai/blog/ethical-web-scraping)

### Celery
- [Celery Configuration & Integration](https://deepwiki.com/fastapi-practices/fastapi_best_architecture/6.1-celery-configuration-and-integration)

---

## 優先度判定マーカー凡例

| マーカー | 意味 | 効果 |
|---------|------|------|
| `[feature:security]` | セキュリティ重要機能 | セキュリティチェックリスト表示 |
| `[feature:a11y]` | UI/アクセシビリティ | a11y チェック推奨 |
| `[feature:tdd]` | ビジネスロジック | TDD 推奨 |

---

**生成日**: 2025-12-28
**計画作成**: Claude Code (Sonnet 4.5)
