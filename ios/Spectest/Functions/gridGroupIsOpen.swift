import Foundation

func gridGroupIsOpen(_ openGroups: Any = Optional<Any>.none as Any, _ key: Any = Optional<Any>.none as Any) -> Any? {
  let openGroups = specArr(openGroups)
  let key = specString(key)
  return openGroups.contains { specTruthy({ (k) in specEq(k, key) }($0)) }
}
