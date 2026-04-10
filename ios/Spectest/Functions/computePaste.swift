func computePaste(_ text: Any, _ activeRow: Any, _ activeCol: Any, _ visibleColumns: Any, _ rows: Any, _ rowIdField: Any, _ editedValues: Any, _ dirtyCells: Any) -> Any? {
  let text = specString(text)
  let activeRow = specDouble(activeRow)
  let activeCol = specDouble(activeCol)
  let visibleColumns = (visibleColumns as? [Any]) ?? []
  let rows = (rows as? [Any]) ?? []
  let rowIdField = specString(rowIdField)
  let editedValues = (editedValues as? [Any]) ?? []
  let dirtyCells = (dirtyCells as? [Any]) ?? []
  var grid: Any = _parseTSV(text)
  var ev: Any = (editedValues as Any)
  var dc: Any = (dirtyCells as Any)
  var undoChanges: Any = (([] as [Any]) as Any)
  for (_idx, gridRow) in (grid as! [Any]).enumerated() {
    let r = Double(_idx)
    var rowIdx: Any = ((activeRow + r) as Any)
    if ((rowIdx as! Double) < Double(rows.count)) {
      var row: Any = specGet(rows, rowIdx)
      var rowId: Any = (String(describing: specGet(row, rowIdField)) as Any)
      var colOffset: Any = (0.0 as Any)
      for (_idx, cell) in (gridRow as! [Any]).enumerated() {
        let c = Double(_idx)
        var targetCol: Any = specAdd(activeCol, colOffset)
        for _ in (Int(0.0)..<Int(Double(visibleColumns.count))).map { Double($0) } {
          if (((targetCol as! Double) < Double(visibleColumns.count)) && (String(describing: specGet(specGet(visibleColumns, targetCol), "editable")) == String(describing: false))) {
            colOffset = specAdd(colOffset, 1.0)
            targetCol = specAdd(activeCol, colOffset)
          }
        }
        if ((targetCol as! Double) < Double(visibleColumns.count)) {
          var col: Any = specGet(visibleColumns, targetCol)
          var ck: Any = _buildCellKey(rowId, specGet(col, "key"))
          var newValue: Any = cell
          var originalStr: Any = ("" as Any)
          if specGet(row, specGet(col, "key")) != nil {
            originalStr = (String(describing: specGet(row, specGet(col, "key"))) as Any)
          }
          var existing: Any = (ev as! [Any]).first(where: { { e in (String(describing: specGet(e, "key")) == String(describing: ck)) }($0) as! Bool })
          var oldValue: Any = (existing != nil ? specGet(existing, "value") : originalStr)
          if (String(describing: oldValue) != String(describing: newValue)) {
            undoChanges = ((undoChanges as! [Any]) + [["key": ck, "oldValue": oldValue, "newValue": newValue]] as [Any] as Any)
            if (String(describing: newValue) == String(describing: originalStr)) {
              ev = ((ev as! [Any]).filter { { e in (String(describing: specGet(e, "key")) != String(describing: ck)) }($0) as! Bool } as Any)
              dc = ((dc as! [Any]).filter { { k in (String(describing: k) != String(describing: ck)) }($0) as! Bool } as Any)
            } else {
              ev = ((ev as! [Any]).filter { { e in (String(describing: specGet(e, "key")) != String(describing: ck)) }($0) as! Bool } + [["key": ck, "value": newValue]] as [Any] as Any)
              if !specIncludes(dc, ck) {
                dc = ((dc as! [Any]) + [ck] as [Any] as Any)
              }
            }
          }
          colOffset = specAdd(colOffset, 1.0)
        }
      }
    }
  }
  return ["editedValues": ev, "dirtyCells": dc, "undoChanges": undoChanges]
}
