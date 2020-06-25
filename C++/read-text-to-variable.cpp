////////////////////////////////////////////////////////////////////////////////
/// \file      read-text-to-variable.cpp
/// \author    SENOO, Ken
/// \copyright CC0
/// \sa        https://senooken.jp/post/2020/07/10/
/// \brief     C++での変数へのテキストデータの一括読み込み
////////////////////////////////////////////////////////////////////////////////

/**
C++での変数へのテキストデータの一括読み込み方法を検討した。

基本的に，`<string>` で定義されている `std::getline()` を使う。

具体的には以下の2通りの方法を記した。

1. 改行区切りで1行ずつ読み込んで`std::vector`に格納
2. 区切り文字を文字列の終端 (NULL文字) に指定し，データ全体を丸ごと文字列として変数に格納

`std::getline()`の第1引数に，入力対象に応じた以下のオブジェクトを指定することで，必要なケースに対応できる。

- 標準入力: `std::cin`
- ファイル: `std::fstream ifs("file")`
- テキスト: `std::stringstream ss("string")`

こちらのサンプルは，コンパイルして実行すると1-3の数字を1文字ずつ順番に1行ずつ出力する。

*/

#include <iostream>
#include <sstream>
#include <string>
#include <vector>

int main(void) {
  std::string data = "1\n2\n3\n";

  // Read data to line breaked vector.
  std::stringstream input;
  input.str(data);
  std::vector<std::string> v;
  for (std::string line; std::getline(input, line);) {
    v.push_back(line);
  }
  for (auto& e : v) std::cout << e << "\n";

  // Read whole data to string.
  input.clear();
  input.str(data);
  std::string str;
  std::getline(input, str, '\0');
  std::cout << str;

  return 0;
}

