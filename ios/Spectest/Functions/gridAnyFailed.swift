import Foundation

func gridAnyFailed(_ failed: Any = Optional<Any>.none as Any) -> Any? {
  let failed = specArr(failed)
  for f in failed {
    if specEq(f, true) {
      return true
    }
  }
  return false
}
