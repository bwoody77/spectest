import Foundation

func gridIsWeighted(_ cols: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  if cols.contains { specTruthy({ (c) in specAnd(specIsNil(specGet(c, "width")), gridLenIsKeyword(gridColMin(c))) }($0)) } {
    return false
  }
  return cols.contains { specTruthy({ (c) in (specIsNil(specGet(c, "width")) && !specIsNil(specGet(c, "grow"))) }($0)) }
}
