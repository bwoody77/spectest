import Foundation

func gridBlockMsgSlot(_ failed: Any = Optional<Any>.none as Any, _ start: Any = Optional<Any>.none as Any, _ idx: Any = Optional<Any>.none as Any, _ size: Any = Optional<Any>.none as Any, _ firstVisible: Any = Optional<Any>.none as Any) -> Any? {
  let failed = specArr(failed)
  let start = specDouble(start)
  let idx = specDouble(idx)
  let size = specDouble(size)
  let firstVisible = specDouble(firstVisible)
  if !(specTruthy(gridBlockFailed(failed, idx))) {
    return false
  }
  if (idx < firstVisible) {
    return false
  }
  if (idx == firstVisible) {
    return true
  }
  return specNeq(gridBlockOf(start, idx, size), gridBlockOf(start, (idx - 1.0), size))
}
