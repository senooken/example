command -p tail -n +2 "$0" | command -p ${1?Set interpreter (ex: php, perl, python, ruby etc) to 1st argument.} ${1+"$@"}; exit $?
## \file interpreter.sh
## \authore SENOO, Ken
## \copyright CC0
## \sa https://senooken.jp/blog/2019/06/16/
## \date Created date: 2019-06-16 Sun
## \version 0.0.0

## \brief シバン無しでファイル名でスクリプト系言語のインタープリターの実行する。

## このサンプルは，以下のようにプログラムの第1引数に実行したインタープリターを指定してファイル名で実行する。

## ```
## ./intepreter.sh php
## ```

## これにより，指定したインタープリターでプログラムが実行される。中身は全てコメントなので，何も表示されない。

## 実際には，以下のように冒頭の1行目の `command -p` の直後に実行したいインタープリターを記入して使うことになるだろう。

## ```
## command -p tail -n +2 "$0" | command -p php ${1+"$@"}; exit $?
## ```

## 仕組みとしては，`command -p tail -n +2 "$0" によりファイルの2行目以降を抽出し，インタープリターにパイプで渡す。

## これにより，シバン (shebang, #!/bin/sh) がなくてもファイル名でインタープリター (php, perl, python, rubyなど) を実行できる。

## これの利点は以下の4点だ。

## 1. どのインタープリターでも同じ書き方で対応可能。
## 2. /bin/shが存在しないOS (Andorid) でも対応可能。
## 3. command -pにより実行することで，仮にPATH環境変数が空でも実行可能性上昇。
## 4. 2個以上の複雑な引数も引き渡し可能。

## 逆に，欠点は以下2点だ。

## 1. POSIX準拠シェルが存在しないと実行不可能 (標準Windowsでは実行不可能)。
## 2. インタープリターでファイルを指定して実行する場合に構文エラー。

## 特に，2番目の欠点の影響が大きい。

## 私見としては，インタープリター言語の開発には，シバンを付けないほうがよいだろう。シバンを指定する限り，移植可能性の問題を解決できない。

## そもそも，[POSIX上](http://pubs.opengroup.org/onlinepubs/9699919799.2018edition/)に以下の記載がある限り，シバンが存在するとシェルの動作結果は不定となる。

## > 1. The shell reads its input from a file (see sh), from the -c option or from the system() and popen() functions defined in the System Interfaces volume of POSIX.1-2017. If the first line of a file of shell commands starts with the characters "#!", the results are unspecified.

## ファイル名で実行したい場合，パッケージングでバイナリー形式にして配布したほうがよいだろう。
