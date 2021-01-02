//////////////////////////////////////////////////////////////////////////////
/// \file      equal.js
/// \author    SENOO, Ken
/// \copyright CC0
/// \version   0.0.0
/// \date      Created: 2021-01-02T22:18+09:00
/// \sa        https://senooken.jp/post/2021/01/10/
//////////////////////////////////////////////////////////////////////////////

"use strict";

/**
 * データが同じ値であることを確認する。
 * @param {Object} object1 - 比較対象オブジェクト1。
 * @param {Object} object2 - 比較対象オブジェクト2。
 * @return {boolean} データが同じ値であればtrue、それ以外はfalseを返す。
 */
function equal(object1, object2) {
  if (typeof object1 !== 'object') {
    return object1 === object2;
  } else if (object1 === object2) {
    return true;
  }
  for (const key in object1) {
    if (!(key in object2)) {
      return false;
    }
    if (typeof object1[key] === 'object') {
      if (!this.equal(object1[key], object2[key])) {
        return false;
      }
    } else if (object1[key] !== object2[key]) {
      return false;
    }
  }
  return true;
}
