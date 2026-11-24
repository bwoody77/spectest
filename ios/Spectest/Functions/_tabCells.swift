import Foundation

func _tabCells(_ items: Any = Optional<Any>.none as Any) -> Any? {
  var out: Any = (([] as [Any]) as Any)
  var run: Any = (([] as [Any]) as Any)
  var runKey: Any = (Optional<Any>.none as Any)
  for item in specArr(items) {
    var g: Any = specCoalesce(specGet(item, "group"), nil)
    if ((!specIsNil(g) && specEq(g, runKey)) && (specLength(run) > 0.0)) {
      specPush(&run, item)
    } else {
      if (specLength(run) > 0.0) {
        specPush(&out, ["key": specGet(specGet(run, 0.0), "id"), "grouped": (specLength(run) > 1.0) as Any, "tabs": run])
      }
      run = (([item] as [Any]) as Any)
      runKey = g
    }
  }
  if (specLength(run) > 0.0) {
    specPush(&out, ["key": specGet(specGet(run, 0.0), "id"), "grouped": (specLength(run) > 1.0) as Any, "tabs": run])
  }
  return out
}
