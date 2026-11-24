import Foundation

func gridRulePx(_ cols: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  let rules = (rules as? Bool) ?? false
  let firstKey = specString(firstKey)
  if !(rules) {
    return 0.0
  }
  return cols.reduce(0.0) { { (acc, c) in specAdd(acc, (specNeq(specGet(c, "key"), firstKey) ? 1.0 : 0.0)) }($0, $1) }
}
