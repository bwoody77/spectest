import Foundation

func _sliceColor(_ d: Any = Optional<Any>.none as Any, _ i: Any = Optional<Any>.none as Any, _ colors: Any = Optional<Any>.none as Any, _ colorKey: Any = Optional<Any>.none as Any) -> Any? {
  let i = specDouble(i)
  let colors = specArr(colors)
  let colorKey = specString(colorKey)
  if (!specIsNil(colorKey) && (colorKey != "")) {
    var fromDatum: Any = specGet(d, colorKey)
    if (!specIsNil(fromDatum) && (specString(fromDatum) != "")) {
      return specString(fromDatum)
    }
  }
  return specCoalesce(colors[Int(i)], _defaultColor(i))
}
