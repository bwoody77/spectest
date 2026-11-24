import Foundation

func gridBlockOf(_ start: Any = Optional<Any>.none as Any, _ idx: Any = Optional<Any>.none as Any, _ size: Any = Optional<Any>.none as Any) -> Any? {
  let start = specDouble(start)
  let idx = specDouble(idx)
  let size = specDouble(size)
  if (size <= 0.0) {
    return 0.0
  }
  return floor(((start + idx) / size))
}
