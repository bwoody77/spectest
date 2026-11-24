import Foundation

func _applyFilters(_ rows: Any = Optional<Any>.none as Any, _ filters: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  let filters = specArr(filters)
  var activeFilters: Any = (filters.filter { specTruthy({ (f) in (!specIsNil(specGet(f, "value")) && (specLength(specGet(f, "value")) > 0.0)) }($0)) } as Any)
  if (specLength(activeFilters) == 0.0) {
    return rows
  }
  return rows.filter { specTruthy({ (row) -> Any in
  for _item in specArr(activeFilters) {
    let key = specAsMap(_item)["key"] ?? (Optional<Any>.none as Any)
    let value = specAsMap(_item)["value"] ?? (Optional<Any>.none as Any)
    var val: Any = specGet(row, key)
    if specIsNil(val) {
      return false
    }
    if !(specIncludes(specToLowerCase(specString(val)), specToLowerCase(value))) {
      return false
    }
  }
  return true
}($0)) }
}
