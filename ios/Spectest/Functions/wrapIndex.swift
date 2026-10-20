func wrapIndex(_ index: Any, _ delta: Any, _ len: Any) -> Any? {
  let index = specDouble(index)
  let delta = specDouble(delta)
  let len = specDouble(len)
  if (len <= 0.0) {
    return 0.0
  }
  return ((index + delta).truncatingRemainder(dividingBy: len) + len).truncatingRemainder(dividingBy: len)
}
