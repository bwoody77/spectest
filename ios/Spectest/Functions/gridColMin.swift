import Foundation

func gridColMin(_ col: Any = Optional<Any>.none as Any) -> Any? {
  let col = (col as? [String: Any]) ?? [:]
  if !specIsNil(specGet(col, "width")) {
    return gridCssLength(specGet(col, "width"))
  }
  if !specIsNil(specGet(col, "minWidth")) {
    return gridCssLength(specGet(col, "minWidth"))
  }
  return "100px"
}
