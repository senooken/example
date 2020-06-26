////////////////////////////////////////////////////////////////////////////////
/// \file      read-csv-to-vector.cpp
/// \author    SENOO, Ken
/// \copyright CC0
/// \sa        https://senooken.jp/post/2020/07/15/
/// \brief     C++での`std::vector`へのCSVデータの読み込み
////////////////////////////////////////////////////////////////////////////////

#include <iostream>
#include <sstream>
#include <string>
#include <vector>

int main(void) {
  std::stringstream input("11,12,13\n21,22,23\n31,32,33\n");
  std::vector<std::vector<std::string>> vv;

  for (std::string value; std::getline(input, value);) {
    vv.push_back(std::vector<std::string>());
    for (std::stringstream ss(value); std::getline(ss, value, ',');) {
      vv[vv.size()-1].push_back(value);
    }
  }

  for (auto& v : vv) {
    for (auto& e : v) std::cout << " " << e ;
    std::cout << "\n";
  }

  return 0;
}
