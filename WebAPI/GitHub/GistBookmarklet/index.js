////////////////////////////////////////////////////////////////////////////////
/// \file      index.js
/// \author    SENOO, Ken
/// \copyright CC0
/// \version   0.0.0
/// \date      Created: 2020-01-21T12:20+09:00
/// \sa        https://senooken.jp/post/2020/02/05/
/// \brief     Webブラウザー上で現在の選択範囲をGistに登録するブックマークレット
///
/// Web APIの学習として，「Software Design 2018年3月号」のp. 18-31「第1章 そもそもWeb APIとは何か」の特集記事で紹介されているサンプルコードをほぼ書き写した。
///
/// # Usage
/// GitHubの[個人設定ページ](https://github.com/settings/tokens)で，[Select scopes]>[☑gist] を選択して [Generate new token] を選択する。
///
/// これにより得られるアクセストークンを，このコードの'YOUR_TOKEN'と差し替えて，token変数に指定する。
///
/// その後，「[ブックマークレット作成](https://crocro.com/tools/item/gen_bookmarklet.html)」ページで，先頭1行目に `// title:(gist)` と記入して，このファイルの内容を全て貼り付ける。
///
/// [ブックマークレット作成] を選択すると，[ブックマークレット] 欄に [gist] と書かれたリンクができる。これをブックマークツールバーにドラッグ・ドロップで登録する。
/// その後は，Gistに登録したい内容をWebブラウザー上で範囲選択して，登録したブックマークレットを選択する。[File name?] のダイアログが表示されるので，Gistに登録するファイル名 (初期値: index.js) を記入する。
///
/// 登録に成功すると，[Open URL?] のダイアログが表示されるので，登録先を見たければ [OK] を選択して，そうでなければ [Cancel] を選択する。
////////////////////////////////////////////////////////////////////////////////

"use strict";

// API info.
let token = 'YOUR_TOKEN';
let url = 'https://api.github.com/gists';

// Target data.
let content = window.getSelection().toString();
let fileName = prompt('File name?', 'index.js');

// JSON.
let json = {
  "description": 'Code that was on ' + location.href + '.',
  'public': true,
  'files': {}
};
json.files[fileName] = {
  'content': content
};

// HTTP request.
let xhr = new XMLHttpRequest();
xhr.open('POST', url);
xhr.setRequestHeader('Authorization', 'token ' + token);
xhr.send(JSON.stringify(json));

xhr.onload = function() {
  if ((200 <= xhr.status) && (xhr.status < 400)) {
    var json = JSON.parse(xhr.response);
    if (confirm('Open URL?')) {
      window.open(json.html_url, '_blank');
    }
  } else {
    alert('Error occurred' + xhr.response);
  }
};
