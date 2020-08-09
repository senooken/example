# Apache HTTP Serverでの常時HTTPS化の設定

## 内容
- `.htaccess`: `.htaccess` での設定例
- `httpd.conf`: `httpd.conf` での設定例
- `README.md`: このファイル

## 概要
Apache HTTP Serverでの常時HTTPS化の設定を記す。

詳細は，「[Apache HTTP Serverでの常時SSL/HTTPS化の設定](https://senooken.jp/post/2020/09/30/)」で解説している。

基本的な方針としては以下の2点となる。

1. HTTPSでの接続時にHSTS (HTTP Strict Transport Security) ヘッダーを応答
2. HTTPでの接続時にHTTPSへリダイレクト

2のHTTPSへのリダレクト時には，Let's Encryptでの公開鍵証明書の発行で `/.well-known` へのHTTPアクセスが必要となるため，こちらへのアクセスはリダイレクト対象から除外している。

基本的な設定は `httpd.conf` でも `.htaccess` でも共通で以下となっている。

```
<If "%{HTTPS} == 'on'">
  <IfModule headers_module>
    Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
  </IfModule>
</If>
<ElseIf "%{REQUEST_URI} !~ m#^/.well-known#">
  <IfModule rewrite_module>
    RewriteEngine On
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI}?%{QUERY_STRING} [L,R=301]
  </IfModule>
</ElseIf>
```

`.htaccess` で有効にするには，冒頭でコメントアウトしている以下の2点の指令を `httpd.conf` で指定しておく。

1. `LoadModule` 指令を指定
2. `AlloOverride FileInfo` で上書きの許可

