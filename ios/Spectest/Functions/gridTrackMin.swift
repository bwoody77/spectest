import Foundation

func gridTrackMin(_ cols: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any, _ selection: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  let rules = (rules as? Bool) ?? false
  let firstKey = specString(firstKey)
  let selection = specString(selection)
  var lens: Any = (cols.map { { (c) in gridColMin(c) }($0) } as Any)
  var pct: Any = gridPctTotal(lens)
  var extra: Any = specAdd(gridRulePx(cols, rules, firstKey), ((selection == "multi") ? 40.0 : 0.0))
  if (specLte(pct, 0.0) || specGte(pct, 100.0)) {
    return gridLengthSum(lens, extra)
  }
  var rest: Any = gridLengthSum(gridNonPct(lens), extra)
  return (((("calc(" + specString(rest)) + " * 100 / ") + specString((100.0 - specNum(pct)))) + ")")
}
