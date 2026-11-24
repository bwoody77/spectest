import Foundation

func gridWeighExtra(_ cols: Any = Optional<Any>.none as Any, _ rules: Any = Optional<Any>.none as Any, _ groupRules: Any = Optional<Any>.none as Any, _ firstKey: Any = Optional<Any>.none as Any, _ pinFirst: Any = Optional<Any>.none as Any, _ selection: Any = Optional<Any>.none as Any) -> Any? {
  let cols = specArr(cols)
  let rules = (rules as? Bool) ?? false
  let groupRules = (groupRules as? Bool) ?? false
  let firstKey = specString(firstKey)
  let pinFirst = (pinFirst as? Bool) ?? false
  let selection = specString(selection)
  var brackets: Any = ((groupRules && !(rules)) as Any)
  var pinned: Any = (pinFirst ? gridBracketPx(specSlice(cols, 0.0, 1.0), cols, brackets) : (0.0 as Any as Any?))
  var rest: Any = gridBracketPx((pinFirst ? specSlice(cols, 1.0) : (cols as Any as Any?)), cols, brackets)
  return specAdd(specAdd(specAdd(gridRulePx(cols, rules, firstKey), pinned), rest), ((selection == "multi") ? 40.0 : 0.0))
}
