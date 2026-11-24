import Foundation

func gridDerivedIsOpen(_ collapsed: Any = Optional<Any>.none as Any, _ key: Any = Optional<Any>.none as Any) -> Any? {
  let collapsed = specArr(collapsed)
  let key = specString(key)
  return !(collapsed.contains { specTruthy({ (k) in ((specString(k) + "") == key) }($0)) })
}
