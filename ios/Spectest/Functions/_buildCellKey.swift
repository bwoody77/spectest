func _buildCellKey(_ rowId: Any, _ colKey: Any) -> Any? {
  let colKey = specString(colKey)
  return ((String(describing: rowId) + "::") + colKey)
}
