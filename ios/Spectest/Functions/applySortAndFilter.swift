func applySortAndFilter(_ rows: Any, _ sortState: Any, _ filters: Any) -> Any? {
  let rows = (rows as? [Any]) ?? []
  let sortState = (sortState as? [Any]) ?? []
  let filters = (filters as? [Any]) ?? []
  var sorted: Any = _applySortToRows(rows, sortState)
  return _applyFilters(sorted, filters)
}
