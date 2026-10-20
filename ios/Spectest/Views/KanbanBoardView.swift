import SwiftUI

struct KanbanBoardView: View {
  var columns: Any = [] as [Any]
  var columnWidth: Any = ""
  var items: Any = [] as [Any]
  var showCount: Any = false
  init(columns: Any = [] as [Any], columnWidth: Any = "", items: Any = [] as [Any], showCount: Any = false) { self.columns = columns; self.columnWidth = columnWidth; self.items = items; self.showCount = showCount }
  var body: some View { Text("KanbanBoard (not available on iOS)").foregroundStyle(.secondary) }
}
