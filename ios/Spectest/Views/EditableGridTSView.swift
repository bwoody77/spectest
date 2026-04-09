import SwiftUI

struct EditableGridTSView: View {
  var activation: Any = "click"
  var columns: Any = [] as [Any]
  var height: Any = ""
  var rows: Any = [] as [Any]
  init(activation: Any = "click", columns: Any = [] as [Any], height: Any = "", rows: Any = [] as [Any]) {
    self.activation = activation; self.columns = columns; self.height = height; self.rows = rows
  }
  var body: some View {
    Text("EditableGridTS (not available on iOS)")
      .foregroundStyle(.secondary)
  }
}
