import Foundation

func gridFocusedRow(_ isWindowed: Any = Optional<Any>.none as Any, _ rendered: Any = Optional<Any>.none as Any, _ shown: Any = Optional<Any>.none as Any, _ start: Any = Optional<Any>.none as Any, _ idx: Any = Optional<Any>.none as Any) -> Any? {
  let isWindowed = (isWindowed as? Bool) ?? false
  let rendered = specArr(rendered)
  let shown = specArr(shown)
  let start = specDouble(start)
  let idx = specDouble(idx)
  if !(isWindowed) {
    return shown[Int(idx)]
  }
  var rel: Any = ((idx - start) as Any)
  if specLt(rel, 0.0) {
    return nil
  }
  if specGte(rel, specGet(rendered, "length")) {
    return nil
  }
  return specGet(rendered, rel)
}
