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
 * Check if same value.
 * @param {Object} object1 - Target object1.
 * @param {Object} object2 - Target object2.
 * @return {boolean} True if both of objects are same value, otherwise false.
 */
function equal(object1, object2) {
  if (typeof object1 !== 'object' || typeof object2 !== 'object') {
    return object1 === object2;
  } else if (Object.keys(object1).length !== Object.keys(object2).length) {
    return false;
  } else if (object1 === object2) {
    return true;
  }
  for (const key in object1) {
    if (!(key in object2)) {
      return false;
    }
    if (typeof object1[key] === 'object' && typeof object2[key] === 'object') {
      if (!this.equal(object1[key], object2[key])) {
        return false;
      }
    } else if (object1[key] !== object2[key]) {
      return false;
    }
  }
  return true;
}
