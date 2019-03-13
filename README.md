# olive-back
## サロンシステム
### 環境のbuild手順
- 下記を参照
   - https://github.com/egg-system/olive-back/wiki/%E7%92%B0%E5%A2%83%E3%81%AEbuild%E6%89%8B%E9%A0%86
#### 環境のbuildは一度のみの実行すればいい
#### build時にエラーが出た場合は下記を実行して、バグの原因を探る
- エラーログを探る
    - docker logs olive-app
- コンテナ内に入って、バグの原因を探る
    - docker-compose run rails bash

### 環境の起動
- `docker-compose up -d`を入力
- `localhost:8080`でアクセス可能
  - ポートフォワーディングにより、ポートは変更可能
  - dockerの詳細は下記を参照
    - https://github.com/egg-system/olive-back/wiki/docker%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

### 各種コマンド
- bundleの更新
   - docker-compose run rails bundle install

- 各種 railsコマンドの実行
   - コンテナ内に入る
      - docker exec -it olive-app bash
   - その後、任意のコマンドを実行

- 再起動方法
   - docker exec -it olive-app rails restart

- binding.pryの方法
   - docker attach olive-app
   - 何も描画されない場合はエンターキーを押下
   - 抜ける際は `ctrl + p` `ctrl + q`
      - `ctrl + c` だとコンテナも止まってしまう

### トラブルシューティングページ
- https://github.com/egg-system/olive-back/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0
