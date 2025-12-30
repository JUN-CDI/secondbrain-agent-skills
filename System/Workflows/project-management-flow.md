# 🎯 プロジェクト管理フロー（Vaultは運用ノート / 実装はWorkspaces）

**実行タイミング**: プロジェクト開始時、週次レビュー、完了時

---

## 原則
- **コード/実装**: `~/Workspaces/projects/<project>/`（Git管理）
- **Vault**: `Efforts/<project>/`（目的/意思決定/ログ/参照リンク）
- **Vaultのフォルダは深くしない**（必要になってから増やす）

---

## ✅ 開始（おすすめ）
1. ローカルRepo作成: `/dev-init <project> [type]`
2. Vault入口作成: `/project-init <project> <status>`
   - 作られる: `Efforts/<project>/00-概要.md`
3. `00-概要.md` に「Repoパス」「GitHub URL」「次の一手」を書く

---

## 🔁 進行中（最小）
- 会話/意思決定/会議メモは `Efforts/<project>/YYYY-MM-DD-...md`
- 進捗は `00-概要.md` の `status` と「次の一手」だけ更新すればOK

---

## ✅ 完了
1. Vault: `Efforts/<project>/` → `Efforts/archived/<project>/`
2. 成果物: `Finals(OneDrive)` に正本を保存し、Vault側は「リンク/注記」だけ残す（再利用できる手順は `Atlas/`）
3. 引き継ぎ: repo直下 `handoff.md` を正にする（終了時は `wrapup`（推奨）/ `endwork`（最小））。`docs/HANDOFF.md` は任意の補助（長文用）。

---

## 📊 Dataview（例）
```dataview
TABLE status, workspace
FROM "Efforts"
WHERE file.name = "00-概要" AND !contains(file.path, "archived/")
SORT status ASC, file.folder ASC
```

---

**最終更新**: 2025-12-25
