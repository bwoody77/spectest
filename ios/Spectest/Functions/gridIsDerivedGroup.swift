import Foundation

func gridIsDerivedGroup(_ row: Any = Optional<Any>.none as Any) -> Any? {
  let row = (row as? [String: Any]) ?? [:]
  return (specEq(specGet(row, "_kind"), "group") && specEq(specGet(row, "_derived"), true))
}
