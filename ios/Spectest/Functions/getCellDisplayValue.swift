func getCellDisplayValue(_ rowIdx: Any, _ colIdx: Any, _ visibleColumns: Any, _ rows: Any, _ rowIdField: Any, _ editedValues: Any) -> Any? {
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
  var edited: Any = editedValues.first(where: { { e in (String(describing: specGet(e, "key")) == String(describing: ck)) }($0) as! Bool })
  if edited != nil {
    return String(describing: specGet(edited, "value"))
  }
  if specGet(row, specGet(col, "key")) != nil {
    return String(describing: specGet(row, specGet(col, "key")))
  }
  return ""
}
