func applyUndoChanges(_ direction: Any, _ changes: Any, _ editedValues: Any, _ dirtyCells: Any, _ rows: Any, _ rowIdField: Any) -> Any? {
  let direction = specString(direction)
  let changes = specArr(changes)
  let editedValues = specArr(editedValues)
  let dirtyCells = specArr(dirtyCells)
  let rows = specArr(rows)
  let rowIdField = specString(rowIdField)
  var ev: Any = (editedValues as Any)
  var dc: Any = (dirtyCells as Any)
  for change in changes {
    var targetValue: Any = ((direction == "undo") ? specGet(change, "oldValue") : specGet(change, "newValue"))
    var parts: Any = _splitCellKey(specGet(change, "key"))
    var rowId: Any = specGet(parts, 0.0)
    var colKey: Any = specGet(parts, 1.0)
    var row: Any = rows.first(where: { { r in (String(describing: String(describing: specGet(r, rowIdField))) == String(describing: rowId)) }($0) as! Bool })
    var originalStr: Any = ("" as Any)
    if (row != nil && specGet(row, colKey) != nil) {
      originalStr = (String(describing: specGet(row, colKey)) as Any)
    }
    if (String(describing: targetValue) == String(describing: originalStr)) {
      ev = ((ev as! [Any]).filter { { e in (String(describing: specGet(e, "key")) != String(describing: specGet(change, "key"))) }($0) as! Bool } as Any)
      dc = ((dc as! [Any]).filter { { k in (String(describing: k) != String(describing: specGet(change, "key"))) }($0) as! Bool } as Any)
    } else {
      ev = ((ev as! [Any]).filter { { e in (String(describing: specGet(e, "key")) != String(describing: specGet(change, "key"))) }($0) as! Bool } + [["key": specGet(change, "key"), "value": targetValue]] as [Any] as Any)
      if !specIncludes(dc, specGet(change, "key")) {
        dc = ((dc as! [Any]) + [specGet(change, "key")] as [Any] as Any)
      }
    }
  }
  return ["editedValues": ev, "dirtyCells": dc]
}
