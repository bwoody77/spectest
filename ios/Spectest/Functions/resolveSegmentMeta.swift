func resolveSegmentMeta(_ data: Any, _ colors: Any, _ labelKey: Any) -> Any? {
  let data = (data as? [Any]) ?? []
  let colors = (colors as? [Any]) ?? []
  let labelKey = specString(labelKey)
  return data.enumerated().map { (i, el) in ({ (d, i) -> Any in
  return ["label": String(describing: (specGet(d, labelKey) ?? i)) as Any, "color": (specGet(colors, i) ?? _defaultColor(i))]
})(el, Double(i)) }
}
