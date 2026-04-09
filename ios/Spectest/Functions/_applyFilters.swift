func _applyFilters(_ rows: Any, _ filters: Any) -> Any {
  var activeFilters = (filters as! [Any]).filter { { f in ((f as! [String: Any])["value"]! != nil && (specLength((f as! [String: Any])["value"]!) > 0.0)) }($0) as! Bool }
  if (Double(activeFilters.count) == 0.0) {
    return rows
  }
  return (rows as! [Any]).filter { { (row) -> Any in
  for _item in activeFilters {
    let key = (_item as! [String: Any])["key"]!
    let value = (_item as! [String: Any])["value"]!
    var val = (row as! [String: Any])[(key as! String)]
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
