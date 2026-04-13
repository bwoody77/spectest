func getRowChanges(_ rowId: Any, _ editedValues: Any) -> Any? {
  let rowId = specString(rowId)
  let editedValues = specArr(editedValues)
  var prefix: Any = ((rowId + "::") as Any)
  var entries: Any = (editedValues.filter { { e in (specGet(e, "key") as! String).hasPrefix((prefix as! String)) }($0) as! Bool } as Any)
  if (specLength(entries) > 0.0) {
    return entries
  }
  return nil
}
