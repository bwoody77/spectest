import Foundation

func gridSegmentsOf(_ cols: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  return cols.reduce(([] as [Any])) { { (acc, c) -> Any in
  var label: Any = (!specIsNil(specGet(c, "group")) ? specGet(c, "group") : "")
  var n: Any = (specLength(acc) as Any)
  if ((specGt(n, 0.0) && specNeq(label, "")) && specEq(specGet(specGet(acc, (specNum(n) - 1.0)), "label"), label)) {
    var last: Any = specGet(acc, (specNum(n) - 1.0))
    return specConcatValue(specSlice(acc, 0.0, (specNum(n) - 1.0)), ([["label": label, "cols": specConcatValue(specGet(last, "cols"), ([c] as [Any]))] as Any] as [Any]))
  }
  return specConcatValue(acc, ([["label": label, "cols": ([c] as [Any]) as Any] as Any] as [Any]))
}($0, $1) }
}
