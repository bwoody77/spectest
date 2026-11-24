import Foundation

func gridFirstFocus(_ isWindowed: Any = Optional<Any>.none as Any, _ start: Any = Optional<Any>.none as Any) -> Any? {
  let isWindowed = (isWindowed as? Bool) ?? false
  let start = specDouble(start)
  if isWindowed {
    return start
  }
  return 0.0
}
