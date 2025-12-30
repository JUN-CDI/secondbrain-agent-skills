# SSHキー管理

## 概要
GitHub認証用のSSHキーの管理情報

## キー情報
- **キータイプ**: ed25519
- **メールアドレス**: js.24home@gmail.com
- **生成日**: 2025-12-21
- **ローカル保存場所**: `~/.ssh/id_ed25519`

## 公開鍵
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHr15Oq7mB9rmIAJHy1jBstkJ826YNSDGlVit2pbHdAW js.24home@gmail.com
```

## GitHub登録状況
- ✅ GitHubに登録済み
- 登録URL: https://github.com/settings/keys

## バックアップ保存場所
⚠️ **重要**: 秘密鍵のバックアップは以下の安全な場所に保存してください

- [ ] パスワードマネージャー（例: 1Password、Bitwarden）
- [ ] 暗号化USBドライブ
- [ ] その他の安全な場所: ________________

**注意**: 
- 秘密鍵（`id_ed25519`）は機密情報です
- iCloud同期フォルダやGitリポジトリには保存しないでください
- バックアップも同様に安全に管理してください

## 再生成が必要な場合
秘密鍵を失った場合は、以下を実行：
1. 新しいSSHキーを生成: `ssh-keygen -t ed25519 -C "js.24home@gmail.com"`
2. 新しい公開鍵をGitHubに登録
3. 古い公開鍵をGitHubから削除
