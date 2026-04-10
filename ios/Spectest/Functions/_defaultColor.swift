func _defaultColor(_ i: Any) -> Any? {
  let i = specDouble(i)
  var colors: Any = (["#6366f1", "#10b981", "#f59e0b", "#ef4444", "#3b82f6", "#8b5cf6", "#ec4899", "#14b8a6", "#f97316", "#84cc16"] as [Any] as Any)
  return specGet(colors, i.truncatingRemainder(dividingBy: specLength(colors)))
}
