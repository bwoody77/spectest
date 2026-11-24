import Foundation

func _buildCellKey(_ rowId: Any = Optional<Any>.none as Any, _ colKey: Any = Optional<Any>.none as Any) -> Any? {
  let colKey = specString(colKey)
  return ((specString(rowId) + "::") + colKey)
}
