func validateCell(_ value: Any, _ column: Any) -> Any? {
  if ((String(describing: specGet(column, "required")) == String(describing: true)) && (value == nil || (String(describing: value) == String(describing: "")))) {
    var label: Any = (specGet(column, "header") ?? specGet(column, "key"))
    return (String(describing: label) + " is required")
  }
  return nil
}
