import Foundation

func gridGroupSize(_ all: Any = Optional<Any>.none as Any, _ label: Any = Optional<Any>.none as Any) -> Any? {
  let all = specArr(all)
  let label = specString(label)
  if (label == "") {
    return 0.0
  }
  return all.reduce(0.0) { { (acc, c) in specAdd(acc, ((!specIsNil(specGet(c, "group")) && specEq(specGet(c, "group"), label)) ? 1.0 : 0.0)) }($0, $1) }
}
