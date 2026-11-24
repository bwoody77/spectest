import Foundation

func _tabWrap(_ index: Any = Optional<Any>.none as Any, _ delta: Any = Optional<Any>.none as Any, _ len: Any = Optional<Any>.none as Any) -> Any? {
  let index = specDouble(index)
  let delta = specDouble(delta)
  let len = specDouble(len)
  if (len <= 0.0) {
    return 0.0
  }
  return ((index + delta).truncatingRemainder(dividingBy: len) + len).truncatingRemainder(dividingBy: len)
}
