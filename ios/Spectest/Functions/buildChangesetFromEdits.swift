func buildChangesetFromEdits(_ editedValues: Any, _ dirtyCells: Any, _ rows: Any, _ rowIdField: Any) -> Any? {
  let editedValues = specArr(editedValues)
  let dirtyCells = specArr(dirtyCells)
  let rows = specArr(rows)
  let rowIdField = specString(rowIdField)
  var rowIds: Any = (([] as [Any]) as Any)
  for ck in dirtyCells {
    var rid: Any = specGet(_splitCellKey(ck), 0.0)
    if !specIncludes(rowIds, rid) {
      rowIds = ((rowIds as! [Any]) + [rid] as [Any] as Any)
    }
  }
  var modified: Any = ((rowIds as! [Any]).map { { (rowId) -> Any in
  var row: Any = rows.first(where: { { r in (String(describing: String(describing: specGet(r, rowIdField))) == String(describing: rowId)) }($0) as! Bool })
  var myCells: Any = (dirtyCells.filter { { ck in (String(describing: specGet(_splitCellKey(ck), 0.0)) == String(describing: rowId)) }($0) as! Bool } as Any)
  var entries: Any = ((myCells as! [Any]).map { { (ck) -> Any in
  var colKey: Any = specGet(_splitCellKey(ck), 1.0)
  var edited: Any = editedValues.first(where: { { e in (String(describing: specGet(e, "key")) == String(describing: ck)) }($0) as! Bool })
  var originalStr: Any = ("" as Any)
  if (row != nil && specGet(row, colKey) != nil) {
    originalStr = (String(describing: specGet(row, colKey)) as Any)
  }
  var newVal: Any = (edited != nil ? specGet(edited, "value") : "")
  return ["colKey": colKey, "old": originalStr, "new": newVal]
}($0) } as Any)
  return ["rowId": rowId, "changes": entries]
}($0) } as Any)
  return ["modified": modified, "added": ([] as [Any]) as Any, "deleted": ([] as [Any]) as Any]
}
