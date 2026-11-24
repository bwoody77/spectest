import Foundation

func gridRowIsExpanded(_ expandedSet: Any = Optional<Any>.none as Any, _ key: Any = Optional<Any>.none as Any) -> Any? {
  let expandedSet = specArr(expandedSet)
  let key = specString(key)
  return expandedSet.contains { specTruthy({ (k) in specEq(k, key) }($0)) }
}
