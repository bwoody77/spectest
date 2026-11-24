import Foundation

func gridWeighCols(_ sized: Any = Optional<Any>.none as Any, _ weigh: Any = Optional<Any>.none as Any) -> Any? {
  let sized = specArr(sized)
  let weigh = (weigh as? [String: Any]) ?? [:]
  if !(specTruthy(specGet(weigh, "on"))) {
    return sized
  }
  return sized.map { { (sc) in gridWithMin(sc, gridWeightedMin(specGet(sc, "_col"), specGet(weigh, "all"), specGet(weigh, "extra"))) }($0) }
}
