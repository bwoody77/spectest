import Foundation

func gridPctShare(_ p: Any = Optional<Any>.none as Any, _ pct: Any = Optional<Any>.none as Any, _ rest: Any = Optional<Any>.none as Any) -> Any? {
  let p = specDouble(p)
  let pct = specDouble(pct)
  let rest = specString(rest)
  if (p == pct) {
    return ((rest == "0px") ? "100%" : (("calc(100% - " + rest) + ")"))
  }
  var room: Any = (((rest == "0px") ? "100%" : (("(100% - " + rest) + ")")) as Any)
  return (((((("calc(" + specString(room)) + " * ") + specString(p)) + " / ") + specString(pct)) + ")")
}
