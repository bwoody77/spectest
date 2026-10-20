func resolveSeries(_ type: Any, _ series: Any, _ yKey: Any, _ color: Any, _ colors: Any) -> Any? {
  let type = specString(type)
  let series = specArr(series)
  let yKey = specString(yKey)
  let color = specString(color)
  let colors = specArr(colors)
  if ((type == "pie") || (type == "donut")) {
    return ([] as [Any])
  }
  if (series != nil && (Double(series.count) > 0.0)) {
    return series.enumerated().map { (i, el) in ({ (s, i) -> Any in
  return ["key": specGet(s, "key"), "label": (specGet(s, "label") ?? specGet(s, "key")), "color": (specGet(s, "color") ?? (specGet(colors, i) ?? _defaultColor(i))), "dashed": (specGet(s, "dashed") ?? false) as Any]
})(el, Double(i)) }
  }
  var k: Any = ((yKey ?? "y") as Any)
  return [["key": k, "label": k, "color": (color ?? _defaultColor(0.0)), "dashed": false as Any]] as [Any]
}
