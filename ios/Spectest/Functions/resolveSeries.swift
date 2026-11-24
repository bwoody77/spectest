import Foundation

func resolveSeries(_ type: Any = Optional<Any>.none as Any, _ series: Any = Optional<Any>.none as Any, _ yKey: Any = Optional<Any>.none as Any, _ color: Any = Optional<Any>.none as Any, _ colors: Any = Optional<Any>.none as Any) -> Any? {
  let type = specString(type)
  let series = specArr(series)
  let yKey = specString(yKey)
  let color = specString(color)
  let colors = specArr(colors)
  if ((type == "pie") || (type == "donut")) {
    return ([] as [Any])
  }
  if (!specIsNil(series) && (Double(series.count) > 0.0)) {
    return series.enumerated().map { (i, el) in ({ (s, i) -> Any in
  return ["key": specGet(s, "key"), "label": specCoalesce(specGet(s, "label"), specGet(s, "key")), "color": specCoalesce(specGet(s, "color"), specCoalesce(specGet(colors, i), _defaultColor(i))), "dashed": specCoalesce(specGet(s, "dashed"), false)]
})(el, Double(i)) }
  }
  var k: Any = specCoalesce(yKey, "y")
  return ([["key": k, "label": k, "color": specCoalesce(color, _defaultColor(0.0)), "dashed": false as Any] as Any] as [Any])
}
