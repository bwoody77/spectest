import Foundation

func gridSegMax(_ seg: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any) -> Any? {
  let seg = (seg as? [String: Any]) ?? [:]
  let rules = (rules as? Bool) ?? false
  let firstKey = specString(firstKey)
  var lens: Any = (specArr(specGet(seg, "cols")).map { { (c) in gridColMax(c) }($0) } as Any)
  var flexible: Any = (specArr(specGet(seg, "cols")).contains { specTruthy({ (c) in specIsNil(specGet(c, "width")) }($0)) } as Any)
  if specTruthy(specOr(flexible, specArr(lens).contains { specTruthy({ (l) in gridLenIsKeyword(l) }($0)) })) {
    return "100000px"
  }
  return gridLengthSum(lens, gridRulePx(specGet(seg, "cols"), rules, firstKey))
}
