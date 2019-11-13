# デプロイ用のソースコードを作成するためのバッチ
cd `dirname $0`
zip src.zip -r src/* src/.[^.]* -x src/.env src/tmp/\*