# Apacheの変数の表示方法
## 概要
Apache HTTP Server (httpd) での変数の表示方法を整理した。

[ブログ](https://senooken.jp/post/2020/09/11/)に詳細を記している。

httpd v2.4.39で確認した。

## ファイル
ディレクトリー内に以下のファイルを格納している。

- README.md: 説明。
- `.htaccess`: `.htaccess`での設定例
- `variable.html`: ローカルサーバー (<https://localhost:8443/variable?q1=query1&q2=query2#id>) へのアクセス時の変数一覧

## 方法
Apacheでの変数の表示には，以下の3種類の方法がある。

1. `RewriteRule` 指令
2. `Header` 指令
3. `ErrorDocument` 指令

これらの3種類での変数の表示例を `.htaccess` に記した。 それぞれ以下のURLにアクセスすることで，確認できる。

- `/rewrite`: `RewriteRule` 指令の例
- `/redirect`: `Redirect` 指令の例 (失敗例)
- `/variable`: `ErrorDocument` 指令の例 (全変数)

`Header` 指令だけ全ページで確認できる。Webブラウザー (例: Firefox) の開発者ツールで [Network] から1行目を選び，[Headers] タブ>[Response Headers]>[Variable] を確認する。

その他，`ErrorDocument` 指令だけApacheの全標準変数の表示例を記している。

この中では，`ErrorDocument` 指令を使うと変数の表示をHTMLで自由に指定できるため，最も柔軟性が高い。

なお，`.htaccess` でこれらの指令を使用するために，`httpd.conf`で事前に `AllowOverride FileInfo` を指定しておく必要がある。
