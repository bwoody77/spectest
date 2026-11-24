import Foundation

func gridLenIsKeyword(_ s: Any = Optional<Any>.none as Any) -> Any? {
  let s = specString(s)
  return regexTest(s, "^[a-z-]+$")
}
