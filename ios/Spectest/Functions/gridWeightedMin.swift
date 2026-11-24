import Foundation

func gridWeightedMin(_ col: Any = Optional<Any>.none as Any, _ cols: Any = Optional<Any>.none as Any, _ extraPx: Any = Optional<Any>.none as Any) -> Any? {
  let col = (col as? [String: Any]) ?? [:]
  let cols = specArr(cols)
  let extraPx = specDouble(extraPx)
  var floor: Any = gridColMin(col)
  var w: Any = gridColWeight(col)
  if specLte(w, 0.0) {
    return floor
  }
  var total: Any = cols.reduce(0.0) { { (acc, c) in specAdd(acc, gridColWeight(c)) }($0, $1) }
  var used: Any = gridLengthSum(cols.map { { (c) in gridColMin(c) }($0) }, extraPx)
  return (((((((((("max(" + specString(floor)) + ", calc(") + specString(floor)) + " + (100% - ") + specString(used)) + ") * ") + specString(w)) + " / ") + specString(total)) + "))")
}
