import Foundation

func egSizedColumns(_ cols: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  return cols.map { { (c) in egSizedColumn(c) }($0) }
}
