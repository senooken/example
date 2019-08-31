# FORTRAN 77 to Fortran 90
FORTRAN 77のソースファイルのFortran 90への変換ツールを検証する。

詳細な経緯はブログ「[Summary of Fortran 77 to 90 converter](https://senooken.jp/blog/2014/08/08/)」に記している。

- FORTRAN.F: 変換元FORTRAN 77ソースファイル
- fortran_tools.f90: fortran_toolsによる変換結果
- f2f.f90: f2fによる変換結果
- fortran_tools: Python製の変換ツール[fortran_tools](https://github.com/arktools/fortran_tools)を格納
- f2f/: Perl製の変換ツール[f2f](https://bitbucket.org/lemonlab/f2f/)を格納

## 観点
FORTRAN 77からFortran 90への変換では，以下の項目に注目する。

1. コメント文字: `C`の`!`への変換
2. 継続行: 6列目の`0`とスペース ` ` 以外の文字の配置を行末の`&`に変換
3. DO文の終端: CONTINUEからEND DOへ変換
4. インデント: FORTRAN 77では7列目から記述が始まるのでこのインデントの変更
5. 比較演算子: .EQ., .NE., .LT., .LE., .GT., .GE.を対応する記号に変換
6. 日本語対応: ソースファイル内の日本語を文字化けさせずに変換

## コンパイル方法
変換元の検証用ソースコードは前述の6の観点を確認できるようなソースコードとなっている。

レガシー感を出すため，英字を大文字にしている。

以下のコマンドでコンパイルし，実行できる。

```
gfortran -o FORTRAN.exe FORTRAN.F && ./FORTRAN.exe
```

以下の内容が標準出力に出力される。

```
 CONVERSION EXAMPLE FOR FORTRAN 77 TO Fortran 90.
 FORTRAN 77からFortran 90への変換例
 ①文字化け (CP932) チェック
 LINE CONTINUATION, 継続行のテスト
 1行72バイト。漢字に注意。
 行継続は6桁目に0と空白以外を配置。
 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
           2
```

日本語文字エンコーディングの検証のため，文字化けする可能性がある。ファイルにリダイレクトすると，文字化けせずに表示を確認できるだろう。

## チェックアウト
変換ツールが万が一，配布終了した場合に備えて，配布ツールを同梱している。

以下のコマンドでサブモジュールを更新することで，アクセスする。

```
git submodule update --init fortran_tools
git -C fortran_tools checkout master
```

確認に使用する変換ツールのコミットは，作業時の最新版である以下を採用した。

- fortran_tools: a4749bec40a7577c22283eb2694345bee8e179e3
- f2f: d45131973e832eaf30e03c6189294544532e2f4d

## 変換
FORTRAN 77コードのFortran 90コードへの変換は，変換ツールを使って以下のコマンドで変換できる。

```
chmod +x f2f/f2f.pl
./f2f/f2f.pl --tab 2 --base-indent 0 FORTRAN.F f2f.f90
perl ./f2f/f2f.pl --tab 2 --base-indent 0 FORTRAN.F f2f.f90
python fortran_tools/fortran_tools/fixed2free.py fortran_tools.f90
```

それぞれ共通で，第1引数に入力ファイルを指定して，第2引数で出力ファイルを指定する。

f2fは出力ファイルを指定しなければ，標準出力に変換結果を出力する。そのため，以下のようにリダイレクトしてファイルに出力することもできる。

```
./f2f/f2f.pl --tab 2 --base-indent 0 FORTRAN.F >f2f.90
```

f2fにはオプションが存在しており，`f2f.pl --help` または `f2f.pl --usage` でオプションの一覧を確認できる。

`f2f.pl --help` と `f2f.pl --usage` の内容はほぼ同一であるため，コンパクトな `f2f.pl --usage` の表示結果を以下に掲載する。

```
Usage:
        f2f SOURCE.FOR dest.f90

Usage:
     Usage: f2f [source [destination]]
         --tab <n>               Converts tabs to <n> spaces, indents
                                 <n> spaces per level (default: 4)
         --base-indent <n>       Sets initial indent level to <n>
                                 (default: 1)
         --dp-to-star-kind <n>   Convert DOUBLE PRECISION to
                                 REAL*<dp-to-star-kind>
                                 (no default)
         --dp-to-kind <str>      Convert DOUBLE PRECISION to
                                 REAL (KIND=<dp-to-kind>)
                                 (no default)
         --suffix-includes <str> Adds suffix <str> to file names listed
                                 in INCLUDE statements (no default)
         --verbose               Show information about code progress
         --help                  Displays this message
         --usage                 Displays program usage statement
         --version               Shows version info
```

`f2f.pl` では，特に以下の2種類のオプションが便利だ。

- --tab <n>: タブとインデントを<n>個のスペースに変換 (既定4)。
- --base-indent <n>: インデントレベルを<n>に指定 (既定1)。

`--tab` オプションは，オプション名だけだとわかりにくいが，タブだけでなく，インデントを指定したスペースに変換する。デフォルトはPythonと同じ4となっている。
自分のコーディング規約に応じて，必要に応じて `--tab 2` などに変更するとよいだろう。

FORTRAN 77コードは，7列目から記述が始まる (固定形式) ため，デフォルトでインデントが存在していることになる。

Fortran 90以降の自由形式に変換する場合，デフォルトのインデントは不要になるため，`--base-indent 0` を指定したほうがいいだろう。

## 変換結果
変換結果の`fortran_tools.f90`と`f2f.f90`を見比べる。

`fortran_tools.f90` では，以下の項目が変換できていない。

- do文の終端のcontinueがend doへの変換
- 比較演算子 (.EQ., .LT.) の変換

その他，意図しない以下の変換が行われていた。

- .AND.の.and.への小文字化
- if文内の丸括弧の削除

一方， `f2f.f90` は基本的に期待していた変換が一通りなされている。

しかし，以下2点の予期しない変換が行われていた。

- 冒頭のコメントブロックで2列名が空白に置換
- プログラム末尾の`END` が `END PROGRAM` に変換

`f2f` は必要な変換が一通りなされているものの，一部期待しない結果となっている。

この結果を判断して，使用する。あるいは，自作するのもありだろう。

