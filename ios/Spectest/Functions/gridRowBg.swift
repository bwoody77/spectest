import Foundation

func gridRowBg(_ kind: Any = Optional<Any>.none as Any, _ hovered: Any = Optional<Any>.none as Any, _ chosen: Any = Optional<Any>.none as Any, _ isStriped: Any = Optional<Any>.none as Any, _ odd: Any = Optional<Any>.none as Any, _ paints: Any = Optional<Any>.none as Any, _ base: Any = Optional<Any>.none as Any, _ rowBg: Any = Optional<Any>.none as Any) -> Any? {
  let kind = specString(kind)
  let hovered = (hovered as? Bool) ?? false
  let chosen = (chosen as? Bool) ?? false
  let isStriped = (isStriped as? Bool) ?? false
  let odd = (odd as? Bool) ?? false
  let paints = (paints as? [String: Any]) ?? [:]
  let base = specString(base)
  let rowBg = specString(rowBg)
  if (kind != "row") {
    return specGet(paints, "group")
  }
  if hovered {
    return specGet(paints, "hover")
  }
  if chosen {
    return specGet(paints, "raised")
  }
  if (rowBg != "") {
    return rowBg
  }
  if (isStriped && odd) {
    return specGet(paints, "stripe")
  }
  return base
}
