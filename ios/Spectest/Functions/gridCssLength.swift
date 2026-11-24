import Foundation

func gridCssLength(_ v: Any = Optional<Any>.none as Any) -> Any? {
  var s: Any = (specTrim(specString(v)) as Any)
  if specTruthy(regexTest(s, "^[0-9.]+$")) {
    return (specString(s) + "px")
  }
  return s
}
