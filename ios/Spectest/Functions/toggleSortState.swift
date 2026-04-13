func toggleSortState(_ sortState: Any, _ colKey: Any) -> Any? {
  let sortState = specArr(sortState)
  let colKey = specString(colKey)
  var existing: Any = sortState.first(where: { { s in (String(describing: specGet(s, "key")) == String(describing: colKey)) }($0) as! Bool })
  if existing != nil {
    if (String(describing: specGet(existing, "direction")) == String(describing: "asc")) {
      return sortState.map { { s in ((String(describing: specGet(s, "key")) == String(describing: colKey)) ? ["key": colKey as Any, "direction": "desc" as Any] : s) }($0) }
    }
    return sortState.filter { { s in (String(describing: specGet(s, "key")) != String(describing: colKey)) }($0) as! Bool }
  }
  return [["key": colKey as Any, "direction": "asc" as Any]] as [Any]
}
