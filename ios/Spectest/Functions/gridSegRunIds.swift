import Foundation

func gridSegRunIds(_ segs: Any = Optional<Any>.none as Any) -> Any? {
  let segs = specArr(segs)
  var runs: Any = segs.reduce(([] as [Any])) { { (acc, s) -> Any in
  var n: Any = (specLength(acc) as Any)
  if specEq(n, 0.0) {
    return ([["label": specGet(s, "label"), "run": 0.0 as Any] as Any] as [Any])
  }
  var prev: Any = specGet(acc, (specNum(n) - 1.0))
  var same: Any = ((specEq(specGet(prev, "label"), "") && specEq(specGet(s, "label"), "")) as Any)
  return specConcatValue(acc, ([["label": specGet(s, "label"), "run": (specTruthy(same) ? specGet(prev, "run") : specAdd(specGet(prev, "run"), 1.0))] as Any] as [Any]))
}($0, $1) }
  return specArr(runs).map { { (r) in specGet(r, "run") }($0) }
}
