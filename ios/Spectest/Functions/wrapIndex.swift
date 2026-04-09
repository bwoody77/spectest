func wrapIndex(_ index: Any, _ delta: Any, _ len: Any) -> Any {
  if ((len as! Double) <= 0.0) {
    return 0.0
  }
  return (specAdd((specAdd(index, delta) as! Double).truncatingRemainder(dividingBy: (len as! Double)), len) as! Double).truncatingRemainder(dividingBy: (len as! Double))
}
