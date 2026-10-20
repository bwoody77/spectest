func resolveSegmentMeta(_ data: Any, _ colors: Any, _ labelKey: Any) -> Any? {
  let data = specArr(data)
  let colors = specArr(colors)
  let labelKey = specString(labelKey)
  return data.enumerated().map { (i, el) in ({ (d, i) -> Any in
  return ["label": String(describing: (specGet(d, labelKey) ?? i)) as Any, "color": (specGet(colors, i) ?? _defaultColor(i))]
})(el, Double(i)) }
}
