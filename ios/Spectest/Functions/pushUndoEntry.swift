import Foundation

func pushUndoEntry(_ stack: Any = Optional<Any>.none as Any, _ entry: Any = Optional<Any>.none as Any, _ maxDepth: Any = Optional<Any>.none as Any) -> Any? {
  let stack = specArr(stack)
  let maxDepth = specDouble(maxDepth)
  var newStack: Any = (specConcat(stack, ([entry] as [Any])) as Any)
  if (specLength(newStack) > maxDepth) {
    return specSlice(newStack, (specLength(newStack) - maxDepth))
  }
  return newStack
}
