func computeFillDown(_ activeRow: Any, _ activeCol: Any, _ visibleColumns: Any, _ rows: Any, _ rowIdField: Any, _ editedValues: Any, _ dirtyCells: Any) -> Any? {
  let activeRow = specDouble(activeRow)
  let activeCol = specDouble(activeCol)
  let visibleColumns = (visibleColumns as? [Any]) ?? []
  let rows = (rows as? [Any]) ?? []
  let rowIdField = specString(rowIdField)
  let editedValues = (editedValues as? [Any]) ?? []
  let dirtyCells = (dirtyCells as? [Any]) ?? []
  if ((activeCol < 0.0) || (activeCol >= Double(visibleColumns.count))) {
    return ["editedValues": editedValues as Any, "dirtyCells": dirtyCells as Any, "undoChanges": ([] as [Any]) as Any]
  }
  if ((activeRow < 0.0) || (activeRow >= Double(rows.count))) {
    return ["editedValues": editedValues as Any, "dirtyCells": dirtyCells as Any, "undoChanges": ([] as [Any]) as Any]
  }
  var col: Any = visibleColumns[Int(activeCol)]
  var sourceRow: Any = rows[Int(activeRow)]
  var sourceRowId: Any = (String(describing: specGet(sourceRow, rowIdField)) as Any)
  var sourceCk: Any = _buildCellKey(sourceRowId, specGet(col, "key"))
  var sourceEdited: Any = editedValues.first(where: { { e in (String(describing: specGet(e, "key")) == String(describing: sourceCk)) }($0) as! Bool })
  var sourceValue: Any = ("" as Any)
  if sourceEdited != nil {
    sourceValue = specGet(sourceEdited, "value")
  } else {
    if specGet(sourceRow, specGet(col, "key")) != nil {
      sourceValue = (String(describing: specGet(sourceRow, specGet(col, "key"))) as Any)
    }
  }
  var ev: Any = (editedValues as Any)
  var dc: Any = (dirtyCells as Any)
  var undoChanges: Any = (([] as [Any]) as Any)
  for r in (Int((activeRow + 1.0))..<Int(Double(rows.count))).map { Double($0) } {
    var row: Any = specGet(rows, r)
    var rowId: Any = (String(describing: specGet(row, rowIdField)) as Any)
    var ck: Any = _buildCellKey(rowId, specGet(col, "key"))
    var originalStr: Any = ("" as Any)
    if specGet(row, specGet(col, "key")) != nil {
      originalStr = (String(describing: specGet(row, specGet(col, "key"))) as Any)
    }
    var existing: Any = (ev as! [Any]).first(where: { { e in (String(describing: specGet(e, "key")) == String(describing: ck)) }($0) as! Bool })
    var oldValue: Any = (existing != nil ? specGet(existing, "value") : originalStr)
    if (String(describing: oldValue) != String(describing: sourceValue)) {
      undoChanges = ((undoChanges as! [Any]) + [["key": ck, "oldValue": oldValue, "newValue": sourceValue]] as [Any] as Any)
      if (String(describing: sourceValue) == String(describing: originalStr)) {
        ev = ((ev as! [Any]).filter { { e in (String(describing: specGet(e, "key")) != String(describing: ck)) }($0) as! Bool } as Any)
        dc = ((dc as! [Any]).filter { { k in (String(describing: k) != String(describing: ck)) }($0) as! Bool } as Any)
      } else {
        ev = ((ev as! [Any]).filter { { e in (String(describing: specGet(e, "key")) != String(describing: ck)) }($0) as! Bool } + [["key": ck, "value": sourceValue]] as [Any] as Any)
        if !specIncludes(dc, ck) {
          dc = ((dc as! [Any]) + [ck] as [Any] as Any)
        }
      }
    }
  }
  return ["editedValues": ev, "dirtyCells": dc, "undoChanges": undoChanges]
}
