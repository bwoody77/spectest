import Foundation

func gridToggleGroup(_ openGroups: Any = Optional<Any>.none as Any, _ key: Any = Optional<Any>.none as Any) -> Any? {
  let openGroups = specArr(openGroups)
  let key = specString(key)
  if specTruthy(gridGroupIsOpen(openGroups, key)) {
    return openGroups.filter { specTruthy({ (k) in specNeq(k, key) }($0)) }
  }
  return specConcat(openGroups, ([key as Any] as [Any]))
}
