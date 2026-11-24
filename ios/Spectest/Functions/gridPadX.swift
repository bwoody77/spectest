import Foundation

func gridPadX(_ pad: Any = Optional<Any>.none as Any) -> Any? {
  let pad = specString(pad)
  var parts: Any = (specSplit(specTrim(pad), " ").filter { specTruthy({ (p) in specNeq(p, "") }($0)) } as Any)
  if (specLength(parts) < 2.0) {
    return pad
  }
  return specGet(parts, 1.0)
}
