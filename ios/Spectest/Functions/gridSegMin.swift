import Foundation

func gridSegMin(_ seg: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any) -> Any? {
  let seg = (seg as? [String: Any]) ?? [:]
  let rules = (rules as? Bool) ?? false
  let firstKey = specString(firstKey)
  return gridLengthSum(specArr(specGet(seg, "cols")).map { { (c) in gridColMin(c) }($0) }, gridRulePx(specGet(seg, "cols"), rules, firstKey))
}
