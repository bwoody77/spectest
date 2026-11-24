import Foundation

func gridSizedCols(_ cols: Any = Optional<Any>.none as Any, _ all: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  let all = specArr(all)
  var n: Any = (Double(cols.count) as Any)
  return cols.enumerated().map { (i, el) in ({ (c, i) in ["_col": c, "_min": gridColMin(c), "_max": gridColMax(c), "_gFirst": ((!specIsNil(specGet(c, "group")) && specNeq(specGet(c, "group"), "")) && (specEq(i, 0.0) || specNeq(specGet(cols[Int((specNum(i) - 1.0))], "group"), specGet(c, "group")))) as Any, "_gLast": ((!specIsNil(specGet(c, "group")) && specNeq(specGet(c, "group"), "")) && (specEq(i, (specNum(n) - 1.0)) || specNeq(specGet(specGet(cols, specAdd(i, 1.0)), "group"), specGet(c, "group")))) as Any, "_gSolo": ((!specIsNil(specGet(c, "group")) && specNeq(specGet(c, "group"), "")) && specEq(gridGroupSize(all, specGet(c, "group")), 1.0)) as Any] })(el, Double(i)) }
}
