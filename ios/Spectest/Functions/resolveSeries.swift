func resolveSeries(_ type: Any, _ series: Any, _ yKey: Any, _ color: Any, _ colors: Any) -> Any {
  if ((String(describing: type) == String(describing: "pie")) || (String(describing: type) == String(describing: "donut"))) {
    return []
  }
  if (series != nil && (specLength(series) > 0.0)) {
    return (series as! [Any]).enumerated().map { (i, el) in ({ (s, i) -> Any in
  return ["key": (s as! [String: Any])["key"]!, "label": ((s as! [String: Any])["label"]! ?? (s as! [String: Any])["key"]!), "color": ((s as! [String: Any])["color"]! ?? ((colors as? [String: Any])?[(i as! String)] ?? _defaultColor(i)))]
})(el, Double(i)) }
  }
  var k = (yKey ?? "y")
  return [["key": k as Any, "label": k as Any, "color": (color ?? _defaultColor(0.0))]]
}
