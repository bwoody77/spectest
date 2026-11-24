import Foundation

func applyUndoChanges(_ direction: Any = Optional<Any>.none as Any, _ changes: Any = Optional<Any>.none as Any, _ editedValues: Any = Optional<Any>.none as Any, _ dirtyCells: Any = Optional<Any>.none as Any, _ rows: Any = Optional<Any>.none as Any, _ rowIdField: Any = Optional<Any>.none as Any) -> Any? {
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
    var row: Any = rows.first(where: { specTruthy({ (r) in specEq(specString(specGet(r, rowIdField)), rowId) }($0)) })
    var originalStr: Any = ("" as Any)
    if (!specIsNil(row) && !specIsNil(specGet(row, colKey))) {
      originalStr = (specString(specGet(row, colKey)) as Any)
    }
    if specEq(targetValue, originalStr) {
      ev = (specArr(ev).filter { specTruthy({ (e) in specNeq(specGet(e, "key"), specGet(change, "key")) }($0)) } as Any)
      dc = (specArr(dc).filter { specTruthy({ (k) in specNeq(k, specGet(change, "key")) }($0)) } as Any)
    } else {
      ev = (specConcat(specArr(ev).filter { specTruthy({ (e) in specNeq(specGet(e, "key"), specGet(change, "key")) }($0)) }, ([["key": specGet(change, "key"), "value": targetValue] as Any] as [Any])) as Any)
      if !(specIncludes(dc, specGet(change, "key"))) {
        dc = specConcatValue(dc, ([specGet(change, "key")] as [Any]))
      }
    }
  }
  return ["editedValues": ev, "dirtyCells": dc]
}
