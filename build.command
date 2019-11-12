# デプロイ用のソースコードを作成するためのバッチ
cd `dirname $0`
mv src/.env src/_.env
rm -rf src/tmp
zip src.zip -r src/* src/.[^.]*
mv src/_.env src/.env