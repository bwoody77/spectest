func _applySortToRows(_ rows: Any, _ sortState: Any) -> Any {
  if (specLength(sortState) == 0.0) {
    return rows
  }
  return (rows as! [Any]).sorted { ({ (a, b) -> Any in
  for _item in (sortState as! [Any]) {
    let key = (_item as! [String: Any])["key"]!
    let direction = (_item as! [String: Any])["direction"]!
    var aVal = (a as! [String: Any])[(key as! String)]
    var bVal = (b as! [String: Any])[(key as! String)]
    var cmp = 0.0
    if (aVal == nil && bVal == nil) {
      cmp = 0.0
    } else {
      if aVal == nil {
        cmp = (0.0 - 1.0)
      } else {
        if bVal == nil {
          cmp = 1.0
        } else {
          if ((specTypeOf(aVal) == "number") && (specTypeOf(bVal) == "number")) {
            cmp = ((aVal as! Double) - (bVal as! Double))
          } else {
            cmp = Double(String(describing: aVal).localizedCompare(String(describing: bVal)).rawValue)
          }
        }
      }
    }
    if (cmp != 0.0) {
      return ((String(describing: direction) == String(describing: "asc")) ? cmp : (0.0 - cmp))
    }
  }
  return 0.0
}($0, $1) as! Double) < 0 }
}
