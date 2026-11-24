import Foundation

func gridPctSized(_ sc: Any = Optional<Any>.none as Any, _ pct: Any = Optional<Any>.none as Any, _ rest: Any = Optional<Any>.none as Any) -> Any? {
  let sc = (sc as? [String: Any]) ?? [:]
  let pct = specDouble(pct)
  let rest = specString(rest)
  return specMergeMaps([specAsMap(sc), ["_min": (specGte(gridLenPct(specGet(sc, "_min")), 0.0) ? gridPctShare(gridLenPct(specGet(sc, "_min")), pct, rest) : (specGet(sc, "_min") as Any?))], ["_max": (specGte(gridLenPct(specGet(sc, "_max")), 0.0) ? gridPctShare(gridLenPct(specGet(sc, "_max")), pct, rest) : (specGet(sc, "_max") as Any?))]])
}
