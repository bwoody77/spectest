import Foundation

func gridVisibleDerivedRows(_ rows: Any = Optional<Any>.none as Any, _ collapsed: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  let collapsed = specArr(collapsed)
  return rows.filter { specTruthy({ (r) in specOr((!specIsNil(specGet(r, "_kind")) || specIsNil(specGet(r, "_group"))), gridDerivedIsOpen(collapsed, specGet(r, "_group"))) }($0)) }
}
