import Foundation

func gridLenPct(_ s: Any = Optional<Any>.none as Any) -> Any? {
  let s = specString(s)
  if specTruthy(regexTest(s, "^[0-9.]+%$")) {
    return (specNum(regexReplace(s, "%$", "")) * 1.0)
  }
  return -1.0
}
