func applySortAndFilter(_ rows: Any, _ sortState: Any, _ filters: Any) -> Any {
  var sorted = _applySortToRows(rows, sortState)
  return _applyFilters(sorted, filters)
}
