# デプロイ用のソースコードを作成するためのバッチ
cd `dirname $0`
rm -rf src/tmp
zip src.zip -r src/* src/.[^.]*