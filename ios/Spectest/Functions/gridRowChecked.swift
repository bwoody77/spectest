import Foundation

func gridRowChecked(_ allMatching: Any = Optional<Any>.none as Any, _ excluded: Any = Optional<Any>.none as Any, _ chosen: Any = Optional<Any>.none as Any, _ key: Any = Optional<Any>.none as Any) -> Any? {
  let allMatching = (allMatching as? Bool) ?? false
  let excluded = specArr(excluded)
  let chosen = specArr(chosen)
  if allMatching {
    return !(specIncludes(excluded, key))
  }
  return specIncludes(chosen, key)
}
