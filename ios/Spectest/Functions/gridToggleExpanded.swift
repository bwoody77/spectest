import Foundation

func gridToggleExpanded(_ expandedSet: Any = Optional<Any>.none as Any, _ key: Any = Optional<Any>.none as Any) -> Any? {
  let expandedSet = specArr(expandedSet)
  let key = specString(key)
  if specTruthy(gridRowIsExpanded(expandedSet, key)) {
    return expandedSet.filter { specTruthy({ (k) in specNeq(k, key) }($0)) }
  }
  return specConcat(expandedSet, ([key as Any] as [Any]))
}
