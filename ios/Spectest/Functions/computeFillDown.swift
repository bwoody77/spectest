import Foundation

func computeFillDown(_ activeRow: Any = Optional<Any>.none as Any, _ activeCol: Any = Optional<Any>.none as Any, _ visibleColumns: Any = Optional<Any>.none as Any, _ rows: Any = Optional<Any>.none as Any, _ rowIdField: Any = Optional<Any>.none as Any, _ editedValues: Any = Optional<Any>.none as Any, _ dirtyCells: Any = Optional<Any>.none as Any) -> Any? {
  let activeRow = specDouble(activeRow)
  let activeCol = specDouble(activeCol)
  let visibleColumns = specArr(visibleColumns)
  let rows = specArr(rows)
  let rowIdField = specString(rowIdField)
  let editedValues = specArr(editedValues)
  let dirtyCells = specArr(dirtyCells)
  if ((activeCol < 0.0) || (activeCol >= Double(visibleColumns.count))) {
    return ["editedValues": editedValues as Any, "dirtyCells": dirtyCells as Any, "undoChanges": ([] as [Any]) as Any]
  }
  if ((activeRow < 0.0) || (activeRow >= Double(rows.count))) {
    return ["editedValues": editedValues as Any, "dirtyCells": dirtyCells as Any, "undoChanges": ([] as [Any]) as Any]
  }
  var col: Any = visibleColumns[Int(activeCol)]
  var sourceRow: Any = rows[Int(activeRow)]
  var sourceRowId: Any = (specString(specGet(sourceRow, rowIdField)) as Any)
  var sourceCk: Any = _buildCellKey(sourceRowId, specGet(col, "key"))
  var sourceEdited: Any = editedValues.first(where: { specTruthy({ (e) in specEq(specGet(e, "key"), sourceCk) }($0)) })
  var sourceValue: Any = ("" as Any)
  if !specIsNil(sourceEdited) {
    sourceValue = specGet(sourceEdited, "value")
  } else {
    if !specIsNil(specGet(sourceRow, specGet(col, "key"))) {
      sourceValue = (specString(specGet(sourceRow, specGet(col, "key"))) as Any)
    }
  }
  var ev: Any = (editedValues as Any)
  var dc: Any = (dirtyCells as Any)
  var undoChanges: Any = (([] as [Any]) as Any)
  for r in specRange((activeRow + 1.0), Double(rows.count)) {
    var row: Any = specGet(rows, r)
    var rowId: Any = (specString(specGet(row, rowIdField)) as Any)
    var ck: Any = _buildCellKey(rowId, specGet(col, "key"))
    var originalStr: Any = ("" as Any)
    if !specIsNil(specGet(row, specGet(col, "key"))) {
      originalStr = (specString(specGet(row, specGet(col, "key"))) as Any)
    }
    var existing: Any = specArr(ev).first(where: { specTruthy({ (e) in specEq(specGet(e, "key"), ck) }($0)) })
    var oldValue: Any = (!specIsNil(existing) ? specGet(existing, "value") : originalStr)
    if specNeq(oldValue, sourceValue) {
      undoChanges = specConcatValue(undoChanges, ([["key": ck, "oldValue": oldValue, "newValue": sourceValue] as Any] as [Any]))
      if specEq(sourceValue, originalStr) {
        ev = (specArr(ev).filter { specTruthy({ (e) in specNeq(specGet(e, "key"), ck) }($0)) } as Any)
        dc = (specArr(dc).filter { specTruthy({ (k) in specNeq(k, ck) }($0)) } as Any)
      } else {
        ev = (specConcat(specArr(ev).filter { specTruthy({ (e) in specNeq(specGet(e, "key"), ck) }($0)) }, ([["key": ck, "value": sourceValue] as Any] as [Any])) as Any)
        if !(specIncludes(dc, ck)) {
          dc = specConcatValue(dc, ([ck] as [Any]))
        }
      }
    }
  }
  return ["editedValues": ev, "dirtyCells": dc, "undoChanges": undoChanges]
}
