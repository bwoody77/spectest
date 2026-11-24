import Foundation

func gridColMax(_ col: Any = Optional<Any>.none as Any) -> Any? {
  let col = (col as? [String: Any]) ?? [:]
  if !specIsNil(specGet(col, "width")) {
    return gridCssLength(specGet(col, "width"))
  }
  return "100000px"
}
