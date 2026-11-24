import Foundation

func resolveSegmentMeta(_ data: Any = Optional<Any>.none as Any, _ colors: Any = Optional<Any>.none as Any, _ labelKey: Any = Optional<Any>.none as Any, _ colorKey: Any = Optional<Any>.none as Any) -> Any? {
  let data = specArr(data)
  let colors = specArr(colors)
  let labelKey = specString(labelKey)
  let colorKey = specString(colorKey)
  return data.enumerated().map { (i, el) in ({ (d, i) -> Any in
  return ["label": specString(specCoalesce(specGet(d, labelKey), i)) as Any, "color": _sliceColor(d, i, colors, colorKey)]
})(el, Double(i)) }
}
