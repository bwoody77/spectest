import Foundation

func buildChangesetFromEdits(_ editedValues: Any = Optional<Any>.none as Any, _ dirtyCells: Any = Optional<Any>.none as Any, _ rows: Any = Optional<Any>.none as Any, _ rowIdField: Any = Optional<Any>.none as Any) -> Any? {
  let editedValues = specArr(editedValues)
  let dirtyCells = specArr(dirtyCells)
  let rows = specArr(rows)
  let rowIdField = specString(rowIdField)
  var rowIds: Any = (([] as [Any]) as Any)
  for ck in dirtyCells {
    var rid: Any = specGet(_splitCellKey(ck), 0.0)
    if !(specIncludes(rowIds, rid)) {
      rowIds = specConcatValue(rowIds, ([rid] as [Any]))
    }
  }
  var modified: Any = (specArr(rowIds).map { { (rowId) -> Any in
  var row: Any = rows.first(where: { specTruthy({ (r) in specEq(specString(specGet(r, rowIdField)), rowId) }($0)) })
  var myCells: Any = (dirtyCells.filter { specTruthy({ (ck) in specEq(specGet(_splitCellKey(ck), 0.0), rowId) }($0)) } as Any)
  var entries: Any = (specArr(myCells).map { { (ck) -> Any in
  var colKey: Any = specGet(_splitCellKey(ck), 1.0)
  var edited: Any = editedValues.first(where: { specTruthy({ (e) in specEq(specGet(e, "key"), ck) }($0)) })
  var originalStr: Any = ("" as Any)
  if (!specIsNil(row) && !specIsNil(specGet(row, colKey))) {
    originalStr = (specString(specGet(row, colKey)) as Any)
  }
  var newVal: Any = (!specIsNil(edited) ? specGet(edited, "value") : "")
  return ["colKey": colKey, "old": originalStr, "new": newVal]
}($0) } as Any)
  return ["rowId": rowId, "changes": entries]
}($0) } as Any)
  return ["modified": modified, "added": ([] as [Any]) as Any, "deleted": ([] as [Any]) as Any]
}
