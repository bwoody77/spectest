import Foundation

func gridBodyRows(_ rows: Any = Optional<Any>.none as Any, _ keysUsable: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  let keysUsable = (keysUsable as? Bool) ?? false
  if keysUsable {
    return rows
  }
  var out: Any = (([] as [Any]) as Any)
  for (_idx, r) in rows.enumerated() {
    let i = Double(_idx)
    specPush(&out, specMergeMaps([specAsMap(r), ["_rk": i as Any]]))
  }
  return out
}
