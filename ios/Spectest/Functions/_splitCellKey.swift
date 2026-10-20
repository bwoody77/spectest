func _splitCellKey(_ ck: Any) -> Any? {
  let ck = specString(ck)
  var i: Any = (specIndexOf(ck, "::") as Any)
  return [specSlice(ck, 0.0, i), specSlice(ck, specAdd(i, 2.0))] as [Any]
}
