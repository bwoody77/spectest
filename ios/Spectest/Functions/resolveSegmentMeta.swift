func resolveSegmentMeta(_ data: Any, _ colors: Any, _ labelKey: Any) -> Any {
  return (data as! [Any]).enumerated().map { (i, el) in ({ (d, i) -> Any in
  return ["label": String(describing: ((d as! [String: Any])[(labelKey as! String)] ?? i)) as Any, "color": ((colors as? [String: Any])?[(i as! String)] ?? _defaultColor(i))]
})(el, Double(i)) }
}
