import Foundation

func gridBlockFailed(_ failed: Any = Optional<Any>.none as Any, _ idx: Any = Optional<Any>.none as Any) -> Any? {
  let failed = specArr(failed)
  let idx = specDouble(idx)
  if (idx < 0.0) {
    return false
  }
  if (idx >= Double(failed.count)) {
    return false
  }
  return specEq(failed[Int(idx)], true)
}
