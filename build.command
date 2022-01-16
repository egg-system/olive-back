# デプロイ用のソースコードを作成するためのバッチ
cd `dirname $0`
rm -rf src/public/assets/javascripts/webpack
mkdir src/public/assets/javascripts/webpack
yarn install
yarn prod
zip src.zip -r src/* src/.[^.]* -x src/.env src/tmp/\* src/log/\*
