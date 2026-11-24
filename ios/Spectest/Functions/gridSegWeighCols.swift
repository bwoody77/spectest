import Foundation

func gridSegWeighCols(_ sized: Any = Optional<Any>.none as Any, _ seg: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any, _ weigh: Any = Optional<Any>.none as Any) -> Any? {
  let sized = specArr(sized)
  let seg = (seg as? [String: Any]) ?? [:]
  let rules = (rules as? Bool) ?? false
  let firstKey = specString(firstKey)
  let weigh = (weigh as? [String: Any]) ?? [:]
  if !(specTruthy(specGet(weigh, "on"))) {
    return sized
  }
  if specGt(gridPctTotal(specArr(specGet(seg, "cols")).map { { (c) in gridColMin(c) }($0) }), 0.0) {
    return sized
  }
  var extra: Any = gridRulePx(specGet(seg, "cols"), rules, firstKey)
  return sized.map { { (sc) in gridWithMin(sc, gridWeightedMin(specGet(sc, "_col"), specGet(seg, "cols"), extra)) }($0) }
}
