func _parseTSV(_ text: Any) -> Any? {
  let text = specString(text)
  return text.components(separatedBy: "n").filter { { line in (specLength(line) > 0.0) }($0) as! Bool }.map { { line in (line as! String).components(separatedBy: "t") }($0) }
}
