func applySortAndFilter(_ rows: Any, _ sortState: Any, _ filters: Any) -> Any? {
  let rows = specArr(rows)
  let sortState = specArr(sortState)
  let filters = specArr(filters)
  var sorted: Any = _applySortToRows(rows, sortState)
  return _applyFilters(sorted, filters)
}
