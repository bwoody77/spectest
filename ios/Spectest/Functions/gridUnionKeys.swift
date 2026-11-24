import Foundation

func gridUnionKeys(_ chosen: Any = Optional<Any>.none as Any, _ adding: Any = Optional<Any>.none as Any) -> Any? {
  let chosen = specArr(chosen)
  let adding = specArr(adding)
  return specConcat(chosen, adding.filter { specTruthy({ (k) in !(specIncludes(chosen, k)) }($0)) })
}
