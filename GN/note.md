GNのリポジトリー: https://gn.googlesource.com/gn/


<p>コマンドを実行するとエラーが出た。</p>

<pre><code>gn gen out/</code></pre>
<pre><samp>gn.py: Could not find checkout in any parent of the current path.
This must be run inside a checkout.</samp></pre>

<p>似たような質問があった。</p>

selenium chromedriver - How to build with targets with Google Chromium GN? - Stack Overflow
https://stackoverflow.com/questions/42729479/how-to-build-with-targets-with-google-chromium-gn 

こちらのドキュメントに記載があった。

https://gn.googlesource.com/gn/+/master/docs/standalone.md

どうやらルートディレクトリーに.gnが必要なようだ。

Chromiumのビルド以外で、単独でGNを使う場合は、こちらのセットを参考にする。

https://gn.googlesource.com/gn/+/master/tools/gn/example


まず最初にインストールしないといけない。

https://qiita.com/taktod/items/1fb3bb665643f96363c3



```
git clone https://gn.googlesource.com/gn
cd gn
python build/gen.py
ninja -C out
# To run tests:
out/gn_unittests
```

build/gen.pyで-std=c++14のオプションがある。古いGCCだとコンパイルエラーが出るので、c++11に変更する。

C++14が有効なclang++が必要。変更してもダメだった。いったん保留にする。
