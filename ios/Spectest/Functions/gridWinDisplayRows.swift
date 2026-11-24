import Foundation

func gridWinDisplayRows(_ winRows: Any = Optional<Any>.none as Any, _ winStart: Any = Optional<Any>.none as Any) -> Any? {
  let winRows = specArr(winRows)
  let winStart = specDouble(winStart)
  var out: Any = (([] as [Any]) as Any)
  for (_idx, r) in winRows.enumerated() {
    let i = Double(_idx)
    specPush(&out, (!specIsNil(r) ? r : (["_unloaded": true as Any, "_slot": (winStart + i) as Any] as [String: Any])))
  }
  return out
}
