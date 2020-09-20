# RunPowerShell
cmd.exeからPowerShellを実行する4の方法を整理した。

> 参考: [cmd.exeからPowerShellを実行する4の方法](https://senooken.jp/blog/2019/07/07/)

以下の環境で動作を確認した。

* Widnows 7
* Windows 10

以下の2ファイルにサンプルコードを掲載している。

1. ps-cmd.cmd
2. ps-self.cmd

これらのファイルを実行すると，それぞれ以下の内容が表示される。

* ps-cmd.cmd: `argument, stdin, file, file, file`
* ps-self.cmd: `powershell`

cmd.exeからPowerShellを実行する方法は大きく以下の3通りが存在する (ps-cmd.cmd)。

1. コマンド引数
2. 標準入力
3. ファイル

それぞれ，コマンド引数や標準入力からPowerShellコードを引き渡すことで，実現可能だ。

3番目のファイルを使った実行方法を応用して，PowerShellコードを記述した単独ファイルの実行 (4. 単独ファイル) が4番目の方法だ (ps-self.cmd)。

仕組み自体は，「[シバンなしファイルでのスクリプト系言語のインタープリターの実行](https://senooken.jp/blog/2019/06/16/)」と同様だ。

つまり，ファイル内の2行目以降の内容をインタープリターであるPowerShellに渡して，シェルであるcmd.exe自体は即座に終了させる。

これにより，PowerShellのセキュリティガードを気にせず，powershellスクリプトの実行が可能となる。
