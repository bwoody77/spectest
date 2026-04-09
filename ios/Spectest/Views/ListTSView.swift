import SwiftUI
struct ListTSView: View {
  var items: Any = [] as [Any]; var searchable: Any = false; var selection: Any = "none"
  init(items: Any = [] as [Any], searchable: Any = false, selection: Any = "none") { self.items = items; self.searchable = searchable; self.selection = selection }
  var body: some View { Text("ListTS (stub)").foregroundStyle(.secondary) }
}
