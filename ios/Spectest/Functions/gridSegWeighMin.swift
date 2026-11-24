import Foundation

func gridSegWeighMin(_ seg: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any, _ weigh: Any = Optional<Any>.none as Any) -> Any? {
  let seg = (seg as? [String: Any]) ?? [:]
  let rules = (rules as? Bool) ?? false
  let firstKey = specString(firstKey)
  let weigh = (weigh as? [String: Any]) ?? [:]
  if !(specTruthy(specGet(weigh, "on"))) {
    return gridSegMin(seg, rules, firstKey)
  }
  return gridLengthSum(specArr(specGet(seg, "cols")).map { { (c) in gridWeightedMin(c, specGet(weigh, "all"), specGet(weigh, "extra")) }($0) }, gridRulePx(specGet(seg, "cols"), rules, firstKey))
}
