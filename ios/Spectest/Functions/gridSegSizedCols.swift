import Foundation

func gridSegSizedCols(_ seg: Any = Optional<Any>.none as Any, _ all: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any) -> Any? {
  let seg = (seg as? [String: Any]) ?? [:]
  let all = specArr(all)
  let rules = (rules as? Bool) ?? false
  let firstKey = specString(firstKey)
  var sized: Any = gridSizedCols(specGet(seg, "cols"), all)
  var lens: Any = (specArr(specGet(seg, "cols")).map { { (c) in gridColMin(c) }($0) } as Any)
  var pct: Any = gridPctTotal(lens)
  if specLte(pct, 0.0) {
    return sized
  }
  var rest: Any = gridLengthSum(gridNonPct(lens), gridRulePx(specGet(seg, "cols"), rules, firstKey))
  return specArr(sized).map { { (sc) in gridPctSized(sc, pct, rest) }($0) }
}
