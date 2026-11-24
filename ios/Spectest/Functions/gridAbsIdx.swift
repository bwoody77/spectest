import Foundation

func gridAbsIdx(_ isWindowed: Any = Optional<Any>.none as Any, _ start: Any = Optional<Any>.none as Any, _ idx: Any = Optional<Any>.none as Any) -> Any? {
  let isWindowed = (isWindowed as? Bool) ?? false
  let start = specDouble(start)
  let idx = specDouble(idx)
  if isWindowed {
    return (start + idx)
  }
  return idx
}
