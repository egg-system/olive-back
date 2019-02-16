# olive-back
## サロンシステム
### 環境のbuild手順
- 下記を参照
   - https://github.com/egg-system/olive-back/wiki/%E7%92%B0%E5%A2%83%E3%81%AEbuild%E6%89%8B%E9%A0%86
#### 環境のbuildは一度のみの実行すればいい

### 環境の起動
- `docker-compose up -d`を入力
- `localhost:8080`でアクセス可能
  - ポートフォワーディングにより、ポートは変更可能
  - dockerの詳細は下記を参照
    - https://github.com/egg-system/olive-back/wiki/docker%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

### 各種コマンド
- bundleの更新
   - docker-compose run rails bundle install

- 各種 railsコマンドの実装
   - コンテナ内に入る
      - docker exec -it olive-app bash
   - その後、任意のコマンドを実行
   
