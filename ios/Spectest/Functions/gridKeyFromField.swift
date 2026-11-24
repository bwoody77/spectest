import Foundation

func gridKeyFromField(_ target: Any = Optional<Any>.none as Any) -> Any? {
  let target = (target as? [String: Any]) ?? [:]
  if specIsNil(target) {
    return false
  }
  if specEq(specGet(target, "isContentEditable"), true) {
    return true
  }
  var tag: Any = specGet(target, "tagName")
  return ((specEq(tag, "INPUT") || specEq(tag, "TEXTAREA")) || specEq(tag, "SELECT"))
}
