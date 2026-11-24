import Foundation

func gridLenPx(_ s: Any = Optional<Any>.none as Any) -> Any? {
  let s = specString(s)
  if specTruthy(regexTest(s, "^[0-9.]+px$")) {
    return (specNum(regexReplace(s, "px$", "")) * 1.0)
  }
  return -1.0
}
