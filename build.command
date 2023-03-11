# デプロイ用のソースコードを作成するためのバッチ
cd `dirname $0`
rm -rf src/public/assets/javascripts/webpack
mkdir src/public/assets/javascripts/webpack
yarn install
yarn prod
cd src
zip ../src.zip -r * .[^.]* -x .env tmp/\* log/\dev-*
