# 📥 inbox処理フロー（Calendar/inbox）

**実行タイミング**: 週1回（日曜夜 / 10〜30分）

---

## 🎯 目的
入口（`Calendar/inbox/`）を軽く保ち、情報を `Atlas/` または `Efforts/` に流す。

---

## ✅ 推奨フロー（最小）
1. `/inbox-review` で提案だけ確認（任意）
2. `/organize-input` を**1回だけ**回す（移動まで実行）
3. 迷ったものは残す（`Calendar/inbox/` のまま）

---

## 🧭 振り分け判定（ACE）
- 今週〜今月だけ使う / まだ迷う → `Calendar/inbox/`
- 3ヶ月後も参照する知識 → `Atlas/`
- 期限あり/進行中（プロジェクト） → `Efforts/`
- 完了/不要/保管 → `Efforts/archived/`
- 成果物（手順書/納品物の参照版） → `Atlas/`（正本は `Finals(OneDrive)` 等に置いてリンク）

---

## Atlas に入れる時（MOCルール）
- `Atlas/` はフラット運用（サブフォルダは増やさない）
- 追加したら `Atlas/🗺️ Atlas-MOC.md` か該当MOC（`Atlas/_AI-MOC.md` など）へ1リンク追加

## Projects に入れる時
- 既存: `Efforts/<project>/`
- 新規: `/project-init <project> <status>` で `00-概要.md` を作ってから入れる

---

## ✅ チェックリスト
- [ ] `Calendar/inbox/` のファイル数が10件以下
- [ ] `Atlas` に移したノートをMOCにリンク
- [ ] `Efforts/*/00-概要.md`（`archived/` 除く）の「次の一手」を更新（必要なら）

---

**最終更新**: 2025-12-25
