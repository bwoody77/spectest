import Foundation

func gridHasStructuralRows(_ rows: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  return rows.contains { specTruthy({ (r) in !specIsNil(specGet(r, "_kind")) }($0)) }
}
