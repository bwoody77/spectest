import Foundation

func gridVisibleRows(_ rows: Any = Optional<Any>.none as Any, _ openGroups: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  let openGroups = specArr(openGroups)
  return rows.filter { specTruthy({ (r) in specOr(specIsNil(specGet(r, "_group")), gridGroupIsOpen(openGroups, specGet(r, "_group"))) }($0)) }
}
