import Foundation

func skeletonTextLines(_ lines: Any = Optional<Any>.none as Any) -> Any? {
  let lines = specDouble(lines)
  var out: Any = (([] as [Any]) as Any)
  for i in specRange(0.0, lines) {
    var width: Any = ("100%" as Any)
    if ((lines > 1.0) && specEq(i, (lines - 1.0))) {
      width = ("60%" as Any)
    }
    specPush(&out, ["key": i, "width": width])
  }
  return out
}
