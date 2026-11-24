import Foundation

func toggleSortState(_ sortState: Any = Optional<Any>.none as Any, _ colKey: Any = Optional<Any>.none as Any) -> Any? {
  let sortState = specArr(sortState)
  let colKey = specString(colKey)
  var existing: Any = sortState.first(where: { specTruthy({ (s) in specEq(specGet(s, "key"), colKey) }($0)) })
  if !specIsNil(existing) {
    if specEq(specGet(existing, "direction"), "asc") {
      return sortState.map { { (s) in (specEq(specGet(s, "key"), colKey) ? (["key": colKey as Any, "direction": "desc" as Any] as [String: Any]) : s) }($0) }
    }
    return sortState.filter { specTruthy({ (s) in specNeq(specGet(s, "key"), colKey) }($0)) }
  }
  return ([["key": colKey as Any, "direction": "asc" as Any] as Any] as [Any])
}
