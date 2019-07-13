<?php
## \file array-access-with-unquoted-strings.php
## \author SENOO, Ken
## \copyright CC0
## \date Created date: 2019-07-13
## \sa https://senooken.jp/blog/2019/07/13/
## \brief `$foo[bar]` の記法によるエラー出力の違いを記す。
##
## `$foo[bar]` の記法 (未定義定数barの使用) はPHP 7.2.0未満では，E_NOTICEのエラーが出力され，PHP 7.2.0以上ではE_WARNINGのエラーが出力される。
##
## E_WARNINGは既定のエラーレベルに存在するため，今まで問題なかったPHPコードが，PHPのバージョンアップにより，問題を出すようになった。

$foo = array("bar" => "bar");
echo $foo["bar"] . "\n";

echo $foo[bar] . "\n";
## PHP 7.2.0以上の場合，既定のエラーレベルに存在するE_WARNINGにより，ここで以下のエラーが出力される。
##
## ```
## Warning: Use of undefined constant bar - assumed 'bar' in /home/senooken/project/example/PHP/array-access-without-quotation.php on line 16
## ```

error_reporting(E_NOTICE);
echo $foo[bar] . "\n";
## PHP 7.2.0未満の場合，E_NOTICEの有効により，ここで以下のエラーが出力される。
##
## ```
## Notice: Use of undefined constant bar - assumed 'bar' in /home/senooken/project/example/PHP/array-access-without-quotation.php on line 24
## ```

## 以下のようにE_WARNINGをオフにすれば，PHP 7.2.0以上で `$foo[bar]` によるエラー出力を抑制できる。
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING);
echo $foo[bar] . "\n";

## ただし，PHP 8.0.0以上では `$foo[bar]` の記法はエラー扱いになることが予告されているので，この対応は悪い。
##
## 素直に，`$foo[bar]` を `$foo['bar']` のように，配列添字を一重引用符または二重引用符で囲んだリテラル値にすべきだろう。

