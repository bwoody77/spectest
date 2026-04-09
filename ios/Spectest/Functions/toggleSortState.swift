func toggleSortState(_ sortState: Any, _ colKey: Any) -> Any {
  var existing = (sortState as! [Any]).first(where: { { s in (String(describing: (s as! [String: Any])["key"]!) == String(describing: colKey)) }($0) as! Bool })
  if existing != nil {
    if (String(describing: (existing as! [String: Any])["direction"]!) == String(describing: "asc")) {
      return (sortState as! [Any]).map { { s in ((String(describing: (s as! [String: Any])["key"]!) == String(describing: colKey)) ? ["key": colKey, "direction": "desc" as Any] : s) }($0) }
    }
    return (sortState as! [Any]).filter { { s in (String(describing: (s as! [String: Any])["key"]!) != String(describing: colKey)) }($0) as! Bool }
  }
  return [["key": colKey, "direction": "asc" as Any]]
}
