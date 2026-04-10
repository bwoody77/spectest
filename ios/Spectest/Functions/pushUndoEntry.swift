func pushUndoEntry(_ stack: Any, _ entry: Any, _ maxDepth: Any) -> Any? {
  let stack = (stack as? [Any]) ?? []
  let maxDepth = specDouble(maxDepth)
  var newStack: Any = (stack + [entry] as [Any] as Any)
  if (specLength(newStack) > maxDepth) {
    return specSlice(newStack, (specLength(newStack) - maxDepth))
  }
  return newStack
}
