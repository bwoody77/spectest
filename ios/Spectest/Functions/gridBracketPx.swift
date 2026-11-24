import Foundation

func gridBracketPx(_ cols: Any = Optional<Any>.none as Any, _ all: Any = Optional<Any>.none as Any, _ on: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  let all = specArr(all)
  let on = (on as? Bool) ?? false
  if !(on) {
    return 0.0
  }
  return specArr(gridSizedCols(cols, all)).reduce(0.0) { { (acc, c) in specAdd(specAdd(acc, (specTruthy(specAnd(specGet(c, "_gFirst"), !(specTruthy(specGet(c, "_gSolo"))))) ? 1.0 : 0.0)), (specTruthy(specAnd(specGet(c, "_gLast"), !(specTruthy(specGet(c, "_gSolo"))))) ? 1.0 : 0.0)) }($0, $1) }
}
