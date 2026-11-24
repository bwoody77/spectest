import Foundation

func _defaultColor(_ i: Any = Optional<Any>.none as Any) -> Any? {
  let i = specDouble(i)
  var colors: Any = ((["#6366f1" as Any, "#10b981" as Any, "#f59e0b" as Any, "#ef4444" as Any, "#3b82f6" as Any, "#8b5cf6" as Any, "#ec4899" as Any, "#14b8a6" as Any, "#f97316" as Any, "#84cc16" as Any] as [Any]) as Any)
  return specGet(colors, i.truncatingRemainder(dividingBy: specLength(colors)))
}
