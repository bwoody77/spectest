import Foundation

func gridApplyColumnOrder(_ cols: Any = Optional<Any>.none as Any, _ order: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  let order = specArr(order)
  if (Double(order.count) == 0.0) {
    return cols
  }
  var uniq: Any = order.reduce(([] as [Any])) { { (acc, k) -> Any in
  if specIncludes(acc, k) {
    return acc
  }
  return specConcatValue(acc, ([k] as [Any]))
}($0, $1) }
  var known: Any = (specArr(uniq).filter { specTruthy({ (k) in cols.contains { specTruthy({ (c) in specEq(specGet(c, "key"), k) }($0)) } }($0)) } as Any)
  var ordered: Any = (specArr(known).map { { (k) in cols.first(where: { specTruthy({ (c) in specEq(specGet(c, "key"), k) }($0)) }) }($0) } as Any)
  var rest: Any = (cols.filter { specTruthy({ (c) in !(specIncludes(known, specGet(c, "key"))) }($0)) } as Any)
  return specConcatValue(ordered, rest)
}
