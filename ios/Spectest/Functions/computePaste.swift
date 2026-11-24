import Foundation

func computePaste(_ text: Any = Optional<Any>.none as Any, _ activeRow: Any = Optional<Any>.none as Any, _ activeCol: Any = Optional<Any>.none as Any, _ visibleColumns: Any = Optional<Any>.none as Any, _ rows: Any = Optional<Any>.none as Any, _ rowIdField: Any = Optional<Any>.none as Any, _ editedValues: Any = Optional<Any>.none as Any, _ dirtyCells: Any = Optional<Any>.none as Any) -> Any? {
  let text = specString(text)
  let activeRow = specDouble(activeRow)
  let activeCol = specDouble(activeCol)
  let visibleColumns = specArr(visibleColumns)
  let rows = specArr(rows)
  let rowIdField = specString(rowIdField)
  let editedValues = specArr(editedValues)
  let dirtyCells = specArr(dirtyCells)
  var grid: Any = _parseTSV(text)
  var ev: Any = (editedValues as Any)
  var dc: Any = (dirtyCells as Any)
  var undoChanges: Any = (([] as [Any]) as Any)
  for (_idx, gridRow) in specArr(grid).enumerated() {
    let r = Double(_idx)
    var rowIdx: Any = ((activeRow + r) as Any)
    if specLt(rowIdx, Double(rows.count)) {
      var row: Any = specGet(rows, rowIdx)
      var rowId: Any = (specString(specGet(row, rowIdField)) as Any)
      var colOffset: Any = (0.0 as Any)
      for (_idx, cell) in specArr(gridRow).enumerated() {
        let c = Double(_idx)
        var targetCol: Any = specAdd(activeCol, colOffset)
        for _ in specRange(0.0, Double(visibleColumns.count)) {
          if (specLt(targetCol, Double(visibleColumns.count)) && specEq(specGet(specGet(visibleColumns, targetCol), "editable"), false)) {
            colOffset = specAdd(colOffset, 1.0)
            targetCol = specAdd(activeCol, colOffset)
          }
        }
        if specLt(targetCol, Double(visibleColumns.count)) {
          var col: Any = specGet(visibleColumns, targetCol)
          var ck: Any = _buildCellKey(rowId, specGet(col, "key"))
          var newValue: Any = cell
          var originalStr: Any = ("" as Any)
          if !specIsNil(specGet(row, specGet(col, "key"))) {
            originalStr = (specString(specGet(row, specGet(col, "key"))) as Any)
          }
          var existing: Any = specArr(ev).first(where: { specTruthy({ (e) in specEq(specGet(e, "key"), ck) }($0)) })
          var oldValue: Any = (!specIsNil(existing) ? specGet(existing, "value") : originalStr)
          if specNeq(oldValue, newValue) {
            undoChanges = specConcatValue(undoChanges, ([["key": ck, "oldValue": oldValue, "newValue": newValue] as Any] as [Any]))
            if specEq(newValue, originalStr) {
              ev = (specArr(ev).filter { specTruthy({ (e) in specNeq(specGet(e, "key"), ck) }($0)) } as Any)
              dc = (specArr(dc).filter { specTruthy({ (k) in specNeq(k, ck) }($0)) } as Any)
            } else {
              ev = (specConcat(specArr(ev).filter { specTruthy({ (e) in specNeq(specGet(e, "key"), ck) }($0)) }, ([["key": ck, "value": newValue] as Any] as [Any])) as Any)
              if !(specIncludes(dc, ck)) {
                dc = specConcatValue(dc, ([ck] as [Any]))
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
