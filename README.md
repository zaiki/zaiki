# 吉田寮資料集「在寮期限」の到来からその終結へ 1985-90

打ち込み始めました。  
文責　資料集を電子的に公刊する会（仮）

## 打ち込み方針
* マークアップはマークダウンを用いる。方言は利用しない。表現不足はHTMLタグを直接書くことで補う。
* 打ち込み者による注釈やコメントはHTMLにおけるコメントタグを使う。
* ファイル名は「p（ページ数）\_（タイトル）.（拡張子）」に統一する。例えば「p579\_編集後記.md」

## HTMLへの変換
[pandoc](http://johnmacfarlane.net/pandoc/)を使おう！

```
pandoc example.md -o example.html
pandoc -s example.md -o example.html
```

[rake](https://github.com/ruby/rake)をインストールしてください。
```
gem install bundler
bundle install
```
あるいは
```
gem install rake
```

以下のコマンドでhtmlが生成されます。
```
rake configure
rake 
```