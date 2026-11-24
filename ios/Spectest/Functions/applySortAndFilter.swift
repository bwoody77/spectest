import Foundation

func applySortAndFilter(_ rows: Any = Optional<Any>.none as Any, _ sortState: Any = Optional<Any>.none as Any, _ filters: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  let sortState = specArr(sortState)
  let filters = specArr(filters)
  var sorted: Any = _applySortToRows(rows, sortState)
  return _applyFilters(sorted, filters)
}
