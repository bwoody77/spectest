import Foundation

func _applySortToRows(_ rows: Any = Optional<Any>.none as Any, _ sortState: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  let sortState = specArr(sortState)
  if (Double(sortState.count) == 0.0) {
    return rows
  }
  if specTruthy(gridHasStructuralRows(rows)) {
    return rows
  }
  return rows.sorted { specDouble({ (a, b) -> Any in
  for _item in sortState {
    let key = specAsMap(_item)["key"] ?? (Optional<Any>.none as Any)
    let direction = specAsMap(_item)["direction"] ?? (Optional<Any>.none as Any)
    var aVal: Any = specGet(a, key)
    var bVal: Any = specGet(b, key)
    var cmp: Any = (0.0 as Any)
    if (specIsNil(aVal) && specIsNil(bVal)) {
      cmp = (0.0 as Any)
    } else {
      if specIsNil(aVal) {
        cmp = ((0.0 - 1.0) as Any)
      } else {
        if specIsNil(bVal) {
          cmp = (1.0 as Any)
        } else {
          if ((specTypeOf(aVal) == "number") && (specTypeOf(bVal) == "number")) {
            cmp = ((specNum(aVal) - specNum(bVal)) as Any)
          } else {
            cmp = (Double(specString(aVal).localizedCompare(specString(bVal)).rawValue) as Any)
          }
        }
      }
    }
    if specNeq(cmp, 0.0) {
      return (specEq(direction, "asc") ? cmp : (0.0 - specNum(cmp)))
    }
  }
  return 0.0
}($0, $1)) < 0 }
}
