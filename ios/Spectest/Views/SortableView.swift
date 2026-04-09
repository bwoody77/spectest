import SwiftUI

struct SortableView: View {
  var badgeColors: Any = [String: Any]()
  var badgeKey: Any = ""
  var gap: Any = ""
  var items: Any = [] as [Any]
  var labelKey: Any = ""
  init(badgeColors: Any = [String: Any](), badgeKey: Any = "", gap: Any = "", items: Any = [] as [Any], labelKey: Any = "") {
    self.badgeColors = badgeColors; self.badgeKey = badgeKey; self.gap = gap; self.items = items; self.labelKey = labelKey
  }
  var body: some View {
    Text("Sortable (not available on iOS)")
      .foregroundStyle(.secondary)
  }
}
