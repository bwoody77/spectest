import Foundation

func getCellDisplayValue(_ rowIdx: Any = Optional<Any>.none as Any, _ colIdx: Any = Optional<Any>.none as Any, _ visibleColumns: Any = Optional<Any>.none as Any, _ rows: Any = Optional<Any>.none as Any, _ rowIdField: Any = Optional<Any>.none as Any, _ editedValues: Any = Optional<Any>.none as Any) -> Any? {
  let rowIdx = specDouble(rowIdx)
  let colIdx = specDouble(colIdx)
  let visibleColumns = specArr(visibleColumns)
  let rows = specArr(rows)
  let rowIdField = specString(rowIdField)
  let editedValues = specArr(editedValues)
  if ((rowIdx < 0.0) || (rowIdx >= Double(rows.count))) {
    return ""
  }
  if ((colIdx < 0.0) || (colIdx >= Double(visibleColumns.count))) {
    return ""
  }
  var row: Any = rows[Int(rowIdx)]
  var col: Any = visibleColumns[Int(colIdx)]
  var ck: Any = _buildCellKey(specGet(row, rowIdField), specGet(col, "key"))
  var edited: Any = editedValues.first(where: { specTruthy({ (e) in specEq(specGet(e, "key"), ck) }($0)) })
  if !specIsNil(edited) {
    return specString(specGet(edited, "value"))
  }
  if !specIsNil(specGet(row, specGet(col, "key"))) {
    return specString(specGet(row, specGet(col, "key")))
  }
  return ""
}
