import Foundation

func gridNonPct(_ lens: Any = Optional<Any>.none as Any) -> Any? {
  let lens = specArr(lens)
  return lens.filter { specTruthy({ (l) in specLt(gridLenPct(l), 0.0) }($0)) }
}
