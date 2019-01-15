# olive-back
## サロンシステム
### 環境のbuild手順
- dockerのターミナルを起動
- ターミナルで、レポジトリのルートに移動 
- `docker-compose build`を入力
- コンテナが作成される

### 環境の起動
- `docker-compose up -d`を入力
- `localhost:8080`でアクセス可能
  - ポートフォワーディングにより、ポートは変更可能
  - dockerの詳細は下記を参照
    - https://github.com/egg-system/olive-back/wiki/docker%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6