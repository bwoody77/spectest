import Foundation

func gridLengthSum(_ lens: Any = Optional<Any>.none as Any, _ extraPx: Any = Optional<Any>.none as Any) -> Any? {
  let lens = specArr(lens)
  let extraPx = specDouble(extraPx)
  var px: Any = lens.filter { specTruthy({ (l) in specGte(gridLenPx(l), 0.0) }($0)) }.reduce(0.0) { { (acc, l) in specAdd(acc, gridLenPx(l)) }($0, $1) }
  var terms: Any = (lens.filter { specTruthy({ (l) in (specLt(gridLenPx(l), 0.0) && !(specTruthy(gridLenIsKeyword(l)))) }($0)) } as Any)
  var total: Any = specAdd(px, extraPx)
  if (specLength(terms) == 0.0) {
    return ((specString(total) + "") + "px")
  }
  var parts: Any = (specNeq(total, 0.0) ? specConcatValue(terms, ([((specString(total) + "") + "px") as Any] as [Any])) : terms)
  if (specLength(parts) == 1.0) {
    return specGet(parts, 0.0)
  }
  return (("calc(" + specJoin(parts, " + ")) + ")")
}
