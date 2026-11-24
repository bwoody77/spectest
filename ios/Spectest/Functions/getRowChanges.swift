import Foundation

func getRowChanges(_ rowId: Any = Optional<Any>.none as Any, _ editedValues: Any = Optional<Any>.none as Any) -> Any? {
  let rowId = specString(rowId)
  let editedValues = specArr(editedValues)
  var prefix: Any = ((rowId + "::") as Any)
  var entries: Any = (editedValues.filter { specTruthy({ (e) in specString(specGet(e, "key")).hasPrefix(specString(prefix)) }($0)) } as Any)
  if (specLength(entries) > 0.0) {
    return entries
  }
  return nil
}
