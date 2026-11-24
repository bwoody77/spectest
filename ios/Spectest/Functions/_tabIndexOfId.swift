import Foundation

func _tabIndexOfId(_ items: Any = Optional<Any>.none as Any, _ id: Any = Optional<Any>.none as Any) -> Any? {
  let id = specString(id)
  for (_idx, item) in specArr(items).enumerated() {
    let i = Double(_idx)
    if specEq(specGet(item, "id"), id) {
      return i
    }
  }
  return 0.0
}
