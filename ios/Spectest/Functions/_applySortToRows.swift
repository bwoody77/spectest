func _applySortToRows(_ rows: Any, _ sortState: Any) -> Any? {
  let rows = (rows as? [Any]) ?? []
  let sortState = (sortState as? [Any]) ?? []
  if (Double(sortState.count) == 0.0) {
    return rows
  }
  return rows.sorted { ({ (a, b) -> Any in
  for _item in sortState {
    let key = (_item as! [String: Any])["key"]!
    let direction = (_item as! [String: Any])["direction"]!
    var aVal: Any = specGet(a, key)
    var bVal: Any = specGet(b, key)
    var cmp: Any = (0.0 as Any)
    if (aVal == nil && bVal == nil) {
      cmp = (0.0 as Any)
    } else {
      if aVal == nil {
        cmp = ((0.0 - 1.0) as Any)
      } else {
        if bVal == nil {
          cmp = (1.0 as Any)
        } else {
          if ((specTypeOf(aVal) == "number") && (specTypeOf(bVal) == "number")) {
            cmp = (((aVal as! Double) - (bVal as! Double)) as Any)
          } else {
            cmp = (Double(String(describing: aVal).localizedCompare(String(describing: bVal)).rawValue) as Any)
          }
        }
      }
    }
    if (String(describing: cmp) != String(describing: 0.0)) {
      return ((String(describing: direction) == String(describing: "asc")) ? cmp : (0.0 - (cmp as! Double)))
    }
  }
  return 0.0
}($0, $1) as! Double) < 0 }
}
