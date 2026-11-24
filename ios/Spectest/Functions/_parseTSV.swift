import Foundation

func _parseTSV(_ text: Any = Optional<Any>.none as Any) -> Any? {
  let text = specString(text)
  return specSplit(text, "\n").filter { specTruthy({ (line) in (specLength(line) > 0.0) }($0)) }.map { { (line) in specSplit(specString(line), "\t") }($0) }
}
