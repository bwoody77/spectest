import Foundation

func gridWithMin(_ sc: Any = Optional<Any>.none as Any, _ min: Any = Optional<Any>.none as Any) -> Any? {
  let sc = (sc as? [String: Any]) ?? [:]
  let min = specString(min)
  return specMergeMaps([specAsMap(sc), ["_min": min as Any]])
}
