# APT Partial Upgrade

## Introduction
Ubuntuを始めとするDebian系のLinuxディストリビューションが採用しているパッケージマネージャーのAPTによるパッケージの更新を工夫する。

> 参考: [APTによるパッケージの部分アップグレード](https://senooken.jp/blog/2019/10/05/)

`apt upgrade` を単に実行すると全パッケージを更新する。 この方法には以下2点の問題が存在する。

1. いずれかのパッケージの更新に失敗すると，他のパッケージの更新もされない。
2. 更新が大量にある場合，更新に時間がかかる。

そのため，これらの問題を解消するために，以下の手順を踏む。

1. 一度パッケージ更新対象リストを出力。
2. パッケージごとに `apt install` を実行し，個別に更新。

これにより，以下の3点の利点が生まれる。

1. いずれかのパッケージの更新に失敗しても，他のパッケージの更新が可能。
2. 更新の中断・再開が可能。
3. リストの修正により更新対象のカスタマイズが可能。

## Usage
パッケージマネージャーにAPTを採用しているDebian系OSで動作し，以下のコマンドで実行する。

```
./apt-partial-upgrade.sh
```

このコマンドを実行すると，以下の2ファイルを出力する。

- apt-upgrade.log: `apt upgrade` の出力結果。
- package-list.log: `apt-upgrade.log` の更新対象パッケージを1行ごとにした整形結果。

`apt install` を `apt upgrade` の更新対象パッケージごとに実行し，パッケージを更新する。

コマンドの実行結果としては， `sudo apt upgrade -y` と同じになる。

なお，x86_64アーキテクチャを想定しており，不要なはずのi386のパッケージをアンインストールする。

更新対象パッケージをカスタマイズする場合，`Upgrade package and uinstall i386 package.` が表示されている最中に，C-cで `apt-partial-upgrade.sh` を中断し， `package-list.log` を修正する。

その後， `apt-partial-upgrade.sh` の最後のwhile文以外をコメントアウトして，while文から実行する。
