import Foundation

func gridPctTotal(_ lens: Any = Optional<Any>.none as Any) -> Any? {
  let lens = specArr(lens)
  return lens.filter { specTruthy({ (l) in specGte(gridLenPct(l), 0.0) }($0)) }.reduce(0.0) { { (acc, l) in specAdd(acc, gridLenPct(l)) }($0, $1) }
}
