import Foundation

func egSizedColumn(_ c: Any = Optional<Any>.none as Any) -> Any? {
  return specMergeMaps([specAsMap(c), ["_heading": egColHeading(c)], ["_min": (!specIsNil(specGet(c, "width")) ? egCssLength(specGet(c, "width")) : ((!specIsNil(specGet(c, "minWidth")) ? egCssLength(specGet(c, "minWidth")) : ("100px" as Any as Any?)) as Any?))], ["_max": (!specIsNil(specGet(c, "width")) ? egCssLength(specGet(c, "width")) : ("100000px" as Any as Any?))]])
}
