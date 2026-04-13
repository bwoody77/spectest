func _applyFilters(_ rows: Any, _ filters: Any) -> Any? {
  let rows = specArr(rows)
  let filters = specArr(filters)
  var activeFilters: Any = (filters.filter { { f in (specGet(f, "value") != nil && (specLength(specGet(f, "value")) > 0.0)) }($0) as! Bool } as Any)
  if (specLength(activeFilters) == 0.0) {
    return rows
  }
  return rows.filter { { (row) -> Any in
  for _item in (activeFilters as! [Any]) {
    let key = (_item as! [String: Any])["key"]!
    let value = (_item as! [String: Any])["value"]!
    var val: Any = specGet(row, key)
    if val == nil {
      return false
    }
    if !String(describing: val).lowercased().contains((value as! String).lowercased()) {
      return false
    }
  }
  return true
}($0) as! Bool }
}
