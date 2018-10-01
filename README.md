# review-docker

[Re:VIEW](https://github.com/kmuto/review) を Docker 環境で動かすための Makefile テンプレート。

## 特徴

- **Gem、rake 等を使いません**
  - 代わりに Docker と make を使って環境を構築します
- **Mac、Windows、Linux どれでも動きます**
  - Re:VIEW は Docker で動かしています
- **Docker のコンテナが増殖しません**
  - Docker の `--rm` オプションをつけているのでコンテナを使い終わったら破棄しています
- **どのディレクトリでも簡単に Re:VIEW が使えます**
  - この Makefile を Re:VIEW をつかたいところに配置すれば Docker コンテナを用意できます
  - これは、Docker の `-v "$(pwd):/tmp"` を使用しているためです

## 必要なもの

- [Docker](https://docs.docker.com/install/#supported-platforms)
- [make](https://www.gnu.org/software/make/)
  - version == 3.81

## コマンド

### `make install`

- **Re:VIEW の Docker Image がない場合は必ず実行してください**
  - 確認方法 `docker images | grep vvakame/review`
- Re:VIEW の Docker Image をダウンロードします
- Makefile 内の `REVIEW_VERIOSN` を変更した際は必ず実行してください

### `make bash`

- vvakame/review イメージを bash で実行します

### `make review-init DOC=<ドキュメント名>`

- Re:VIEW のドキュメントを作成します

### `make review-pdfmaker DOC=<ドキュメント名>`

- PDF でドキュメントを書き出します

### `make review-epubmaker DOC=<ドキュメント名>`

- EPUB でドキュメントを書き出します

### `make review-textmaker DOC=<ドキュメント名>`

- テキストでドキュメントを書き出します

### `make review-compile DOC=<ドキュメント名> FMT=<フォーマット>`

- ドキュメントを指定したフォーマットで書き出す
- `<ドキュメント名>/<ドキュメント名>.<フォーマット>` で書き出される
